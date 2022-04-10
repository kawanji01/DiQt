import 'package:booqs_mobile/data/provider/current_user_provider.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/widgets/quiz/choice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizMultipleChoices extends ConsumerStatefulWidget {
  const QuizMultipleChoices(
      {Key? key, required this.quiz, required this.answerTextList})
      : super(key: key);
  final Quiz quiz;
  final List<String> answerTextList;

  @override
  _QuizMultipleChoicesState createState() => _QuizMultipleChoicesState();
}

class _QuizMultipleChoicesState extends ConsumerState<QuizMultipleChoices> {
  String? _selectedAnswer;

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    final Quiz _quiz = widget.quiz;
    final String? _correctAnswer = _quiz.correctAnswer;
    final List<String> _answerTextList = widget.answerTextList;

    // 解答ボタン
    Widget _answerButton(answerText) {
      final bool selected = _selectedAnswer == answerText;

      return InkWell(
        onTap: () {
          _selectedAnswer = answerText;
          final bool correct = _selectedAnswer == _correctAnswer;
          AnswerNotification(answerText, correct, _quiz, user!, true)
              .dispatch(context);
          setState(() {
            _selectedAnswer;
          });
        },
        child: QuizChoiceButton(
          answerText: answerText,
          selected: selected,
        ),
      );
    }

    // 解答ボタンのリストを生成する
    List<Widget> _choiceButtons(textList) {
      List<Widget> buttonList = [];
      textList
          .forEach((answerText) => buttonList.add(_answerButton(answerText)));
      return buttonList;
    }

    return Column(
      children: _choiceButtons(_answerTextList),
    );
  }
}
