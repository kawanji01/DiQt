class AnswerAnalysis {
  AnswerAnalysis({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.drillId,
    required this.answerHistoriesCount,
    required this.incorrectAnswerHistoriesCount,
    required this.correctAnswerRate,
    required this.lastAnsweredAt,
    required this.lastAnswerCorrect,
    required this.solvedAtDrill,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  int quizId;
  int drillId;
  int answerHistoriesCount;
  int incorrectAnswerHistoriesCount;
  double correctAnswerRate;
  DateTime lastAnsweredAt;
  bool lastAnswerCorrect;
  bool solvedAtDrill;
  DateTime createdAt;
  DateTime updatedAt;

  AnswerAnalysis.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        quizId = json['quiz_id'],
        drillId = json['drill_id'],
        answerHistoriesCount = json['answer_histories_count'],
        incorrectAnswerHistoriesCount =
            json['incorrect_answer_histories_count'],
        correctAnswerRate = json['correct_answer_rate'],
        lastAnsweredAt = DateTime.parse(json['last_answered_at']),
        lastAnswerCorrect = json['last_answer_correct'],
        solvedAtDrill = json['solved_at_drill'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'quiz_id': quizId,
        'drill_id': drillId,
        'answer_histories_count': answerHistoriesCount,
        'incorrect_answer_histories_count': incorrectAnswerHistoriesCount,
        'correct_answer_rate': correctAnswerRate,
        'last_answered_at': lastAnsweredAt,
        'last_answer_correct': lastAnswerCorrect,
        'solved_at_drill': solvedAtDrill,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
