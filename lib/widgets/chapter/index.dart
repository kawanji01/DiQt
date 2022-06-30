import 'package:booqs_mobile/data/provider/chapter.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/widgets/chapter/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterIndex extends ConsumerWidget {
  const ChapterIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Chapter> _chapters = ref.watch(chaptersProvider);
    final future = ref.watch(asyncChaptersProvider);

    return SingleChildScrollView(
      child: Container(
        child: future.when(
          loading: () => ChapterCardList(chapters: _chapters),
          error: (err, stack) => Text('Error: $err'),
          data: (data) => ChapterCardList(chapters: data),
        ),
      ),
    );
  }
}
