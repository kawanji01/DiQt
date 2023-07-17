import 'package:booqs_mobile/models/school.dart';
import 'package:booqs_mobile/models/user.dart';

class MemberMap {
  MemberMap(
      {required this.id,
      required this.userId,
      required this.schoolId,
      required this.admin,
      required this.moderator,
      required this.createdAt,
      required this.updatedAt,
      this.user,
      this.school});
  final int id;
  final int userId;
  final int schoolId;
  final bool admin;
  final bool moderator;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User? user;
  final School? school;

  factory MemberMap.fromJson(Map<String, dynamic> json) {
    return MemberMap(
      id: json['id'],
      userId: json['user_id'],
      schoolId: json['school_id'],
      admin: json['admin'],
      moderator: json['moderator'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      school: json['school'] != null ? School.fromJson(json['school']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'school_id': schoolId,
        'admin': admin,
        'moderator': moderator,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'user': user,
        'school': school,
      };
}
