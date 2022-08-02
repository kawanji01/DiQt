import 'package:booqs_mobile/models/quiz.dart';

class WordTagMap {
  WordTagMap({
    required this.id,
    required this.wordId,
    required this.wordTagId,
    required this.createdAt,
    required this.updatedAt,
    this.quiz,
  });

  int id;
  int wordId;
  int wordTagId;
  DateTime createdAt;
  DateTime updatedAt;
  Quiz? quiz;

  WordTagMap.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        wordId = json['word_id'],
        wordTagId = json['word_tag_id'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'word_id': wordId,
        'word_tag_id': wordTagId,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
