import 'package:booqs_mobile/data/provider/chapter.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/pages/chapter/show.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChapterCard extends ConsumerWidget {
  const ChapterCard({super.key, required this.chapter});
  final Chapter chapter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1,000のようなdelimiterを使って解答数を整形する。参考： https://stackoverflow.com/questions/62580280/how-to-format-numbers-as-thousands-separators-in-dart
    final formatter = NumberFormat('#,###,000');
    final answerHistoriesCount = formatter.format(chapter.answerHistoriesCount);

    // Chapterページに遷移
    Future moveToChapterPage(chapter) async {
      ref.read(chapterProvider.notifier).state = chapter;
      await ChapterShowPage.push(context);
    }

    // カードデザインの参考： https://material.io/components/cards/flutter
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.green.withAlpha(30),
        onTap: () {
          moveToChapterPage(chapter);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(chapter.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: (chapter.answerHistoriesCount ?? 0) > 10000
                  ? Text(
                      t.drills.answers(number: answerHistoriesCount),
                      style:
                          TextStyle(color: Colors.black.withValues(alpha: 0.6)),
                    )
                  : null,
            ),
            CachedNetworkImage(
              imageUrl: chapter.thumbnailUrl,
              placeholder: (context, url) => Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0, left: 16, top: 16, bottom: 32),
              child: Text(
                chapter.introduction,
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
