import 'package:booqs_mobile/models/user.dart';

class Relationship {
  Relationship({
    required this.id,
    required this.followerId,
    required this.followedId,
    required this.createdAt,
    required this.updatedAt,
    this.follower,
    this.followed,
  });

  int id;
  int followerId;
  int followedId;
  DateTime createdAt;
  DateTime updatedAt;
  User? follower;
  User? followed;

  Relationship.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        followerId = json['follower_id'],
        followedId = json['followed_id'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        follower =
            json['follower'] == null ? null : User.fromJson(json['follower']),
        followed =
            json['followed'] == null ? null : User.fromJson(json['followed']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'follower_id': followerId,
        'followed_id': followedId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'follower': follower,
        'followed': followed,
      };
}
