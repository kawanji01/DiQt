class WeeklyReport {
  WeeklyReport({
    this.id = 0,
    this.userId = 0,
    required this.measuredAt,
    this.rank,
    this.daysAnswered = 0,
    this.numberOfAnswers = 0,
    this.monthlyRank,
    required this.createdAt,
    required this.updatedAt,
  });
  int id;
  int userId;
  DateTime measuredAt;
  int? rank;
  int? monthlyRank;
  int daysAnswered;
  int numberOfAnswers;
  DateTime createdAt;
  DateTime updatedAt;

  WeeklyReport.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        measuredAt = DateTime.parse(json['measured_at']),
        rank = json['rank'],
        daysAnswered = json['days_answered'],
        numberOfAnswers = json['number_of_answers'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'measured_at': measuredAt,
        'rank': rank,
        'days_answered': daysAnswered,
        'number_of_answers': numberOfAnswers,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
