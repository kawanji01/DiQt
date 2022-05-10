import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';

class Sentence {
  Sentence({
    this.id,
    required this.dictionaryId,
    this.sentenceSourceId,
    required this.original,
    required this.langNumberOfOriginal,
    required this.translation,
    required this.langNumberOfTranslation,
    this.explanation,
    required this.createdAt,
    required this.updatedAt,
    this.quiz,
    this.dictionary,
  });

  int? id;
  int dictionaryId;
  int? sentenceSourceId;
  String original;
  int langNumberOfOriginal;
  String translation;
  int langNumberOfTranslation;
  String? explanation;
  DateTime createdAt;
  DateTime updatedAt;
  Quiz? quiz;
  Dictionary? dictionary;

  Sentence.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        sentenceSourceId = json['sentence_source_id'],
        original = json['original'],
        langNumberOfOriginal = json['lang_number_of_original'],
        translation = json['translation'],
        langNumberOfTranslation = json['lang_number_of_translation'],
        explanation = json['explanation'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        quiz = json['quiz'] == null ? null : Quiz.fromJson(json['quiz']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['dictionary']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'sentence_source_id': sentenceSourceId,
        'original': original,
        'lang_number_of_original': langNumberOfOriginal,
        'translation': translation,
        'lang_number_of_translation': langNumberOfTranslation,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'quiz': quiz,
        'dictionary': dictionary,
      };
}
