import 'package:booqs_mobile/models/achievement.dart';
import 'package:booqs_mobile/models/cheer.dart';
import 'package:booqs_mobile/models/user.dart';

class Activity {
  Activity({
    required this.id,
    required this.userId,
    this.drillId,
    this.achievementId,
    this.information,
    required this.activityType,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.achievement,
    this.cheer,
  });
  int id;
  int userId;
  int? drillId;
  int? achievementId;
  String? information;
  String activityType;
  DateTime createdAt;
  DateTime updatedAt;
  User? user;
  Achievement? achievement;
  Cheer? cheer;

  Activity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        drillId = json['drill_id'],
        achievementId = json['achievement_id'],
        information = json['information'],
        activityType = json['activity_type'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        user = json['user'] == null ? null : User.fromJson(json['user']),
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
        'achievement': achievement,
        'cheer': cheer,
      };
}
