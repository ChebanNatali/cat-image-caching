import 'dart:io';
import 'package:catimage/features/domain/entities/cat_entity.dart';
import 'package:catimage/features/presentation/bloc/history/history_bloc.dart';
import 'package:catimage/features/presentation/bloc/history/history_state.dart';
import 'package:catimage/features/presentation/pages/fullscreen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('История'),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HistoryLoaded && state.items.isEmpty) {
            return const Center(child: Text('История пуста'));
          }
          if (state is HistoryLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final cat = state.items[index];
                return _HistoryItem(cat: cat);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final CatEntity cat;

  const _HistoryItem({required this.cat});

  void _openFullscreen(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => FullscreenPage(cat: cat)),
      );

  void _openInBrowser() => launchUrl(
        Uri.parse(cat.url),
        mode: LaunchMode.externalApplication,
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
            child: Image.file(
              File(cat.localPath!),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cat.id,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _openFullscreen(context),
                        child: const Text('Увеличить'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _openInBrowser,
                        child: const Text('В браузере'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
