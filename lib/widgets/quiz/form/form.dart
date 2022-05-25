import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/pages/sentence/edit.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:booqs_mobile/widgets/quiz/form/preview_button.dart';
import 'package:flutter/material.dart';

class QuizForm extends StatefulWidget {
  const QuizForm(
      {Key? key,
      required this.questionController,
      required this.correctAnswerController,
      required this.distractorsController,
      required this.explanationController,
      required this.hintController,
      required this.quiz,
      required this.dictionary})
      : super(key: key);
  final TextEditingController questionController;
  final TextEditingController correctAnswerController;
  final TextEditingController distractorsController;
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

    bool _isConnectedToWord;
    bool _isConnectedToSentence;
    if (_quiz == null) {
      _isConnectedToWord = false;
      _isConnectedToSentence = false;
    } else {
      _isConnectedToWord =
          _quiz.wordId != null || _quiz.referenceWordId != null;
      _isConnectedToSentence = _quiz.sentenceId != null;
    }

    final TextEditingController _questionController = widget.questionController;
    final TextEditingController _correctAnswerController =
        widget.correctAnswerController;
    final TextEditingController _distractorsController =
        widget.distractorsController;
    final TextEditingController _explanationController =
        widget.explanationController;
    final TextEditingController _hintController = widget.hintController;

    // 問題に紐づいている辞書の項目や例文への編集ボタン
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
          child: const Text('この問題と答えを編集するには、項目の編集が必要です。',
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
          child: const Text('この問題と答えを編集するには、例文の編集が必要です。',
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
          // 問題フォーム
          TextFormField(
            controller: _questionController,
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
            controller: _correctAnswerController,
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

          _buttonToEditRoot()
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _questionAndAnswer(),
        const SizedBox(height: 40),
        // 誤りの選択肢
        TextFormField(
          minLines: 5,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _distractorsController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '誤りの選択肢',
            hintText: '【空欄可】誤りの選択肢があれば入力してください。',
          ),
        ),
        const Text(
          '改行によって選択肢を増やします。',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 40),
        // ヒント
        TextFormField(
          minLines: 5,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _hintController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'ヒント',
            hintText: '【空欄可】ヒントがあれば入力してください。',
          ),
        ),
        const SizedBox(height: 32),
        // 解説
        TextFormField(
          minLines: 8,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _explanationController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '解説',
            hintText: '【空欄可】解説があれば入力してください。',
          ),
        ),
        // プレビューボタン
        QuizFormPreviewButton(
          questionController: _questionController,
          langNumberOfQuestion: langNumberOfQuestion,
          correctAnswerController: _correctAnswerController,
          langNumberOfAnswer: langNumberOfAnswer,
          distractorsController: _distractorsController,
          hintController: _hintController,
          explanationController: _explanationController,
          dictionary: _dictionary,
        )
      ],
    );
  }
}
