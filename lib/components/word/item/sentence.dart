import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/review/large_setting_button.dart';
import 'package:booqs_mobile/components/sentence/edit_button.dart';
import 'package:booqs_mobile/components/sentence/tts_button.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/components/word/item/label.dart';
import 'package:flutter/material.dart';

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
    // サーバーサイドのWord#json_for_native_app と Word#json_for_searchのどちらの取得でも対応できるようにする。
    final Quiz? quiz = sentence.quiz ?? word.sentenceQuiz;
    if (quiz == null) return const Text('Quiz does not exist.');
    final Review? review = quiz.review ?? word.sentenceReview;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 24),
      const WordItemLabel(text: '例文'),
      const SizedBox(height: 8),
      TextWithDictLink(
        text: sentence.original,
        langNumber: sentence.langNumberOfOriginal,
        dictionaryId: sentence.dictionaryId,
        autoLinkEnabled: true,
        crossAxisAlignment: CrossAxisAlignment.start,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontColor: Colors.black87,
        selectable: true,
      ),
      SentenceTTSButton(sentence: sentence),
      const SizedBox(height: 8),
      Text(sentence.translation,
          style: const TextStyle(
              fontSize: 16, height: 1.6, color: Colors.black87)),
      const SizedBox(height: 24),
      ReviewLargeSettingButton(quizId: quiz.id, review: review),
      SentenceEditButton(
        sentence: sentence,
        isShow: false,
      ),
      const SizedBox(height: 24),
    ]);
  }
}
