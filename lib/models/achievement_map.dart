import 'package:booqs_mobile/models/achievement.dart';
import 'package:booqs_mobile/models/user.dart';

class AchievementMap {
  AchievementMap({
    required this.id,
    required this.userId,
    required this.achievementId,
    required this.received,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.achievement,
  });

  int id;
  int userId;
  int achievementId;
  bool received;
  DateTime createdAt;
  DateTime updatedAt;
  User? user;
  Achievement? achievement;

  AchievementMap.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        achievementId = json['achievement_id'],
        received = json['received'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        user = json['user'] == null ? null : User.fromJson(json['user']),
        achievement = json['achievement'] == null
            ? null
            : Achievement.fromJson(json['achievement']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'achievement_id': achievementId,
        'received': received,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'user': user,
        'achievement': achievement,
      };
}
