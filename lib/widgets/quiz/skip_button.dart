import 'package:booqs_mobile/data/provider/user.dart';
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

      if (_selected) {
        return const SmallGreenButton(
          label: label,
          icon: Icons.close,
        );
      }
      return const SmallOutlineGreenButton(
        label: label,
        icon: Icons.close,
      );
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
