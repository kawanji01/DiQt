class WeeklyReport {
  WeeklyReport({
    this.id = 0,
    this.userId = 0,
    required this.measuredDate,
    this.rank,
    this.numberOfAnswers = 0,
    this.monthlyRank,
    required this.createdAt,
    required this.updatedAt,
  });
  int id;
  int userId;
  DateTime measuredDate;
  int? rank;
  int? monthlyRank;
  int numberOfAnswers;
  DateTime createdAt;
  DateTime updatedAt;

  WeeklyReport.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        measuredDate = DateTime.parse(json['measured_date']),
        rank = json['rank'],
        numberOfAnswers = json['number_of_answers'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'measured_date': measuredDate,
        'rank': rank,
        'number_of_answers': numberOfAnswers,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
