import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/data/provider/shared.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/quiz/edit.dart';
import 'package:booqs_mobile/components/quiz/item/detail_button.dart';
import 'package:booqs_mobile/components/sentence/item/edit_button.dart';
import 'package:booqs_mobile/components/word/item/edit_button.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizItemEditButton extends ConsumerWidget {
  const QuizItemEditButton({Key? key, required this.quiz, this.isShow = false})
      : super(key: key);
  final Quiz quiz;
  final bool isShow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isEditing = ref.watch(sharedEditingContentProvider);
    final String locale = ref.watch(localeProvider);
    final String url = '${DiQtURL.root(locale: locale)}/quizzes/${quiz.id}';

    Widget editButton() {
      return Container(
        // 左寄せ
        alignment: Alignment.topLeft,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black54,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: () {
            if (isEditing) {
              WebPageLauncher.openByExternalBrowser('$url/edit');
            } else {
              QuizEditPage.push(context, quiz.id);
            }
          },
          child: Text(
            t.quizzes.edit,
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    Widget detailButton() {
      if (isShow) return Container();
      return QuizItemDetailButton(quiz: quiz);
    }

    Widget sourceEditButton() {
      final Word? word = quiz.word;
      final Sentence? sentence = quiz.sentence;
      if (word != null) {
        return WordItemEditButton(word: word, isShow: isShow);
      }
      if (sentence != null) {
        return SentenceItemEditButton(sentence: sentence, isShow: isShow);
      }
      return Container();
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [editButton(), detailButton()],
      ),
      sourceEditButton()
    ]);
  }
}
