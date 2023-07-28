import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/pos_tag.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/models/word_request_vote.dart';

class WordRequest {
  WordRequest(
      {required this.id,
      required this.dictionaryId,
      required this.wordId,
      required this.userId,
      required this.entry,
      required this.previousEntry,
      required this.langNumberOfEntry,
      required this.meaning,
      required this.previousMeaning,
      required this.langNumberOfMeaning,
      required this.ipa,
      required this.previousIpa,
      required this.reading,
      required this.previousReading,
      required this.posTagId,
      required this.previousPosTagId,
      required this.sentenceId,
      required this.previousSentenceId,
      required this.explanation,
      required this.previousExplanation,
      required this.addition,
      required this.modification,
      required this.elimination,
      required this.acceptance,
      required this.rejection,
      required this.comment,
      required this.upvotesCount,
      required this.downvotesCount,
      required this.createdAt,
      required this.updatedAt,
      this.votesCountToClose,
      this.wordRequestVote,
      this.user,
      this.word,
      this.dictionary,
      this.posTag,
      this.previousPosTag,
      this.sentence,
      this.previousSentence});

  int id;
  int dictionaryId;
  int? wordId;
  int? userId;
  String? entry;
  String? previousEntry;
  int? langNumberOfEntry;
  String? meaning;
  String? previousMeaning;
  int? langNumberOfMeaning;
  String? ipa;
  String? previousIpa;
  String? reading;
  String? previousReading;
  int? posTagId;
  int? previousPosTagId;
  int? sentenceId;
  int? previousSentenceId;
  String? explanation;
  String? previousExplanation;
  bool addition;
  bool modification;
  bool elimination;
  bool acceptance;
  bool rejection;
  String? comment;
  int upvotesCount;
  int downvotesCount;
  DateTime createdAt;
  DateTime updatedAt;
  int? votesCountToClose;
  WordRequestVote? wordRequestVote;
  Dictionary? dictionary;
  Word? word;
  User? user;
  PosTag? posTag;
  PosTag? previousPosTag;
  Sentence? sentence;
  Sentence? previousSentence;

  WordRequest.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        wordId = json['word_id'],
        userId = json['user_id'],
        entry = json['entry'],
        previousEntry = json['previous_entry'],
        langNumberOfEntry = json['lang_number_of_entry'],
        meaning = json['meaning'],
        previousMeaning = json['previous_meaning'],
        langNumberOfMeaning = json['lang_number_of_meaning'],
        explanation = json['explanation'],
        previousExplanation = json['previous_explanation'],
        addition = json['addition'],
        modification = json['modification'],
        elimination = json['elimination'],
        acceptance = json['acceptance'],
        rejection = json['rejection'],
        comment = json['comment'],
        upvotesCount = json['upvotes_count'],
        downvotesCount = json['downvotes_count'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        votesCountToClose = json['votes_count_to_close'],
        wordRequestVote = json['word_request_vote'] == null
            ? null
            : WordRequestVote.fromJson(json['word_request_vote']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['dictionary']),
        word = json['word'] == null ? null : Word.fromJson(json['word']),
        user = json['user'] == null ? null : User.fromJson(json['user']),
        posTag =
            json['pos_tag'] == null ? null : PosTag.fromJson(json['pos_tag']),
        previousPosTag = json['previous_pos_tag'] == null
            ? null
            : PosTag.fromJson(json['previous_pos_tag']),
        sentence = json['sentence'] == null
            ? null
            : Sentence.fromJson(json['sentence']),
        previousSentence = json['previous_sentence'] == null
            ? null
            : Sentence.fromJson(json['previous_sentence']);

  bool isPending() {
    return acceptance == false && rejection == false;
  }

  bool closed() {
    return acceptance == true || rejection == true;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'word_id': wordId,
        'user_id': userId,
        'entry': entry,
        'previous_entry': previousEntry,
        'meaning': meaning,
        'previous_meaning': previousMeaning,
        'addition': addition,
        'modification': modification,
        'elimination': elimination,
        'acceptance': acceptance,
        'rejection': rejection,
        'comment': comment,
        'upvotes_count': upvotesCount,
        'downvotes_count': downvotesCount,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'votes_count_to_close': votesCountToClose,
        'word_request_vote': wordRequestVote,
        'dictionary': dictionary,
        'word': word,
        'user': user,
        'pos_tag': posTag,
        'previous_pos_tag': previousPosTag,
        'sentence': sentence,
        'previous_sentence': previousSentence,
      };
}
