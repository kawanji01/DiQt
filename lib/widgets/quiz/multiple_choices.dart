import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/user.dart';
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
  bool _isCovered = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _isCovered = ref.watch(
            answerSettingProvider.select((setting) => setting!.choicesCovered));
      });
    });
    super.initState();
  }

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

    // 多肢選択肢
    final Widget multipleChoices = Column(
      children: _choiceButtons(_answerTextList),
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
