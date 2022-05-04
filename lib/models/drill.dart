import 'package:booqs_mobile/models/drill_lap.dart';

class Drill {
  Drill(
      {required this.id,
      this.userId,
      this.chapterId,
      this.dictionaryId,
      this.sentenceDictionaryId,
      required this.title,
      required this.introduction,
      this.imageUrl = '',
      this.referenceUrl,
      required this.thumbnailUrl,
      required this.publicUid,
      required this.answerHistoriesCount,
      required this.quizzesCount,
      required this.createdAt,
      required this.updatedAt,
      this.drillLap});

  int id;
  int? userId;
  int? chapterId;
  int? dictionaryId;
  int? sentenceDictionaryId;
  String title;
  String introduction;
  String imageUrl;
  String? referenceUrl;
  String thumbnailUrl;
  String publicUid;
  DateTime createdAt;
  DateTime updatedAt;
  int answerHistoriesCount;
  int quizzesCount;
  DrillLap? drillLap;

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
        thumbnailUrl = json['thumbnail_url'],
        publicUid = json['public_uid'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        answerHistoriesCount = json['answer_histories_count'],
        quizzesCount = json['quizzes_count'],
        drillLap = json['drill_lap'] == null
            ? null
            : DrillLap.fromJson(json['drill_lap']);

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
        'thumbnail_url': thumbnailUrl,
        'publicUid': publicUid,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'answerHistoriesCount': answerHistoriesCount,
        'quizzesCount': quizzesCount,
        'drill_lap': drillLap,
      };
}
