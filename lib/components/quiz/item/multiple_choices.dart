import 'package:booqs_mobile/components/quiz/item/answer_cover.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/components/quiz/item/choice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizItemMultipleChoices extends ConsumerStatefulWidget {
  const QuizItemMultipleChoices(
      {super.key,
      required this.quiz,
      required this.answerTextList,
      required this.unsolved});
  final Quiz quiz;
  final List<String> answerTextList;
  final bool unsolved;

  @override
  QuizItemMultipleChoicesState createState() => QuizItemMultipleChoicesState();
}

class QuizItemMultipleChoicesState
    extends ConsumerState<QuizItemMultipleChoices> {
  String? _selectedAnswer;
  bool _isCovered = false;
  bool _isDisabled = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isCovered = ref.read(choicesCoveredProvider);
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
        child: QuizItemChoiceButton(
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

    if (_isCovered) {
      // 選択肢カバー
      return QuizItemAnswerCover(
        label: t.quizzes.choices_cover_text,
        onTap: () {
          setState(() {
            _isCovered = false;
          });
        },
      );
    }
    // 多肢選択肢
    return Column(
      children: choiceButtons(answerTextList),
    );
  }
}
