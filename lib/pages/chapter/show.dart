import 'package:booqs_mobile/components/chapter/show.dart';
import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/data/provider/chapter.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterShowPage extends ConsumerWidget {
  const ChapterShowPage({super.key});

  // メモ：遷移の処理は、いちいち描き直す必要はないので、createStateの上に置く。
  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(chapterShowPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Chapter? chapter = ref.watch(chapterProvider);
    if (chapter == null) {
      return Scaffold(
        appBar: AppBarDefault(
          title: t.chapters.chapters,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 32),
            child: Text(t.shared.no_items_found(name: t.chapters.chapters)),
          ),
        ),
        bottomNavigationBar: const BottomNavbar(),
      );
    }

    return Scaffold(
      appBar: AppBarDefault(
        title: chapter.title,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context),
        ),
        child: SingleChildScrollView(
          child: ref.watch(asyncChapterFamily(chapter.publicUid)).when(
                loading: () => ChapterShow(chapter: chapter),
                error: (err, stack) => Text('Error: $err'),
                data: (updatedChapter) {
                  if (updatedChapter == null) {
                    return Text(
                        t.shared.no_items_found(name: t.chapters.chapters));
                  }
                  return ChapterShow(chapter: updatedChapter);
                },
              ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
