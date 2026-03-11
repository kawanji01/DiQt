import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';

class PronunciationNotification {
  static AnswerNotification build({
    required Quiz quiz,
    required User? user,
    required Map<String, dynamic> responseMap,
    bool skipAnswerAccessGuard = false,
    bool countUpdatedLocally = false,
  }) {
    final AnswerCreator answerCreator = AnswerCreator.fromJson(
      Map<String, dynamic>.from(responseMap['answer_creator']),
    );
    final String usersAnswer = answerCreator.answerHistory?.answer ?? '';
    final bool correct = answerCreator.answerHistory?.correct ?? false;

    return AnswerNotification(
      usersAnswer,
      correct,
      quiz,
      user,
      true,
      responseMap: responseMap,
      skipAnswerAccessGuard: skipAnswerAccessGuard,
      countUpdatedLocally: countUpdatedLocally,
    );
  }
}
