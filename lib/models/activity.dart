import 'package:booqs_mobile/models/achievement.dart';
import 'package:booqs_mobile/models/cheer.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/user.dart';

class Activity {
  Activity({
    required this.id,
    required this.userId,
    this.drillId,
    this.answerHistoryId,
    this.achievementId,
    this.information,
    this.amount,
    this.continuationCount,
    this.allWeekContinuationCount,
    this.allMonthContinuationCount,
    this.allYearContinuationCount,
    this.imageUrl,
    required this.activityType,
    required this.createdAt,
    required this.updatedAt,
    this.recordedDate,
    this.user,
    this.achievement,
    this.cheer,
  });
  int id;
  int userId;
  int? drillId;
  int? answerHistoryId;
  int? achievementId;
  String? information;
  int? amount;
  int? continuationCount;
  int? allWeekContinuationCount;
  int? allMonthContinuationCount;
  int? allYearContinuationCount;
  String? imageUrl;
  String activityType;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? recordedDate;
  User? user;
  Drill? drill;
  Achievement? achievement;
  Cheer? cheer;

  Activity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        drillId = json['drill_id'],
        answerHistoryId = json['answer_history_id'],
        achievementId = json['achievement_id'],
        information = json['information'],
        amount = json['amount'],
        continuationCount = json['continuation_count'],
        allWeekContinuationCount = json['all_week_continuation_count'],
        allMonthContinuationCount = json['all_month_continuation_count'],
        allYearContinuationCount = json['all_year_continuation_count'],
        imageUrl = json['image_url'],
        activityType = json['activity_type'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        user = json['user'] == null ? null : User.fromJson(json['user']),
        drill = json['drill'] == null ? null : Drill.fromJson(json['drill']),
        achievement = json['achievement'] == null
            ? null
            : Achievement.fromJson(json['achievement']),
        cheer = json['cheer'] == null ? null : Cheer.fromJson(json['cheer']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'drill_id': drillId,
        'achievement_id': achievementId,
        'information': information,
        'activity_type': activityType,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'user': user,
        'drill': drill,
        'achievement': achievement,
        'cheer': cheer,
      };
}
