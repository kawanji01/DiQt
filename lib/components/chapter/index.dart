import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/chapter.dart';
import 'package:booqs_mobile/components/chapter/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterIndex extends ConsumerWidget {
  const ChapterIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final List<Chapter> chapters = ref.watch(chaptersProvider);
    final future = ref.watch(asyncChaptersProvider);

    return SingleChildScrollView(
      child: Container(
        child: future.when(
          error: (err, stack) => Text('Error: $err'),
          data: (chapters) => ChapterCardList(chapters: chapters),
          loading: () => const LoadingSpinner(),
        ),
      ),
    );
  }
}
