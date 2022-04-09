class DrillLap {
  DrillLap({
    this.id,
    this.userId,
    this.drillId,
    this.numberOfLaps,
    this.clearLap = false,
    this.createdAt,
    this.updatedAt,
  });
  int? id;
  int? userId;
  int? drillId;
  int? numberOfLaps;
  bool clearLap;
  String? createdAt;
  String? updatedAt;

  DrillLap.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        drillId = json['drill_id'],
        numberOfLaps = json['number_of_laps'],
        clearLap = json['clear_lap'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'drill_id': drillId,
        'number_of_laps': numberOfLaps,
        'clear_lap': clearLap,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
