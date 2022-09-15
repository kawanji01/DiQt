import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word_tag.dart';

class Word {
  Word({
    required this.id,
    required this.dictionaryId,
    this.sentenceId,
    required this.entry,
    required this.langNumberOfEntry,
    required this.meaning,
    required this.langNumberOfMeaning,
    this.explanation = '',
    this.pos,
    this.ipa,
    this.reading,
    this.etymologies,
    this.synonyms,
    this.antonyms,
    this.related,
    this.sensesJson,
    this.wordRequestsCount = 0,
    this.acceptedWordRequestsCount = 0,
    this.pendingWordRequestsCount = 0,
    // 結合したテーブル
    this.sentence,
    this.dictionary,
    this.quiz,
    // 検索結果で表示する復讐
    this.review,
    this.wordTags,
  });

  int id;
  int dictionaryId;
  int? sentenceId;
  String entry;
  int langNumberOfEntry;
  String meaning;
  int langNumberOfMeaning;
  String? explanation;
  String? pos;
  String? ipa;
  String? reading;
  String? etymologies;
  String? synonyms;
  String? antonyms;
  String? related;
  List? sensesJson;
  int wordRequestsCount;
  int acceptedWordRequestsCount;
  int pendingWordRequestsCount;
  Sentence? sentence;
  Dictionary? dictionary;
  Quiz? quiz;
  Review? review;
  List<WordTag>? wordTags;

  Word.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        sentenceId = json['sentence_id'],
        entry = json['entry'],
        langNumberOfEntry = json['lang_number_of_entry'],
        meaning = json['meaning'],
        langNumberOfMeaning = json['lang_number_of_meaning'],
        explanation = json['explanation'],
        pos = json['pos'],
        ipa = json['ipa'],
        reading = json['reading'],
        etymologies = json['etymologies'],
        synonyms = json['synonyms'],
        antonyms = json['antonyms'],
        related = json['related'],
        sensesJson = json['senses_json'],
        wordRequestsCount = json['word_requests_count'],
        acceptedWordRequestsCount = json['accepted_word_requests_count'],
        pendingWordRequestsCount = json['pending_word_requests_count'],
        sentence = json['sentence'] == null
            ? null
            : Sentence.fromJson(json['sentence']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['dictionary']),
        quiz = json['quiz'] == null ? null : Quiz.fromJson(json['quiz']),
        review =
            json['review'] == null ? null : Review.fromJson(json['review']),
        wordTags = json['word_tags'] == null
            ? []
            : json['word_tags']
                .map<WordTag>((e) => WordTag.fromJson(e))
                .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'sentence_id': sentenceId,
        'entry': entry,
        'lang_number_of_entry': langNumberOfEntry,
        'meaning': meaning,
        'lang_number_of_meaning': langNumberOfMeaning,
        'explanation': explanation,
        'pos': pos,
        'ipa': ipa,
        'reading': reading,
        'etymologies': etymologies,
        'synonyms': synonyms,
        'antonyms': antonyms,
        'related': related,
        'senses_json': sensesJson,
        'word_requests_count': wordRequestsCount,
        'accepted_word_requests_count': acceptedWordRequestsCount,
        'pending_word_requests_count': pendingWordRequestsCount,
        'sentence': sentence,
        'dictionary': dictionary,
        'quiz': quiz,
        'review': review,
      };
}
