import 'package:booqs_mobile/data/provider/chapter.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/components/chapter/introduction.dart';
import 'package:booqs_mobile/components/drill/feed.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterDrills extends ConsumerStatefulWidget {
  const ChapterDrills({super.key});

  @override
  ChapterDrillsState createState() => ChapterDrillsState();
}

class ChapterDrillsState extends ConsumerState<ChapterDrills> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(asynChapterDrillsProvider);
      ref.invalidate(asyncChapterExamDrillsProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Chapter? chapter = ref.watch(chapterProvider);
    final drillFuture = ref.watch(asynChapterDrillsProvider);
    final examFuture = ref.watch(asyncChapterExamDrillsProvider);
    //
    Widget buildDrillsCards() {
      return drillFuture.when(
          loading: () => const LoadingSpinner(),
          error: (err, stack) => Text('Error: $err'),
          data: (drills) => drills == null || drills.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    Text(
                      t.chapters.drill,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DrillFeed(drills: drills)
                  ],
                ));
    }

    Widget buildExamDrillsCards() {
      return examFuture.when(
          loading: () => const LoadingSpinner(),
          error: (err, stack) => Text('Error: $err'),
          data: (drills) => drills == null || drills.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    Text(
                      '試験',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DrillFeed(drills: drills)
                  ],
                ));
    }

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            ChapterIntroduction(chapter: chapter!),
            const SizedBox(
              height: 40,
            ),
            buildExamDrillsCards(),
            buildDrillsCards(),
          ],
        ),
      ),
    );
  }
}
