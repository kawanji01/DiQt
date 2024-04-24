class Cheer {
  Cheer({
    required this.id,
    required this.activityId,
    required this.senderId,
    required this.receiverId,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });
  int id;
  int activityId;
  int senderId;
  int receiverId;
  String? comment;
  String? createdAt;
  String? updatedAt;

  Cheer.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        activityId = json['activity_id'],
        senderId = json['sender_id'],
        receiverId = json['receiver_id'],
        comment = json['comment'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'activity_id': activityId,
        'sender_id': senderId,
        'receiver_id': receiverId,
        'comment': comment,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
