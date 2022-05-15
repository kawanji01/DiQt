class Note {
  Note({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  int quizId;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        quizId = json['quiz_id'],
        content = json['content'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'quiz_id': quizId,
        'content': content,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
