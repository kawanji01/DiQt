import 'package:booqs_mobile/components/shared/audio_button.dart';
import 'package:booqs_mobile/components/shared/tts_button.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:flutter/widgets.dart';

class QuizItemAnswerAudioButton extends StatelessWidget {
  const QuizItemAnswerAudioButton({super.key, required this.quiz});
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    if (quiz.answerReadAloud == false) {
      return Container();
    }

    if (quiz.answerAudioUrl == null || quiz.answerAudioUrl == '') {
      // TTSできちんと読み上げるためにDiQtリンクを取り除いた平文を渡す
      final String correctAnswer = Sanitizer.removeDiQtLink(quiz.correctAnswer);
      return TtsButton(
        speechText: correctAnswer,
        langNumber: quiz.langNumberOfAnswer,
      );
    } else {
      return AudioButton(url: quiz.answerAudioUrl!);
    }
  }
}
