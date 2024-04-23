import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/models/user.dart';

class SentenceRequestVote {
  SentenceRequestVote(
      {required this.id,
      required this.sentenceRequestId,
      required this.userId,
      required this.upvoted,
      this.sentenceRequest,
      this.user});
  final int id;
  final int sentenceRequestId;
  final int userId;
  final bool upvoted;
  final SentenceRequest? sentenceRequest;
  final User? user;

  factory SentenceRequestVote.fromJson(Map<String, dynamic> json) {
    return SentenceRequestVote(
      id: json['id'],
      sentenceRequestId: json['sentence_request_id'],
      userId: json['user_id'],
      upvoted: json['upvoted'],
      sentenceRequest: json['sentence_request'] != null
          ? SentenceRequest.fromJson(json['sentence_request'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sentence_request_id': sentenceRequestId,
      'user_id': userId,
      'upvoted': upvoted,
      'sentence_request': sentenceRequest?.toJson(),
      'user': user?.toJson(),
    };
  }
}
