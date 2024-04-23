import 'package:booqs_mobile/components/ad/banner.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/components/chapter/card.dart';
import 'package:flutter/material.dart';

class ChapterCardList extends StatelessWidget {
  const ChapterCardList({Key? key, required this.chapters}) : super(key: key);
  final List<Chapter> chapters;

  @override
  Widget build(BuildContext context) {
    if (chapters.isEmpty) {
      return Container(
          margin: const EdgeInsets.only(top: 32),
          child: Text(
            t.shared.no_items_found(name: t.chapters.chapters),
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ));
    }

    final List<Widget> chapterList = [];
    for (Chapter chapter in chapters) {
      chapterList.add(ChapterCard(chapter: chapter));
    }
    // 一番下に広告を差し込む
    chapterList.add(const AdBanner());
    return Column(
      children: chapterList,
    );
  }
}
