import 'package:booqs_mobile/data/provider/chapter.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/widgets/chapter/chapter_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterIndex extends ConsumerWidget {
  const ChapterIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Chapter>? _chapters = ref.watch(chaptersProvider);
    final future = ref.watch(asyncChaptersProvider);

    Widget _chapterList(chapters) {
      if (chapters == null) return Container();

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

    return SingleChildScrollView(
      child: Container(
        child: future.when(
          loading: () => _chapterList(_chapters),
          error: (err, stack) => Text('Error: $err'),
          data: (data) => _chapterList(data),
        ),
      ),
    );
  }
}
