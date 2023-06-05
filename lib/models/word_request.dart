import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/word.dart';

class WordRequest {
  WordRequest({
    required this.id,
    required this.dictionaryId,
    required this.wordId,
    required this.userId,
    required this.entry,
    required this.previousEntry,
    required this.addition,
    required this.modification,
    required this.elimination,
    required this.acceptance,
    required this.rejection,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.word,
    this.dictionary,
  });

  int id;
  int dictionaryId;
  int? wordId;
  int? userId;
  String? entry;
  String? previousEntry;
  bool addition;
  bool modification;
  bool elimination;
  bool acceptance;
  bool rejection;
  DateTime createdAt;
  DateTime updatedAt;
  Dictionary? dictionary;
  Word? word;
  User? user;

  WordRequest.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        wordId = json['word_id'],
        userId = json['user_id'],
        entry = json['entry'],
        previousEntry = json['previous_entry'],
        addition = json['addition'],
        modification = json['modification'],
        elimination = json['elimination'],
        acceptance = json['acceptance'],
        rejection = json['rejection'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['dictionary']),
        word = json['word'] == null ? null : Word.fromJson(json['word']),
        user = json['user'] == null ? null : User.fromJson(json['user']);

  bool isPending() {
    return acceptance == false && rejection == false;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'word_id': wordId,
        'user_id': userId,
        'entry': entry,
        'previous_entry': previousEntry,
        'addition': addition,
        'modification': modification,
        'elimination': elimination,
        'acceptance': acceptance,
        'rejection': rejection,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'dictionary': dictionary,
        'word': word,
        'user': user,
      };
}
