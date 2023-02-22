import 'package:booqs_mobile/components/sentence/review_button.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/review/large_setting_button.dart';
import 'package:booqs_mobile/components/sentence/edit_button.dart';
import 'package:booqs_mobile/components/sentence/tts_button.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/components/word/item/label.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../sentence/item.dart';

class WordItemSentence extends StatelessWidget {
  const WordItemSentence({
    Key? key,
    required this.word,
  }) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    final Sentence? sentence = word.sentence;
    if (sentence == null) {
      return Container();
    }

    Widget reviewButton() {
      // サーバーサイドのWord#json_for_native_app と Word#json_for_searchのどちらの取得でも対応できるようにする。
      final Quiz? quiz = sentence.quiz ?? word.sentenceQuiz;
      if (quiz == null) return const Text('Quiz does not exist.');
      final Review? review = quiz.review ?? word.sentenceReview;
      return SentenceReviewButton(
        quizId: quiz.id,
        review: review,
        speaking: false,
      );
    }

    Widget speakingReviewButton() {
      final Quiz? quiz = sentence.speakingQuiz ?? word.sentenceSpeakingQuiz;
      if (quiz == null) return Container();
      final Review? review = quiz.review ?? word.sentenceSpeakingReview;
      return SentenceReviewButton(
        quizId: quiz.id,
        review: review,
        speaking: true,
      );
    }

    return DottedBorder(
      color: Colors.black54,
      strokeWidth: 1,
      padding: const EdgeInsets.only(top: 10, bottom: 16, left: 16, right: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //
        SentenceItem(sentence: sentence),

        const SizedBox(height: 24),
        reviewButton(),
        const SizedBox(height: 16),
        speakingReviewButton(),
        SentenceEditButton(
          sentence: sentence,
          isShow: false,
        ),
      ]),
    );
  }
}
