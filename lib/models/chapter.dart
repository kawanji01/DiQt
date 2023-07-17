class Chapter {
  Chapter({
    required this.id,
    required this.appliedDictionaryId,
    required this.title,
    required this.langNumberOfTitle,
    required this.introduction,
    required this.thumbnailUrl,
    this.iconUrl,
    this.groupType,
    required this.publicUid,
    required this.schoolId,
    required this.private,
    this.referenceUrl,
    this.referenceTitle,
    this.referenceOgp,
    required this.drillsCount,
    required this.createdAt,
    required this.updatedAt,
    // eager_loadでキャッシュしたdrillの情報
    this.answerHistoriesCount,
    // this.school
  });

  int id;
  int appliedDictionaryId;
  String title;
  int langNumberOfTitle;
  String introduction;
  String thumbnailUrl;
  String? iconUrl;
  String? groupType;
  String publicUid;
  int? schoolId;
  bool private;
  String? referenceUrl;
  String? referenceTitle;
  String? referenceOgp;
  int drillsCount;
  DateTime createdAt;
  DateTime updatedAt;
  // テーブルを結合してキャッシュしたdrillの情報
  int? answerHistoriesCount;
  //School? school;

  Chapter.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        appliedDictionaryId = json['applied_dictionary_id'],
        title = json['title'] ?? '',
        langNumberOfTitle = json['langNumberOfTitle'] ?? 44,
        introduction = json['introduction'] ?? '',
        thumbnailUrl = json['thumbnail_url'] ?? '',
        iconUrl = json['icon_image_url'] ?? '',
        groupType = json['group_type'].toString(),
        publicUid = json['public_uid'],
        schoolId = json['school_id'],
        private = json['private'],
        referenceUrl = json['reference_url'],
        referenceTitle = json['reference_title'],
        referenceOgp = json['reference_ogp'],
        drillsCount = json['drills_count'] ?? 0,
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        // テーブルを結合してキャッシュしたdrillの情報,
        answerHistoriesCount = json['answer_histories_count'] ?? 0;
  //school =
  //json['school'] != null ? School.fromJson(json['school']) : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'applied_dictionary_id': appliedDictionaryId,
        'name': title,
        'introduction': introduction,
        'thumbnail_url': thumbnailUrl,
        'icon_url': iconUrl,
        'group_type': groupType,
        'public_uid': publicUid,
        'school_id': schoolId,
        'private': private,
        'reference_url': referenceUrl,
        'reference_title': referenceTitle,
        'reference_ogp': referenceOgp,
        'drills_count': drillsCount,
        'created_at': createdAt,
        'updated_at': updatedAt,
        // テーブルを結合してキャッシュしたdrillの情報,
        'answer_histories_count': answerHistoriesCount,
        //'school': school?.toJson(),
      };
}
