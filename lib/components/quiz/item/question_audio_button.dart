import 'package:booqs_mobile/components/shared/audio_button.dart';
import 'package:booqs_mobile/components/shared/tts_button.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:flutter/widgets.dart';

class QuizItemQuestionAudioButton extends StatelessWidget {
  const QuizItemQuestionAudioButton({super.key, required this.quiz});
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    if (quiz.questionReadAloud == false) {
      return Container();
    }

    if (quiz.questionAudioUrl == null || quiz.questionAudioUrl == '') {
      // TTSできちんと読み上げるためにDiQtリンクを取り除いた平文をつくる
      final String questionPlainText = Sanitizer.removeDiQtLink(quiz.question);
      return TtsButton(
        speechText: questionPlainText,
        langNumber: quiz.langNumberOfQuestion,
      );
    } else {
      return AudioButton(url: quiz.questionAudioUrl!);
    }
  }
}
