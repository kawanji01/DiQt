class Chapter {
  Chapter(
      {this.id,
      this.name = '',
      this.introduction = '',
      this.imageUrl,
      this.iconUrl,
      this.groupType,
      this.publicUid,
      this.createdAt,
      this.updatedAt,
      // eager_loadでキャッシュしたdrillの情報
      this.answerHistoriesCount});

  int? id;
  String name;
  String introduction;
  String? imageUrl;
  String? iconUrl;
  String? groupType;
  String? publicUid;
  String? createdAt;
  String? updatedAt;
  // テーブルを結合してキャッシュしたdrillの情報
  int? answerHistoriesCount;

  Chapter.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] ?? '',
        introduction = json['introduction'] ?? '',
        imageUrl = json['cover_image_url'] ?? '',
        iconUrl = json['icon_image_url'] ?? '',
        groupType = json['group_type'].toString(),
        publicUid = json['public_uid'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        // テーブルを結合してキャッシュしたdrillの情報,
        answerHistoriesCount = json['answer_histories_count'] ?? 0;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'introduction': introduction,
        'imageUrl': imageUrl,
        'iconUrl': iconUrl,
        'groupType': groupType,
        'publicUid': publicUid,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        // テーブルを結合してキャッシュしたdrillの情報,
        'answerHistoriesCount': answerHistoriesCount,
      };
}