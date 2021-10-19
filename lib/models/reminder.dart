class Reminder {
  Reminder({
    this.id,
    this.userId,
    this.quizId,
    this.reviewDay,
    this.setting,
    this.read,
    this.spacing,
  });

  int? id;
  int? userId;
  int? quizId;
  String? reviewDay;
  int? setting;
  int? spacing;
  bool? read;

  Reminder.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        quizId = json['quiz_id'],
        reviewDay = json['review_day'],
        setting = json['setting'],
        spacing = json['spacing'],
        read = json['read'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'quizId': quizId,
        'reviewDay': reviewDay,
        'setting': setting,
        'spacing': spacing,
        'read': read
      };
}
