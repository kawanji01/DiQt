class School {
  School({
    required this.name,
    required this.langNumberOfName,
    required this.publicUid,
    required this.introduction,
    required this.thumbnailUrl,
    required this.membersLimit,
    required this.memberMapsCount,
    required this.chaptersCount,
    required this.private,
    required this.appliedDictionaryId,
    required this.userId,
  });

  final String name;
  final int langNumberOfName;
  final String publicUid;
  final String introduction;
  final String thumbnailUrl;
  final int membersLimit;
  final int memberMapsCount;
  final int chaptersCount;
  final bool private;
  final int appliedDictionaryId;
  final int userId;

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      name: json['name'],
      langNumberOfName: json['lang_number_of_name'],
      publicUid: json['public_uid'],
      introduction: json['introduction'],
      thumbnailUrl: json['thumbnail_url'],
      membersLimit: json['members_limit'],
      memberMapsCount: json['member_maps_count'],
      chaptersCount: json['chapters_count'],
      private: json['private'],
      appliedDictionaryId: json['applied_dictionary_id'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'lang_number_of_name': langNumberOfName,
        'public_uid': publicUid,
        'introduction': introduction,
        'thumbnail_url': thumbnailUrl,
        'members_limit': membersLimit,
        'member_maps_count': memberMapsCount,
        'chapters_count': chaptersCount,
        'private': private,
        'applied_dictionary_id': appliedDictionaryId,
        'user_id': userId,
      };
}
