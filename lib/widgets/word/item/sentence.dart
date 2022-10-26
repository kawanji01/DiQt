import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/widgets/review/large_setting_button.dart';
import 'package:booqs_mobile/widgets/sentence/edit_button.dart';
import 'package:booqs_mobile/widgets/sentence/tts_button.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/widgets/word/item/label.dart';
import 'package:flutter/material.dart';

class WordItemSentence extends StatelessWidget {
  const WordItemSentence(
      {Key? key,
      required this.sentence,
      required this.quizId,
      required this.review})
      : super(key: key);
  final Sentence? sentence;
  final int? quizId;
  final Review? review;

  @override
  Widget build(BuildContext context) {
    if (sentence == null) {
      return Container();
    }

    Widget _reviewButton() {
      if (quizId == null) return const Text('Quiz does not exist.');

      return ReviewLargeSettingButton(quizId: quizId!, review: review);
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 24),
      const WordItemLabel(text: '例文'),
      const SizedBox(height: 8),
      TextWithDictLink(
        text: sentence!.original,
        langNumber: sentence!.langNumberOfOriginal,
        dictionaryId: sentence!.dictionaryId,
        autoLinkEnabled: true,
        crossAxisAlignment: CrossAxisAlignment.start,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontColor: Colors.black87,
        selectable: true,
      ),
      SentenceTTSButton(sentence: sentence!),
      const SizedBox(height: 8),
      Text(sentence!.translation,
          style: const TextStyle(
              fontSize: 16, height: 1.6, color: Colors.black87)),
      const SizedBox(height: 24),
      _reviewButton(),
      SentenceEditButton(
        sentence: sentence!,
        isShow: false,
      ),
      const SizedBox(height: 24),
    ]);
  }
}
