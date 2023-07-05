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

  RequestComment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        wordRequestId = json['word_request_id'],
        sentenceRequestId = json['sentence_request_id'],
        quizRequestId = json['quiz_request_id'],
        content = json['content'],
        appliedDictionaryId = json['applied_dictionary_id'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

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
      };
}
