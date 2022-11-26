import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/quiz/answers_count.dart';
import 'package:booqs_mobile/widgets/quiz/exp_indicator.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/open_button.dart';
import 'package:booqs_mobile/widgets/markdown/markdown_without_dict_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizAnswerInteraction extends ConsumerWidget {
  const QuizAnswerInteraction({Key? key, required this.notification})
      : super(key: key);
  final AnswerNotification notification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool _correct = notification.correct;
    final Quiz _quiz = notification.quiz;
    final String _correctAnswer = _quiz.correctAnswer;
    final String? _usersAnswer = notification.usersAnswer;
    // initialExpにProviderを使うと、サーバーのレスポンス速度によっては解答報酬獲得後の総合経験値が入ってしまう
    final int initialExp = notification.user!.amountOfExp;

    const double fontSize = 16;
    const FontWeight fontWeight = FontWeight.bold;
    const Color fontColor = Colors.white;

    Widget _correctAnswerWidget() {
      return Container(
        margin: const EdgeInsets.only(bottom: 16, top: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Icon(Icons.circle_outlined,
                  color: Colors.white, size: 24),
            ),
            // Expandedを使うと短い文章でも幅全体を埋めてしまい、結果的に左寄せになってしまうので Flexible を使う。
            Flexible(
              child: MarkdownWithoutDictLink(
                text: _correctAnswer,
                fontSize: fontSize,
                fontColor: fontColor,
                fontWeight: fontWeight,
                selectable: false,
              ),
            ),
          ],
        ),
      );
    }

    Widget _incorrectFeedback() {
      if (_correct) return Container();

      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Icon(Icons.clear, color: Colors.white, size: 24),
            ),
            Flexible(
              child: MarkdownWithoutDictLink(
                text: '$_usersAnswer',
                fontSize: fontSize,
                fontColor: fontColor,
                fontWeight: fontWeight,
                selectable: false,
              ),
            ),
          ],
        ),
      );
    }

    Widget _expIndicator() {
      if (_correct == false) return Container();
      return QuizExpIndicator(initialExp: initialExp, gainedExp: 3);
    }

    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Column(
              // 画面一杯にSnackbarが広がるのを防ぐ ref: https://stackoverflow.com/questions/61790405/how-to-avoid-that-a-column-inside-a-snackbar-occupies-100-of-the-height
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _correctAnswerWidget(),
                _incorrectFeedback(),
                _expIndicator(),
                const QuizAnswersCount(),
                QuizExplanationOpenButton(
                  answerNotification: notification,
                ),
                const SizedBox(height: 8),
              ]),
        ),
      ),
    );
  }
}
