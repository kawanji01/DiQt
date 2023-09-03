import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/components/button/small_outline_green_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizItemSkipButton extends ConsumerStatefulWidget {
  const QuizItemSkipButton({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  QuizItemSkipButtonState createState() => QuizItemSkipButtonState();
}

class QuizItemSkipButtonState extends ConsumerState<QuizItemSkipButton> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    final quiz = widget.quiz;

    Widget button() {
      //const String label = 'わからない';

      if (_selected) {
        return const SmallGreenButton(
          label: '',
          icon: Icons.close,
        );
      }
      return const SmallOutlineGreenButton(
        label: '',
        icon: Icons.close,
      );
    }

    return InkWell(
      onTap: () {
        // 振動フィードバック
        HapticFeedback.mediumImpact();
        AnswerNotification('わからない', false, quiz, user!, true).dispatch(context);
        setState(() {
          _selected = true;
        });
      },
      child: button(),
    );
  }
}
