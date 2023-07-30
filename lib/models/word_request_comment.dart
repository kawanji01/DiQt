import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/word_request.dart';

class WordRequestComment {
  WordRequestComment({
    required this.id,
    required this.wordRequestId,
    required this.body,
    required this.appliedDictionaryId,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.wordRequest,
  });
  final int id;
  final int wordRequestId;
  final String body;
  final int? appliedDictionaryId;
  final String createdAt;
  final String updatedAt;
  final User? user;
  final WordRequest? wordRequest;

  factory WordRequestComment.fromJson(Map<String, dynamic> json) {
    return WordRequestComment(
      id: json['id'],
      wordRequestId: json['word_request_id'],
      body: json['body'],
      appliedDictionaryId: json['applied_dictionary_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      wordRequest: json['word_request'] != null
          ? WordRequest.fromJson(json['word_request'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word_request_id': wordRequestId,
      'body': body,
      'applied_dictionary_id': appliedDictionaryId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user,
      'word_request': wordRequest,
    };
  }
}
