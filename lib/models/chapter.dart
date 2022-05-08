class Chapter {
  Chapter(
      {required this.id,
      required this.name,
      required this.introduction,
      required this.imageUrl,
      this.iconUrl,
      this.groupType,
      required this.publicUid,
      this.referenceUrl,
      this.referenceTitle,
      this.referenceOgp,
      required this.createdAt,
      required this.updatedAt,
      // eager_loadでキャッシュしたdrillの情報
      this.answerHistoriesCount});

  int id;
  String name;
  String introduction;
  String imageUrl;
  String? iconUrl;
  String? groupType;
  String publicUid;
  String? referenceUrl;
  String? referenceTitle;
  String? referenceOgp;
  DateTime createdAt;
  DateTime updatedAt;
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
        referenceUrl = json['reference_url'],
        referenceTitle = json['reference_title'],
        referenceOgp = json['reference_ogp'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
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
        'reference_url': referenceUrl,
        'reference_title': referenceTitle,
        'referenceOgp': referenceOgp,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        // テーブルを結合してキャッシュしたdrillの情報,
        'answerHistoriesCount': answerHistoriesCount,
      };
}
