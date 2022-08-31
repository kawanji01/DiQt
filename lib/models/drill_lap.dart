class DrillLap {
  DrillLap({
    this.id,
    this.userId,
    this.drillId,
    required this.clearsCount,
    this.cleared = false,
    this.createdAt,
    this.updatedAt,
  });
  int? id;
  int? userId;
  int? drillId;
  int clearsCount;
  bool cleared;
  String? createdAt;
  String? updatedAt;

  DrillLap.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        drillId = json['drill_id'],
        clearsCount = json['clears_count'],
        cleared = json['cleared'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'drill_id': drillId,
        'clears_count': clearsCount,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
