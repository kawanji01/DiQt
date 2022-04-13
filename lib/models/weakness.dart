class Weakness {
  Weakness({
    this.id = 0,
    this.userId = 0,
    this.quizId = 0,
    this.solved = false,
    this.incorrectAnswersCount = 0,
    this.answersCount = 0,
    this.correctAnswerRate = 0,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int quizId;
  bool solved;
  int incorrectAnswersCount;
  int answersCount;
  double correctAnswerRate;
  String? createdAt;
  String? updatedAt;

  Weakness.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        quizId = json['quiz_id'],
        solved = json['solved'],
        incorrectAnswersCount = json['incorrect_answers_count'],
        answersCount = json['answers_count'],
        correctAnswerRate = json['correct_answer_rate'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'quiz_id': quizId,
        'solved': solved,
        'incorrect_answers_count': incorrectAnswersCount,
        'answers_count': answersCount,
        'correct_answer_rate': correctAnswerRate,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
