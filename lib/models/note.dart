class Note {
  Note({
    this.id = 0,
    this.userId = 0,
    this.quizId = 0,
    this.content = '',
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int quizId;
  String content;
  String? createdAt;
  String? updatedAt;

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        quizId = json['quiz_id'],
        content = json['content'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'quiz_id': quizId,
        'content': content,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
