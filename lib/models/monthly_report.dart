import 'package:booqs_mobile/consts/time_zone.dart';

class MonthlyReport {
  MonthlyReport({
    this.id = 0,
    this.userId = 0,
    this.rank,
    required this.answersCount,
    required this.measuredDate,
    required this.timeZoneName,
    required this.createdAt,
    required this.updatedAt,
  });
  int id;
  int userId;
  int? rank;

  int answersCount;

  DateTime measuredDate;
  String timeZoneName;
  DateTime createdAt;
  DateTime updatedAt;

  MonthlyReport.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        rank = json['rank'],
        answersCount = json['answers_count'] ?? 0,
        measuredDate = DateTime.parse(json['measured_date']),
        timeZoneName = json['time_zone_name'] ?? defaultTimeZone,
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'rank': rank,
        'answers_count': answersCount,
        'measured_date': measuredDate,
        'time_zone_name': timeZoneName,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
