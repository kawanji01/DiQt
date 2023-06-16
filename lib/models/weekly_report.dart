class WeeklyReport {
  WeeklyReport({
    this.id = 0,
    this.userId = 0,
    required this.measuredDate,
    this.rank,
    required this.answersCount,
    this.monthlyRank,
    required this.timeZoneName,
    required this.createdAt,
    required this.updatedAt,
  });
  int id;
  int userId;
  DateTime measuredDate;
  int? rank;
  int? monthlyRank;

  int answersCount;
  String timeZoneName;
  DateTime createdAt;
  DateTime updatedAt;

  WeeklyReport.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        measuredDate = DateTime.parse(json['measured_date']),
        rank = json['rank'],
        answersCount = json['answers_count'] ?? 0,
        timeZoneName = json['time_zone_name'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'measured_date': measuredDate,
        'rank': rank,
        'answers_count': answersCount,
        'time_zone_name': timeZoneName,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
