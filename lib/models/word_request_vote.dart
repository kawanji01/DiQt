import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/word_request.dart';

class WordRequestVote {
  WordRequestVote(
      {required this.id,
      required this.wordRequestId,
      required this.userId,
      required this.upvoted,
      this.wordRequest,
      this.user});
  final int id;
  final int wordRequestId;
  final int userId;
  final bool upvoted;
  final WordRequest? wordRequest;
  final User? user;

  factory WordRequestVote.fromJson(Map<String, dynamic> json) {
    return WordRequestVote(
      id: json['id'],
      wordRequestId: json['word_request_id'],
      userId: json['user_id'],
      upvoted: json['upvoted'],
      wordRequest: json['word_request'] != null
          ? WordRequest.fromJson(json['word_request'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word_request_id': wordRequestId,
      'user_id': userId,
      'upvoted': upvoted,
      'word_request': wordRequest?.toJson(),
      'user': user?.toJson(),
    };
  }
}
