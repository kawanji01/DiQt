import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/quiz/edit.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizShowActionButtons extends ConsumerWidget {
  const QuizShowActionButtons({super.key, required this.quizId});
  final int? quizId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    if (quizId == null) {
      return Container();
    }
    Future pushPopup(int value, int quizId) async {
      switch (value) {
        case 0:
          // 項目を編集する
          QuizEditPage.push(context, quizId);
          break;
        case 1:
          // Webで開く
          WebPageLauncher.openByWebView(
              '${DiQtURL.root(locale: locale)}/quizzes/$quizId');
          break;
      }
    }

    // PopupMenuButton 参考： https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
    return PopupMenuButton(
      onSelected: (int newValue) {
        pushPopup(newValue, quizId!);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 0,
          child: Text(
            t.quizzes.edit,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Text(
            t.dictionaries.open_by_web,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
