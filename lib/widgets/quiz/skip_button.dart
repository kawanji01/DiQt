import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:booqs_mobile/widgets/button/small_outline_green_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizSkipButton extends ConsumerStatefulWidget {
  const QuizSkipButton({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  _QuizSkipButtonState createState() => _QuizSkipButtonState();
}

class _QuizSkipButtonState extends ConsumerState<QuizSkipButton> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    final quiz = widget.quiz;

    Widget _button() {
      const String label = 'わからない';
      Color color = Colors.green;
      if (_selected) {
        color = Colors.white;
      }

      final richText = RichText(
          text: TextSpan(children: [
        WidgetSpan(
          child: Icon(
            Icons.close,
            color: color,
            size: 16.0,
          ),
        ),
        TextSpan(
            text: label,
            style: TextStyle(
                color: color, fontSize: 14, fontWeight: FontWeight.bold))
      ]));
      if (_selected) {
        return SmallGreenButton(richText: richText);
      }
      return SmallOutlineGreenButton(richText: richText);
    }

    return InkWell(
      onTap: () {
        AnswerNotification('わからない', false, quiz, user!, true).dispatch(context);
        setState(() {
          _selected = true;
        });
      },
      child: _button(),
    );
  }
}
