class Drill {
  Drill(
      {this.id,
      this.userId,
      this.chapterId,
      this.dictionaryId,
      this.sentenceDictionaryId,
      this.title = '',
      this.introduction = '',
      this.imageUrl,
      this.referenceUrl,
      this.publicUid,
      this.createdAt,
      this.updatedAt,
      this.answerHistoriesCount,
      this.quizzesCount});

  int? id;
  int? userId;
  int? chapterId;
  int? dictionaryId;
  int? sentenceDictionaryId;
  String title;
  String introduction;
  String? imageUrl;
  String? referenceUrl;
  String? publicUid;
  String? createdAt;
  String? updatedAt;
  int? answerHistoriesCount;
  int? quizzesCount;

  Drill.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        chapterId = json['chapter_id'],
        dictionaryId = json['dictionary_id'],
        sentenceDictionaryId = json['sentence_dictionary_id'],
        title = json['title'] ?? '',
        introduction = json['introduction'] ?? '',
        imageUrl = json['cover_image_url'] ?? '',
        referenceUrl = json['reference_url'] ?? '',
        publicUid = json['public_uid'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        answerHistoriesCount = json['answer_histories_count'] ?? 0,
        quizzesCount = json['quizzes_count'] ?? 0;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'chapterId': chapterId,
        'dictionaryId': dictionaryId,
        'sentenceDictionaryId': sentenceDictionaryId,
        'title': title,
        'introduction': introduction,
        'imageUrl': imageUrl,
        'referenceUrl': referenceUrl,
        'publicUid': publicUid,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'answerHistoriesCount': answerHistoriesCount,
        'quizzesCount': quizzesCount,
      };
}
