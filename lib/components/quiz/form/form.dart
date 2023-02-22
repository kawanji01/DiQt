import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/pages/sentence/edit.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:booqs_mobile/components/markdown/introduction_text_button.dart';
import 'package:booqs_mobile/components/quiz/form/distractor.dart';
import 'package:booqs_mobile/components/quiz/form/preview_button.dart';
import 'package:flutter/material.dart';

class QuizForm extends StatelessWidget {
  const QuizForm({
    Key? key,
    required this.questionController,
    required this.correctAnswerController,
    required this.distractor1Controller,
    required this.distractor2Controller,
    required this.distractor3Controller,
    required this.explanationController,
    required this.hintController,
    required this.appliedDictionaryIdController,
    required this.quiz,
  }) : super(key: key);

  final TextEditingController questionController;
  final TextEditingController correctAnswerController;
  final TextEditingController distractor1Controller;
  final TextEditingController distractor2Controller;
  final TextEditingController distractor3Controller;
  final TextEditingController explanationController;
  final TextEditingController hintController;
  final TextEditingController appliedDictionaryIdController;
  final Quiz? quiz;

  @override
  Widget build(BuildContext context) {
    final int langNumberOfQuestion = quiz?.langNumberOfQuestion ?? 0;
    final int langNumberOfAnswer = quiz?.langNumberOfAnswer ?? 0;
    bool autoDictLinkOfQuestion;
    bool autoDictLinkOfAnswer;
    bool isConnectedToWord;
    bool isConnectedToSentence;
    if (quiz == null) {
      autoDictLinkOfQuestion = false;
      autoDictLinkOfAnswer = false;
      isConnectedToWord = false;
      isConnectedToSentence = false;
    } else {
      autoDictLinkOfQuestion = quiz!.autoDictLinkOfQuestion;
      autoDictLinkOfAnswer = quiz!.autoDictLinkOfAnswer;
      isConnectedToWord = quiz!.wordId != null || quiz!.referenceWordId != null;
      isConnectedToSentence = quiz!.sentenceId != null;
    }

    // 問題に紐づいている辞書の項目や例文への編集ボタン
    Widget buttonToEditRoot() {
      if (isConnectedToWord) {
        final int? wordId = quiz?.wordId ?? quiz?.referenceWordId;
        if (wordId == null) return Container();
        return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 0, top: 16),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () => WordEditPage.push(context, wordId),
          child: const Text('この問題と答えを編集するには、項目の編集が必要です。',
              style: TextStyle(color: Colors.green)),
        );
      }

      if (isConnectedToSentence) {
        final int? sentenceId = quiz?.sentenceId;
        if (sentenceId == null) return Container();
        return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 0, top: 16),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () => SentenceEditPage.push(context, sentenceId),
          child: const Text('この問題と答えを編集するには、例文の編集が必要です。',
              style: TextStyle(color: Colors.green)),
        );
      }
      return Container();
    }

    Widget questionAndAnswer() {
      final bool enabled =
          isConnectedToWord == false && isConnectedToSentence == false;
      //
      return Column(
        children: [
          // 問題フォーム
          TextFormField(
            controller: questionController,
            enabled: enabled,
            minLines: 4,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                filled: !enabled,
                fillColor: Colors.black12,
                labelText: "問題文",
                hintText: '問題文を入力してください。'),
            validator: (value) {
              if (value!.isEmpty) {
                return '問題文は空欄にできません。';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          // 正解フォーム
          TextFormField(
            controller: correctAnswerController,
            enabled: enabled,
            minLines: 4,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                filled: !enabled,
                fillColor: Colors.black12,
                labelText: "正解",
                hintText: '正解を入力してください。'),
            validator: (value) {
              if (value!.isEmpty) {
                return '正解は空欄にできません。';
              }
              return null;
            },
          ),

          buttonToEditRoot()
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        questionAndAnswer(),
        const SizedBox(height: 40),
        QuizFormDistractor(
            distractorController: distractor1Controller, number: 1),
        const SizedBox(height: 16),
        QuizFormDistractor(
            distractorController: distractor2Controller, number: 2),
        const SizedBox(height: 16),
        QuizFormDistractor(
            distractorController: distractor3Controller, number: 3),
        const SizedBox(height: 40),
        // ヒント
        TextFormField(
          minLines: 5,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: hintController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'ヒント',
            hintText: '【空欄可】ヒントがあれば入力してください。',
          ),
        ),
        const MarkdownIntroductionTextButton(),
        const SizedBox(height: 32),
        // 解説
        TextFormField(
          minLines: 8,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: explanationController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '解説',
            hintText: '【空欄可】解説があれば入力してください。',
          ),
        ),
        const MarkdownIntroductionTextButton(),
        const SizedBox(height: 32),
        // プレビューボタン
        QuizFormPreviewButton(
          questionController: questionController,
          langNumberOfQuestion: langNumberOfQuestion,
          correctAnswerController: correctAnswerController,
          langNumberOfAnswer: langNumberOfAnswer,
          distractor1Controller: distractor1Controller,
          distractor2Controller: distractor2Controller,
          distractor3Controller: distractor3Controller,
          hintController: hintController,
          explanationController: explanationController,
          autoDictLinkOfQuestion: autoDictLinkOfQuestion,
          autoDictLinkOfAnswer: autoDictLinkOfAnswer,
          appliedDictionaryId: int.parse(appliedDictionaryIdController.text),
        )
      ],
    );
  }
}
