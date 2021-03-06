import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/pages/sentence/edit.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:booqs_mobile/widgets/quiz/form/distractor.dart';
import 'package:booqs_mobile/widgets/quiz/form/preview_button.dart';
import 'package:flutter/material.dart';

class QuizForm extends StatefulWidget {
  const QuizForm(
      {Key? key,
      required this.questionController,
      required this.correctAnswerController,
      required this.distractor1Controller,
      required this.distractor2Controller,
      required this.distractor3Controller,
      required this.explanationController,
      required this.hintController,
      required this.quiz,
      required this.dictionary})
      : super(key: key);
  final TextEditingController questionController;
  final TextEditingController correctAnswerController;
  final TextEditingController distractor1Controller;
  final TextEditingController distractor2Controller;
  final TextEditingController distractor3Controller;
  final TextEditingController explanationController;
  final TextEditingController hintController;
  final Quiz? quiz;
  final Dictionary dictionary;

  @override
  State<QuizForm> createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  @override
  Widget build(BuildContext context) {
    final Quiz? _quiz = widget.quiz;
    final int langNumberOfQuestion = _quiz?.langNumberOfQuestion ?? 0;
    final int langNumberOfAnswer = _quiz?.langNumberOfAnswer ?? 0;
    final Dictionary _dictionary = widget.dictionary;

    bool _autoDictLinkOfQuestion;
    bool _autoDictLinkOfAnswer;
    bool _isConnectedToWord;
    bool _isConnectedToSentence;
    if (_quiz == null) {
      _autoDictLinkOfQuestion = false;
      _autoDictLinkOfAnswer = false;
      _isConnectedToWord = false;
      _isConnectedToSentence = false;
    } else {
      _autoDictLinkOfQuestion = _quiz.autoDictLinkOfQuestion;
      _autoDictLinkOfAnswer = _quiz.autoDictLinkOfAnswer;
      _isConnectedToWord =
          _quiz.wordId != null || _quiz.referenceWordId != null;
      _isConnectedToSentence = _quiz.sentenceId != null;
    }

    final TextEditingController _questionController = widget.questionController;
    final TextEditingController _correctAnswerController =
        widget.correctAnswerController;
    final TextEditingController _distractor1Controller =
        widget.distractor1Controller;
    final TextEditingController _distractor2Controller =
        widget.distractor2Controller;
    final TextEditingController _distractor3Controller =
        widget.distractor3Controller;
    final TextEditingController _explanationController =
        widget.explanationController;
    final TextEditingController _hintController = widget.hintController;

    // ????????????????????????????????????????????????????????????????????????
    Widget _buttonToEditRoot() {
      if (_isConnectedToWord) {
        final int? wordId = _quiz?.wordId ?? _quiz?.referenceWordId;
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
          child: const Text('??????????????????????????????????????????????????????????????????????????????',
              style: TextStyle(color: Colors.green)),
        );
      }

      if (_isConnectedToSentence) {
        final int? sentenceId = _quiz?.sentenceId;
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
          child: const Text('??????????????????????????????????????????????????????????????????????????????',
              style: TextStyle(color: Colors.green)),
        );
      }
      return Container();
    }

    Widget _questionAndAnswer() {
      final bool enabled =
          _isConnectedToWord == false && _isConnectedToSentence == false;
      //
      return Column(
        children: [
          // ??????????????????
          TextFormField(
            controller: _questionController,
            enabled: enabled,
            minLines: 4,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                filled: !enabled,
                fillColor: Colors.black12,
                labelText: "?????????",
                hintText: '???????????????????????????????????????'),
            validator: (value) {
              if (value!.isEmpty) {
                return '???????????????????????????????????????';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          // ??????????????????
          TextFormField(
            controller: _correctAnswerController,
            enabled: enabled,
            minLines: 4,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                filled: !enabled,
                fillColor: Colors.black12,
                labelText: "??????",
                hintText: '????????????????????????????????????'),
            validator: (value) {
              if (value!.isEmpty) {
                return '????????????????????????????????????';
              }
              return null;
            },
          ),

          _buttonToEditRoot()
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _questionAndAnswer(),
        const SizedBox(height: 40),
        // ??????????????????
        /* TextFormField(
          minLines: 5,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _distractorsController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '??????????????????',
            hintText: '????????????????????????????????????????????????????????????????????????',
          ),
        ), */
        QuizFormDistractor(
            distractorController: _distractor1Controller, number: 1),
        const SizedBox(height: 16),
        QuizFormDistractor(
            distractorController: _distractor2Controller, number: 2),
        const SizedBox(height: 16),
        QuizFormDistractor(
            distractorController: _distractor3Controller, number: 3),
        /* const Text(
          '????????????????????????????????????????????????',
          style: TextStyle(color: Colors.black54),
        ), */
        const SizedBox(height: 40),
        // ?????????
        TextFormField(
          minLines: 5,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _hintController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '?????????',
            hintText: '???????????????????????????????????????????????????????????????',
          ),
        ),
        const SizedBox(height: 32),
        // ??????
        TextFormField(
          minLines: 8,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _explanationController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '??????',
            hintText: '????????????????????????????????????????????????????????????',
          ),
        ),
        // ????????????????????????
        QuizFormPreviewButton(
          questionController: _questionController,
          langNumberOfQuestion: langNumberOfQuestion,
          correctAnswerController: _correctAnswerController,
          langNumberOfAnswer: langNumberOfAnswer,
          distractor1Controller: _distractor1Controller,
          distractor2Controller: _distractor2Controller,
          distractor3Controller: _distractor3Controller,
          hintController: _hintController,
          explanationController: _explanationController,
          autoDictLinkOfQuestion: _autoDictLinkOfQuestion,
          autoDictLinkOfAnswer: _autoDictLinkOfAnswer,
          dictionaryId: _dictionary.id,
        )
      ],
    );
  }
}
