import 'dart:io';
import 'package:catimage/core/core.dart';
import 'package:catimage/features/presentation/bloc/today/today_bloc.dart';
import 'package:catimage/features/presentation/bloc/today/today_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodayTab extends StatelessWidget {
  const TodayTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Core.colors.backgroundColor,
        title: const Text('Сегодня'),
      ),
      body: BlocBuilder<TodayBloc, TodayState>(
        builder: (context, state) {
          return _buildContent(state);
        },
      ),
    );
  }

  Widget _buildContent(TodayState state) {
    if (state is TodayLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is TodayLoaded && state.cat.localPath != null) {
      return Column(
        children: [
          _DownloadedAtBadge(downloadedAt: state.cat.downloadedAt),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(state.cat.localPath!),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      );
    }
    if (state is TodayError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            state.message,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return Container();
  }
}

class _DownloadedAtBadge extends StatelessWidget {
  final DateTime? downloadedAt;

  const _DownloadedAtBadge({required this.downloadedAt});

  @override
  Widget build(BuildContext context) {
    if (downloadedAt == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        children: [
          Icon(Icons.access_time, size: 14, color: Core.colors.mainColor),
          const SizedBox(width: 4),
          Text(
            Core.utils.formatDateTimeWithTime(downloadedAt!),
            style: TextStyle(fontSize: 13, color: Core.colors.mainColor),
          ),
        ],
      ),
    );
  }
}
