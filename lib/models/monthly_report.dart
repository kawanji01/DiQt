class MonthlyReport {
  MonthlyReport({
    this.id = 0,
    this.userId = 0,
    this.rank,
    this.numberOfAnswers,
    this.answersCount,
    this.measuredAt,
    this.measuredDate,
    required this.timeZoneName,
    required this.createdAt,
    required this.updatedAt,
  });
  int id;
  int userId;
  int? rank;
  int? numberOfAnswers;
  int? answersCount;
  DateTime? measuredAt;
  DateTime? measuredDate;
  String timeZoneName;
  DateTime createdAt;
  DateTime updatedAt;

  MonthlyReport.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        rank = json['rank'],
        numberOfAnswers = json['number_of_answers'] ?? 0,
        answersCount = json['answers_count'] ?? 0,
        measuredAt = json['measured_at'] == null
            ? null
            : DateTime.parse(json['measured_at']),
        measuredDate = json['measured_date'] == null
            ? null
            : DateTime.parse(json['measured_date']),
        timeZoneName = json['time_zone_name'] ?? 'Tokyo',
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'rank': rank,
        'number_of_answers': numberOfAnswers,
        'answers_count': answersCount,
        'measured_at': measuredAt,
        'measured_date': measuredDate,
        'time_zone_name': timeZoneName,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
