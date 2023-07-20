import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/word_request.dart';

class RequestComment {
  RequestComment({
    required this.id,
    required this.userId,
    required this.wordRequestId,
    required this.sentenceRequestId,
    required this.quizRequestId,
    required this.content,
    required this.appliedDictionaryId,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.wordRequest,
    this.sentenceRequest,
    this.quizRequest,
  });

  int id;
  int userId;
  int? wordRequestId;
  int? sentenceRequestId;
  int? quizRequestId;
  String content;
  int appliedDictionaryId;
  DateTime createdAt;
  DateTime updatedAt;
  User? user;
  WordRequest? wordRequest;
  SentenceRequest? sentenceRequest;
  QuizRequest? quizRequest;

  RequestComment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        wordRequestId = json['word_request_id'],
        sentenceRequestId = json['sentence_request_id'],
        quizRequestId = json['quiz_request_id'],
        content = json['content'],
        appliedDictionaryId = json['applied_dictionary_id'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        wordRequest = json['word_request'] != null
            ? WordRequest.fromJson(json['word_request'])
            : null,
        sentenceRequest = json['sentence_request'] != null
            ? SentenceRequest.fromJson(json['sentence_request'])
            : null,
        quizRequest = json['quiz_request'] != null
            ? QuizRequest.fromJson(json['quiz_request'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'word_request_id': wordRequestId,
        'sentence_request_id': sentenceRequestId,
        'quiz_request_id': quizRequestId,
        'content': content,
        'applied_dictionary_id': appliedDictionaryId,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'user': user?.toJson(),
        'word_request': wordRequest?.toJson(),
        'sentence_request': sentenceRequest?.toJson(),
        'quiz_request': quizRequest?.toJson(),
      };
}
