import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/dictionary.dart';

class WordTag {
  WordTag({
    required this.id,
    required this.dictionaryId,
    required this.chapterId,
    required this.chapterUid,
    required this.name,
    required this.introduction,
    required this.credit,
    required this.license,
    required this.wordsCount,
    required this.accepetedWordRequestsCount,
    required this.pendingWordRequestsCount,
    required this.createdAt,
    required this.updatedAt,
    this.dictionary,
    this.chapter,
  });

  int id;
  int dictionaryId;
  int chapterId;
  String chapterUid;
  String name;
  String? introduction;
  String? credit;
  String? license;
  int wordsCount;
  int accepetedWordRequestsCount;
  int pendingWordRequestsCount;
  DateTime createdAt;
  DateTime updatedAt;
  Dictionary? dictionary;
  Chapter? chapter;

  WordTag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        chapterId = json['chapter_id'],
        chapterUid = json['chapter_uid'],
        name = json['name'],
        introduction = json['introduction'],
        credit = json['credit'],
        license = json['license'],
        wordsCount = json['words_count'] ?? 0,
        accepetedWordRequestsCount = json['accepeted_word_requests_count'] ?? 0,
        pendingWordRequestsCount = json['pending_word_requests_count'] ?? 0,
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['quiz']),
        chapter =
            json['chapter'] == null ? null : Chapter.fromJson(json['chapter']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'chapter_id': chapterId,
        'chapter_uid': chapterUid,
        'name': name,
        'introduction': introduction,
        'credit': credit,
        'license': license,
        'wordsCount': wordsCount,
        'accepetedWordRequestsCount': accepetedWordRequestsCount,
        'pendingWordRequestsCount': pendingWordRequestsCount,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'dictionary': dictionary,
      };
}
