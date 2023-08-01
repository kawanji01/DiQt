import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/models/user.dart';

class SentenceRequestComment {
  SentenceRequestComment({
    required this.id,
    required this.sentenceRequestId,
    required this.body,
    required this.appliedDictionaryId,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.sentenceRequest,
  });
  final int id;
  final int sentenceRequestId;
  final String body;
  final int? appliedDictionaryId;
  final String createdAt;
  final String updatedAt;
  final User? user;
  final SentenceRequest? sentenceRequest;

  factory SentenceRequestComment.fromJson(Map<String, dynamic> json) {
    return SentenceRequestComment(
      id: json['id'],
      sentenceRequestId: json['sentence_request_id'],
      body: json['body'],
      appliedDictionaryId: json['applied_dictionary_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      sentenceRequest: json['sentence_request'] != null
          ? SentenceRequest.fromJson(json['sentence_request'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sentence_request_id': sentenceRequestId,
      'body': body,
      'applied_dictionary_id': appliedDictionaryId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user,
      'sentence_request': sentenceRequest,
    };
  }
}
