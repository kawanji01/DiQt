import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';

class AnswerHistory {
  AnswerHistory({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.drillId,
    required this.answerAnalysisId,
    required this.correct,
    required this.atDrillPage,
    required this.atReviewPage,
    required this.atWeknessPage,
    required this.intervalStepUp,
    required this.answerDate,
    required this.firstOfTheDay,
    this.answer,
    required this.goalAchievement,
    required this.reviewCompletion,
    required this.continuation,
    required this.continuationAllWeek,
    required this.continuationAllMonth,
    required this.continuationAllYear,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.quiz,
    this.drill,
    this.answerAnalysis,
  });

  int id;
  int userId;
  int quizId;
  int drillId;
  int answerAnalysisId;
  bool correct;
  bool atDrillPage;
  bool atReviewPage;
  bool atWeknessPage;
  bool intervalStepUp;
  DateTime answerDate;
  bool firstOfTheDay;
  String? answer;
  bool goalAchievement;
  bool reviewCompletion;
  bool continuation;
  bool continuationAllWeek;
  bool continuationAllMonth;
  bool continuationAllYear;
  DateTime createdAt;
  DateTime updatedAt;
  User? user;
  Quiz? quiz;
  Drill? drill;
  AnswerAnalysis? answerAnalysis;

  AnswerHistory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        quizId = json['quiz_id'],
        drillId = json['drill_id'],
        answerAnalysisId = json['answer_analysis_id'],
        correct = json['correct'],
        atDrillPage = json['at_drill_page'],
        atReviewPage = json['at_review_page'],
        atWeknessPage = json['at_weakness_page'],
        intervalStepUp = json['interval_step_up'],
        answerDate = DateTime.parse(json['answer_date']),
        firstOfTheDay = json['first_of_the_day'],
        answer = json['answer'],
        goalAchievement = json['goal_achievement'] ?? false,
        reviewCompletion = json['review_completion'] ?? false,
        continuation = json['continuation'],
        continuationAllWeek = json['continuation_all_week'],
        continuationAllMonth = json['continuation_all_month'],
        continuationAllYear = json['continuation_all_year'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        user = json['user'] == null ? null : User.fromJson(json['user']),
        quiz = json['quiz'] == null ? null : Quiz.fromJson(json['quiz']),
        drill = json['drill'] == null ? null : Drill.fromJson(json['drill']),
        answerAnalysis = json['answer_analysis'] == null
            ? null
            : AnswerAnalysis.fromJson(json['answer_analysis']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'quiz_id': quizId,
        'drill_id': drillId,
        'answer_analysis_id': answerAnalysisId,
        'correct': correct,
        'at_drill_page': atDrillPage,
        'at_review_page': atReviewPage,
        'at_wekness_page': atWeknessPage,
        'interval_step_up': intervalStepUp,
        'answer_date': answerDate,
        'first_of_the_day': firstOfTheDay,
        'answer': answer,
        'goal_achievement': goalAchievement,
        'review_completion': reviewCompletion,
        'continuation': continuation,
        'continuation_all_week': continuationAllWeek,
        'continuation_all_month': continuationAllMonth,
        'continuation_all_year': continuationAllYear,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'user': user,
        'quiz': quiz,
        'drill': drill,
        'answer_analysis': answerAnalysis,
      };
}
