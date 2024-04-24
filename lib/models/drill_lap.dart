import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/user.dart';

class DrillLap {
  DrillLap({
    required this.id,
    required this.userId,
    required this.drillId,
    required this.clearsCount,
    required this.cleared,
    required this.lastAnsweredAt,
    required this.clearedAt,
    required this.createdAt,
    required this.updatedAt,
    this.drill,
    this.user,
  });
  int id;
  int userId;
  int drillId;
  int clearsCount;
  bool cleared;
  DateTime lastAnsweredAt;
  DateTime? clearedAt;
  DateTime createdAt;
  DateTime updatedAt;
  Drill? drill;
  User? user;

  DrillLap.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        drillId = json['drill_id'],
        clearsCount = json['clears_count'],
        cleared = json['cleared'],
        lastAnsweredAt = DateTime.parse(json['last_answered_at'] ?? ''),
        clearedAt = json['cleared_at'] == null
            ? null
            : DateTime.parse(json['cleared_at']),
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        drill = json['drill'] == null ? null : Drill.fromJson(json['drill']),
        user = json['user'] == null ? null : User.fromJson(json['user']);
  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'drill_id': drillId,
        'cleared': cleared,
        'clears_count': clearsCount,
        'last_answered_at': lastAnsweredAt.toIso8601String(),
        'cleared_at': clearedAt?.toIso8601String(),
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
