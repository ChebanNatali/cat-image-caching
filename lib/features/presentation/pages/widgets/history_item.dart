import 'dart:io';
import 'package:catimage/core/core.dart';
import 'package:catimage/features/domain/entities/cat_entity.dart';
import 'package:catimage/features/presentation/pages/fullscreen_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryItem extends StatelessWidget {
  final CatEntity cat;

  const HistoryItem({super.key, required this.cat});

  void _openFullscreen(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => FullscreenPage(cat: cat)),
  );

  void _openInBrowser() =>
      launchUrl(Uri.parse(cat.url), mode: LaunchMode.externalApplication);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Core.constants.paddingH12V6,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
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
                if (cat.downloadedAt != null)
                  Text(
                    Core.utils.formatDateTimeWithTime(cat.downloadedAt!),
                    style: Core.theme.text.downloadedAtLabel,
                  ),
                Text(
                  cat.id,
                  style: Core.theme.text.historyItemId,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _openFullscreen(context),
                        child: Text(
                          'Увеличить',
                          style: Core.theme.text.bold60013,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _openInBrowser,
                        child: Text(
                          'В браузере',
                          style: Core.theme.text.bold60013,
                        ),
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
