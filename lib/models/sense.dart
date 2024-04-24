import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';

class Sense {
  Sense({
    required this.id,
    required this.wordId,
    required this.dictionaryId,
    this.sentenceId,
    required this.gloss,
    this.orderNumber,
    this.explanation,
    required this.acceptedSenseRequestsCount,
    required this.pendingSenseRequestsCount,
    required this.senseRequestsCount,
    required this.createdAt,
    required this.updatedAt,
    this.quiz,
    this.sentence,
    this.dictionary,
  });

  int id;
  int wordId;
  int dictionaryId;
  int? sentenceId;
  String gloss;
  int? orderNumber;
  String? explanation;
  int acceptedSenseRequestsCount;
  int pendingSenseRequestsCount;
  int senseRequestsCount;
  DateTime createdAt;
  DateTime updatedAt;
  Word? word;
  Quiz? quiz;
  Sentence? sentence;
  Dictionary? dictionary;

  Sense.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        wordId = json['word_id'],
        dictionaryId = json['dictionary_id'],
        sentenceId = json['sentence_id'],
        gloss = json['gloss'],
        orderNumber = json['order_number'],
        explanation = json['explanation'],
        acceptedSenseRequestsCount = json['accepted_sense_requests_count'],
        pendingSenseRequestsCount = json['pending_sense_requests_count'],
        senseRequestsCount = json['sense_requests_count'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        word = json['word'] == null ? null : Word.fromJson(json['word']),
        quiz = json['quiz'] == null ? null : Quiz.fromJson(json['quiz']),
        sentence = json['sentence'] == null
            ? null
            : Sentence.fromJson(json['sentence']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['dictionary']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'word_id': wordId,
        'dictionary_id': dictionaryId,
        'sentence_id': sentenceId,
        'gloss': gloss,
        'order_number': orderNumber,
        'explanation': explanation,
        'accepted_sense_requests_count': acceptedSenseRequestsCount,
        'pending_sense_requests_count': pendingSenseRequestsCount,
        'sense_requests_count': senseRequestsCount,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'word': word,
        'quiz': quiz,
        'sentence': sentence,
        'dictionary': dictionary,
      };
}
