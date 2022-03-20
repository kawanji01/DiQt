class Notification {
  Notification({
    this.id,
    this.notifyingId,
    this.notifiedId,
    this.notificationId,
    this.monthlyReportId,
    this.weeklyReportId,
    this.inquiryId,
    this.achievementMapId,
    this.wordRequestId,
    this.read,
    this.notifiedType,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? notifyingId;
  int? notifiedId;
  int? notificationId;
  int? monthlyReportId;
  int? weeklyReportId;
  int? inquiryId;
  int? achievementMapId;
  int? wordRequestId;
  bool? read;
  String? imageUrl;
  String? notifiedType;
  String? createdAt;
  String? updatedAt;

  Notification.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        notifyingId = json['notifying_id'],
        notifiedId = json['notified_id'],
        notificationId = json['notification_id'],
        monthlyReportId = json['monthly_report_id'],
        weeklyReportId = json['weekly_report_id'],
        inquiryId = json['inquiry_id'],
        achievementMapId = json['achievement_map_id'],
        wordRequestId = json['word_request_id'],
        read = json['read'],
        imageUrl = json['image_url'],
        notifiedType = json['notified_type'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'notifying_id': notifyingId,
        'notified_id': notifiedId,
        'notification_id': notificationId,
        'monthly_report_id': monthlyReportId,
        'weekly_report_id': weeklyReportId,
        'inquiry_id': inquiryId,
        'achievement_map_id': achievementMapId,
        'word_request_id': wordRequestId,
        'read': read,
        'imageUrl': imageUrl,
        'notified_type': notifiedType,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
