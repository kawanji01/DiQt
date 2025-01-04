import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/data/provider/shared.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/pages/quiz/show.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizItemDetailButton extends ConsumerWidget {
  const QuizItemDetailButton({super.key, required this.quiz});
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isEditing = ref.watch(sharedEditingContentProvider);
    final String locale = ref.watch(localeProvider);
    final String url = '${DiQtURL.root(locale: locale)}/quizzes/${quiz.id}';
    return Container(
      // 左寄せ
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black54,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          textStyle: const TextStyle(fontSize: 15),
        ),
        onPressed: () {
          if (isEditing) {
            WebPageLauncher.openByExternalBrowser(url);
          } else {
            QuizShowPage.push(context, quiz.id);
          }
        },
        child: Text(
          t.shared.details,
          style: const TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
