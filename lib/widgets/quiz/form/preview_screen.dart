import 'package:booqs_mobile/widgets/quiz/form/preview_correct_answer.dart';
import 'package:booqs_mobile/widgets/quiz/form/preview_distractors.dart';
import 'package:booqs_mobile/widgets/quiz/form/preview_question.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/markdown_with_diqt_link.dart';
import 'package:flutter/material.dart';

class QuizFormPreviewScreen extends StatelessWidget {
  const QuizFormPreviewScreen(
      {Key? key,
      required this.question,
      required this.langNumberOfQuestion,
      required this.correctAnswer,
      required this.langNumberOfAnswer,
      required this.distractor1,
      required this.distractor2,
      required this.distractor3,
      required this.hint,
      required this.explanation,
      required this.autoDictLinkOfQuestion,
      required this.autoDictLinkOfAnswer,
      required this.dictionaryId})
      : super(key: key);
  final String question;
  final int langNumberOfQuestion;
  final String correctAnswer;
  final int langNumberOfAnswer;
  final String distractor1;
  final String distractor2;
  final String distractor3;
  final String hint;
  final String explanation;
  final bool autoDictLinkOfQuestion;
  final bool autoDictLinkOfAnswer;
  final int dictionaryId;

  @override
  Widget build(BuildContext context) {
    const heading = Text('問題のプレビュー',
        style: TextStyle(
            fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold));

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
          QuizFormPreviewQuestion(
              question: question,
              langNumberOfQuestion: langNumberOfQuestion,
              autoDictLinkOfQuestion: autoDictLinkOfQuestion,
              dictionaryId: dictionaryId),
          const SizedBox(
            height: 32,
          ),
          QuizFormPreviewCorrectAnswer(
              correctAnswer: correctAnswer,
              langNumberOfAnswer: langNumberOfAnswer,
              dictionaryId: dictionaryId,
              autoDictLinkOfAnswer: autoDictLinkOfAnswer),
          const SizedBox(
            height: 32,
          ),
          QuizFormPreviewDistractors(
            distractor1: distractor1,
            distractor2: distractor2,
            distractor3: distractor3,
            dictionaryId: dictionaryId,
            langNumberOfAnswer: langNumberOfAnswer,
            autoDictLinkOfAnswer: autoDictLinkOfAnswer,
          ),
          const SizedBox(
            height: 32,
          ),
          const SharedItemLabel(text: 'ヒント'),
          MarkdownWithDictLink(
            text: hint,
            dictionaryId: dictionaryId,
            textStyle: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 32,
          ),
          const SharedItemLabel(text: '解説'),
          MarkdownWithDictLink(
            text: explanation,
            dictionaryId: dictionaryId,
            textStyle: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      )),
    );
  }
}
