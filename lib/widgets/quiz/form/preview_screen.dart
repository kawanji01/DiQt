import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/quiz/form/preview_distractors.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/text_with_link.dart';
import 'package:flutter/material.dart';

class QuizFormPreviewScreen extends StatelessWidget {
  const QuizFormPreviewScreen(
      {Key? key,
      required this.question,
      required this.langNumberOfQuestion,
      required this.correctAnswer,
      required this.langNumberOfAnswer,
      required this.distractors,
      required this.hint,
      required this.explanation,
      required this.dictionary})
      : super(key: key);
  final String question;
  final int langNumberOfQuestion;
  final String correctAnswer;
  final int langNumberOfAnswer;
  final String distractors;
  final String hint;
  final String explanation;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    const heading = Text('問題のプレビュー',
        style: TextStyle(
            fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold));

    Widget _questionText() {
      if (dictionary.langNumberOfEntry == langNumberOfQuestion) {
        return TextWithLink(
          text: hint,
          autoLinkEnabled: false,
          crossAxisAlignment: CrossAxisAlignment.start,
          dictionaryId: dictionary.id,
        );
      } else {
        return Text(question,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ));
      }
    }

    Widget _answerText() {
      if (dictionary.langNumberOfEntry == langNumberOfAnswer) {
        return TextWithLink(
          text: hint,
          autoLinkEnabled: false,
          crossAxisAlignment: CrossAxisAlignment.start,
          dictionaryId: dictionary.id,
        );
      } else {
        return Text(correctAnswer,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold));
      }
    }

    return Container(
      height: 640,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          heading,
          const SizedBox(
            height: 16,
          ),
          const SharedItemLabel(text: '問題'),
          const SizedBox(
            height: 16,
          ),
          _questionText(),
          const SizedBox(
            height: 32,
          ),
          const SharedItemLabel(text: '正解'),
          const SizedBox(
            height: 16,
          ),
          _answerText(),
          const SizedBox(
            height: 32,
          ),
          QuizFormPreviewDistractors(distractors: distractors),
          const SharedItemLabel(text: 'ヒント'),
          TextWithLink(
            text: hint,
            autoLinkEnabled: false,
            crossAxisAlignment: CrossAxisAlignment.start,
            dictionaryId: dictionary.id,
          ),
          const SizedBox(
            height: 32,
          ),
          const SharedItemLabel(text: '解説'),
          TextWithLink(
            text: explanation,
            autoLinkEnabled: false,
            crossAxisAlignment: CrossAxisAlignment.start,
            dictionaryId: dictionary.id,
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      )),
    );
  }
}
