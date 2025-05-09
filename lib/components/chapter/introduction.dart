import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';

class ChapterIntroduction extends StatelessWidget {
  const ChapterIntroduction({super.key, required this.chapter});
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    if (chapter.introduction == '') return Container();

    final introduction = Text(chapter.introduction,
        style: const TextStyle(fontSize: 16, color: Colors.black87));

    Widget reference() {
      final String? url = chapter.referenceUrl;
      if (url == null || url == '') return Container();
      final String? title = chapter.referenceTitle;
      if (title == null || title == '') return Container();

      return InkWell(
        onTap: () {
          WebPageLauncher.openByExternalBrowser(url);
        },
        child: Container(
            margin: const EdgeInsets.only(top: 32),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black45)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                Text(
                  t.chapters.external_reference_link,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            )),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          chapter.title,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        introduction,
        reference()
      ],
    );
  }
}
