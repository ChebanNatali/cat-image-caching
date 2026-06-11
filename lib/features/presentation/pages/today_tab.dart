import 'dart:io';
import 'package:catimage/core/core.dart';
import 'package:catimage/features/presentation/bloc/today/today_bloc.dart';
import 'package:catimage/features/presentation/bloc/today/today_event.dart';
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
          return Column(
            children: [
              Expanded(child: _buildContent(state)),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is TodayLoading
                        ? null
                        : () => context
                            .read<TodayBloc>()
                            .add(const FetchNewCatEvent()),
                    child: const Text('Загрузить котика'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(TodayState state) {
    if (state is TodayLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is TodayLoaded && state.cat.localPath != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(state.cat.localPath!),
            fit: BoxFit.contain,
          ),
        ),
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
    return Center(
      child: Text(
        'Нажмите кнопку,\nчтобы загрузить котика',
        style: TextStyle(
          fontSize: 16,
          color: Core.colors.textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
