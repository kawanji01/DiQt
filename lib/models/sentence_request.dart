import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/sentence_request_vote.dart';
import 'package:booqs_mobile/models/user.dart';

class SentenceRequest {
  SentenceRequest({
    required this.id,
    required this.dictionaryId,
    required this.sentenceId,
    required this.userId,
    required this.original,
    required this.previousOriginal,
    required this.langNumberOfOriginal,
    required this.translation,
    required this.previousTranslation,
    required this.langNumberOfTranslation,
    required this.explanation,
    required this.previousExplanation,
    required this.addition,
    required this.modification,
    required this.elimination,
    required this.acceptance,
    required this.rejection,
    required this.comment,
    required this.sentenceRequestCommentsCount,
    required this.upvotesCount,
    required this.downvotesCount,
    required this.pendingReason,
    required this.createdAt,
    required this.updatedAt,
    this.votesCountToClose,
    this.sentenceRequestVote,
    this.user,
    this.sentence,
    this.dictionary,
  });
  int id;
  int dictionaryId;
  int? sentenceId;
  int? userId;
  String? original;
  String? previousOriginal;
  int? langNumberOfOriginal;
  String? translation;
  String? previousTranslation;
  int? langNumberOfTranslation;
  String? explanation;
  String? previousExplanation;
  bool addition;
  bool modification;
  bool elimination;
  bool acceptance;
  bool rejection;
  String? comment;
  int sentenceRequestCommentsCount;
  int upvotesCount;
  int downvotesCount;
  String? pendingReason;
  DateTime createdAt;
  DateTime updatedAt;
  int? votesCountToClose;
  SentenceRequestVote? sentenceRequestVote;
  Dictionary? dictionary;
  Sentence? sentence;
  User? user;

  SentenceRequest.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        sentenceId = json['sentence_id'],
        userId = json['user_id'],
        original = json['original'],
        previousOriginal = json['previous_original'],
        translation = json['translation'],
        previousTranslation = json['previous_translation'],
        explanation = json['explanation'],
        previousExplanation = json['previous_explanation'],
        addition = json['addition'],
        modification = json['modification'],
        elimination = json['elimination'],
        acceptance = json['acceptance'],
        rejection = json['rejection'],
        comment = json['comment'],
        sentenceRequestCommentsCount = json['sentence_request_comments_count'],
        upvotesCount = json['upvotes_count'],
        downvotesCount = json['downvotes_count'],
        pendingReason = json['pending_reason'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        votesCountToClose = json['votes_count_to_close'],
        sentenceRequestVote = json['sentence_request_vote'] == null
            ? null
            : SentenceRequestVote.fromJson(json['sentence_request_vote']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['dictionary']),
        sentence = json['sentence'] == null
            ? null
            : Sentence.fromJson(json['sentence']),
        user = json['user'] == null ? null : User.fromJson(json['user']);

  bool notClosed() {
    return acceptance == false && rejection == false;
  }

  bool closed() {
    return acceptance == true || rejection == true;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'sentence_id': sentenceId,
        'user_id': userId,
        'original': original,
        'previous_original': previousOriginal,
        'translation': translation,
        'previous_translation': previousTranslation,
        'addition': addition,
        'modification': modification,
        'elimination': elimination,
        'acceptance': acceptance,
        'rejection': rejection,
        'comment': comment,
        'sentence_request_comments_count': sentenceRequestCommentsCount,
        'upvotes_count': upvotesCount,
        'downvotes_count': downvotesCount,
        'pending_reason': pendingReason,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'votes_count_to_close': votesCountToClose,
        'sentence_request_vote': sentenceRequestVote,
        'dictionary': dictionary,
        'sentence': sentence,
        'user': user,
      };
}
