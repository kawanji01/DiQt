import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/components/chapter/card.dart';
import 'package:flutter/material.dart';

class ChapterCardList extends StatelessWidget {
  const ChapterCardList({Key? key, required this.chapters}) : super(key: key);
  final List<Chapter> chapters;

  @override
  Widget build(BuildContext context) {
    if (chapters.isEmpty) return Container();

    final List<Widget> chapterList = [];
    for (Chapter chapter in chapters) {
      chapterList.add(ChapterCard(chapter: chapter));
    }
    // 一番下に広告を差し込む
    chapterList.add(const AppBanner());
    return Column(
      children: chapterList,
    );
  }
}
