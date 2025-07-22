import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/drill_lap.dart';

class Drill {
  Drill(
      {required this.id,
      required this.appliedDictionaryId,
      this.userId,
      this.chapterId,
      this.dictionaryId,
      this.sentenceDictionaryId,
      required this.title,
      required this.langNumberOfTitle,
      required this.introduction,
      this.referenceUrl,
      required this.thumbnailUrl,
      required this.publicUid,
      required this.strictSolvingMode,
      required this.examMode,
      required this.archivedAt,
      required this.answerHistoriesCount,
      required this.quizzesCount,
      required this.createdAt,
      required this.updatedAt,
      this.drillLap,
      this.chapter,
      this.dictionary});

  int id;
  int appliedDictionaryId;
  int? userId;
  int? chapterId;
  int? dictionaryId;
  int? sentenceDictionaryId;
  String title;
  int langNumberOfTitle;
  String introduction;
  String? referenceUrl;
  String thumbnailUrl;
  String publicUid;
  bool strictSolvingMode;
  bool examMode;
  DateTime? archivedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int answerHistoriesCount;
  int quizzesCount;
  DrillLap? drillLap;
  Chapter? chapter;
  Dictionary? dictionary;

  Drill.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        appliedDictionaryId = json['applied_dictionary_id'],
        userId = json['user_id'],
        chapterId = json['chapter_id'],
        dictionaryId = json['dictionary_id'],
        sentenceDictionaryId = json['sentence_dictionary_id'],
        title = json['title'] ?? '',
        langNumberOfTitle = json['lang_number_of_title'],
        introduction = json['introduction'] ?? '',
        referenceUrl = json['reference_url'] ?? '',
        thumbnailUrl = json['thumbnail_url'] ?? '',
        publicUid = json['public_uid'],
        strictSolvingMode = json['strict_solving_mode'],
        examMode = json['exam_mode'],
        archivedAt = json['archived_at'] == null
            ? null
            : DateTime.parse(json['archived_at']),
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        answerHistoriesCount = json['answer_histories_count'],
        quizzesCount = json['quizzes_count'],
        drillLap = json['drill_lap'] == null
            ? null
            : DrillLap.fromJson(json['drill_lap']),
        chapter =
            json['chapter'] == null ? null : Chapter.fromJson(json['chapter']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['dictionary']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'applied_dictionary_id': appliedDictionaryId,
        'user_id': userId,
        'chapter_id': chapterId,
        'dictionary_id': dictionaryId,
        'sentence_dictionary_id': sentenceDictionaryId,
        'lang_number_of_title': title,
        'langNumberOfTitle': langNumberOfTitle,
        'introduction': introduction,
        'reference_url': referenceUrl,
        'thumbnail_url': thumbnailUrl,
        'public_uid': publicUid,
        'strict_solving_mode': strictSolvingMode,
        'exam_mode': examMode,
        'archived_at': archivedAt,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'answer_histories_count': answerHistoriesCount,
        'quizzes_count': quizzesCount,
        'drill_lap': drillLap,
        'chapter': chapter,
        'dictionary': dictionary,
      };
}
