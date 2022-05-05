import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';

class Word {
  Word({
    this.id,
    required this.dictionaryId,
    this.sentenceId,
    required this.entry,
    required this.langNumberOfEntry,
    required this.meaning,
    required this.langNumberOfMeaning,
    this.explanation = '',
    this.ipa,
    this.reading,
    this.phrase,
    this.frequency,
    this.tags,
    this.initial,
    required this.wordRequestsCount,
    required this.acceptedWordRequestsCount,
    required this.pendingWordRequestsCount,
    // 結合したテーブル
    this.sentence,
    this.dictionary,
    this.quiz,
  });

  int? id;
  int dictionaryId;
  int? sentenceId;
  String entry;
  int langNumberOfEntry;
  String meaning;
  int langNumberOfMeaning;
  String? explanation;
  String? ipa;
  String? reading;
  bool? phrase;
  int? frequency;
  String? tags;
  String? initial;
  int wordRequestsCount;
  int acceptedWordRequestsCount;
  int pendingWordRequestsCount;
  // 結合したsentence
  Sentence? sentence;
  Dictionary? dictionary;
  Quiz? quiz;

  Word.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        sentenceId = json['sentence_id'],
        entry = json['entry'],
        langNumberOfEntry = json['lang_number_of_entry'],
        meaning = json['meaning'],
        langNumberOfMeaning = json['lang_number_of_meaning'],
        explanation = json['explanation'],
        ipa = json['ipa'],
        reading = json['reading'],
        phrase = json['phrase'],
        frequency = json['frequency'],
        tags = json['tags'],
        initial = json['initial'],
        wordRequestsCount = json['word_requests_count'],
        acceptedWordRequestsCount = json['accepted_word_requests_count'],
        pendingWordRequestsCount = json['pending_word_requests_count'],
        sentence = json['sentence'] == null
            ? null
            : Sentence.fromJson(json['sentence']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['dictionary']),
        quiz = json['quiz'] == null ? null : Quiz.fromJson(json['quiz']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'sentence_id': sentenceId,
        'entry': entry,
        'lang_number_of_entry': langNumberOfEntry,
        'meaning': meaning,
        'lang_number_of_meaning': langNumberOfMeaning,
        'explanation': explanation,
        'ipa': ipa,
        'reading': reading,
        'phrase': phrase,
        'frequency': frequency,
        'tags': tags,
        'initial': initial,
        'word_requests_count': wordRequestsCount,
        'accepted_word_requests_count': acceptedWordRequestsCount,
        'pending_word_requests_count': pendingWordRequestsCount,
        'sentence': sentence,
        'dictionary': dictionary,
        'quiz': quiz,
      };
}
