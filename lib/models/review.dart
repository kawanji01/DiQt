class Review {
  Review({
    this.id,
    this.userId,
    this.quizId,
    this.scheduledDate,
    this.intervalSetting,
    this.reviewed,
    this.spacing,
  });

  int? id;
  int? userId;
  int? quizId;
  // ReviewSettingDialog で削除時に"deleted"を格納するのでString
  String? scheduledDate;
  int? intervalSetting;
  int? spacing;
  bool? reviewed;

  Review.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        quizId = json['quiz_id'],
        scheduledDate = json['scheduled_date'],
        intervalSetting = json['interval_setting'],
        spacing = json['spacing'],
        reviewed = json['reviewed'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'quiz_id': quizId,
        'scheduled_date': scheduledDate,
        'interval_setting': intervalSetting,
        'spacing': spacing,
        'reviewed': reviewed
      };
}
