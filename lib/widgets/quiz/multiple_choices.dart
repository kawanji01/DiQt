import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/widgets/quiz/choice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizMultipleChoices extends ConsumerStatefulWidget {
  const QuizMultipleChoices(
      {Key? key,
      required this.quiz,
      required this.answerTextList,
      required this.unsolved})
      : super(key: key);
  final Quiz quiz;
  final List<String> answerTextList;
  final bool unsolved;

  @override
  QuizMultipleChoicesState createState() => QuizMultipleChoicesState();
}

class QuizMultipleChoicesState extends ConsumerState<QuizMultipleChoices> {
  String? _selectedAnswer;
  bool _isCovered = false;
  bool _isDisabled = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isCovered = ref.watch(answerSettingProvider.select(
            (setting) => setting == null ? false : setting.choicesCovered));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    final Quiz quiz = widget.quiz;
    final String correctAnswer = quiz.correctAnswer;
    final List<String> answerTextList = widget.answerTextList;

    // 解答ボタン
    Widget answerButton(answerText) {
      final bool selected = _selectedAnswer == answerText;

      return InkWell(
        // 二重タップを防ぐ
        onTap: _isDisabled
            ? null
            : () async {
                _selectedAnswer = answerText;
                final bool correct = _selectedAnswer == correctAnswer;
                AnswerNotification(answerText, correct, quiz, user, true)
                    .dispatch(context);
                // 振動フィードバック
                HapticFeedback.mediumImpact();
                setState(() {
                  _selectedAnswer;
                  _isDisabled = true;
                });
                if (widget.unsolved) {
                  return;
                }
                // １秒間タップできないようにしてから有効化する。
                await Future.delayed(
                  const Duration(seconds: 1),
                );
                setState(() => _isDisabled = false);
              },
        child: QuizChoiceButton(
          answerText: answerText,
          selected: selected,
        ),
      );
    }

    // 解答ボタンのリストを生成する
    List<Widget> choiceButtons(textList) {
      List<Widget> buttonList = [];
      textList.forEach((answerText) {
        // 空文字の改行は選択肢にしない
        if (answerText == '') return;
        buttonList.add(answerButton(answerText));
      });
      return buttonList;
    }

    // 多肢選択肢
    final Widget multipleChoices = Column(
      children: choiceButtons(answerTextList),
    );

    // 選択肢カバー
    final Widget cover = InkWell(
      onTap: () {
        setState(() {
          _isCovered = false;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: RichText(
            text: const TextSpan(children: [
          WidgetSpan(
            child: Icon(
              Icons.lock,
              color: Colors.green,
              size: 18.0,
            ),
          ),
          TextSpan(
              text: ' タップして選択肢を表示',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))
        ])),
      ),
    );

    if (_isCovered) {
      return cover;
    }
    return multipleChoices;
  }
}
