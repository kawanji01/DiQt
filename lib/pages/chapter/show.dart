import 'package:booqs_mobile/data/provider/chapter.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/pages/chapter/school.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/chapter/drills.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterShowPage extends ConsumerWidget {
  const ChapterShowPage({Key? key}) : super(key: key);

  // メモ：遷移の処理は、いちいち描き直す必要はないので、createStateの上に置く。
  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(chapterShowPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Chapter? chapter = ref.watch(chapterProvider);
    if (chapter == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Chapters'),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 32),
            child: const Text("Chapters doesn't exists."),
          ),
        ),
        bottomNavigationBar: const BottomNavbar(),
      );
    }
    if (chapter.school) {
      return const ChapterSchoolPage();
    }
    return Scaffold(
      appBar: const EmptyAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context),
        ),
        child: const ChapterDrills(),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
