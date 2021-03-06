import 'package:booqs_mobile/models/quiz.dart';

class Review {
  Review({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.scheduledDate,
    required this.intervalSetting,
    required this.reviewed,
    this.spacing,
    this.quiz,
  });

  int id;
  int userId;
  int quizId;
  // ReviewSettingDialog で削除時に"deleted"を格納するのでString
  String? scheduledDate;
  int? intervalSetting;
  int? spacing;
  bool? reviewed;
  Quiz? quiz;

  Review.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        quizId = json['quiz_id'],
        scheduledDate = json['scheduled_date'],
        intervalSetting = json['interval_setting'],
        spacing = json['spacing'],
        reviewed = json['reviewed'],
        quiz = json['quiz'] == null ? null : Quiz.fromJson(json['quiz']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'quiz_id': quizId,
        'scheduled_date': scheduledDate,
        'interval_setting': intervalSetting,
        'spacing': spacing,
        'reviewed': reviewed,
        'quiz': quiz,
      };
}
