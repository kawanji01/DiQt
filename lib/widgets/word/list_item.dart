import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/review/large_setting_button.dart';
import 'package:booqs_mobile/widgets/word/edit_button.dart';
import 'package:booqs_mobile/widgets/word/entry.dart';
import 'package:booqs_mobile/widgets/word/explanation.dart';
import 'package:booqs_mobile/widgets/word/meaning.dart';
import 'package:booqs_mobile/widgets/word/sentence.dart';
import 'package:booqs_mobile/widgets/word/tag_buttons.dart';
import 'package:flutter/material.dart';

class WordListItem extends StatelessWidget {
  const WordListItem({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    Widget _reviewButton() {
      final Quiz? quiz = word.quiz;
      if (quiz == null) return const Text('Quiz does not exist.');
      final Review? review = quiz.review;
      return ReviewLargeSettingButton(quizId: quiz.id, review: review);
    }

    Widget _content() {
      return Column(children: <Widget>[
        WordTagButtons(tags: word.tags),
        const SizedBox(height: 10),
        WordEntry(word: word),
        const SizedBox(
          height: 10,
        ),
        WordMeaning(word: word),
        const SizedBox(
          height: 24,
        ),
        _reviewButton(),
        WordExplanation(word: word),
        WordSentence(word: word),
        WordEditButton(
          word: word,
          isShow: false,
        ),
      ]);
    }

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 24), child: _content());
  }
}
