class Quiz {
  Quiz({
    this.id,
    this.quizId,
    this.drillId,
    this.wordId,
    this.referenceWordId,
    this.question,
    this.langNumberOfQuestion,
    this.questionReadAloud,
    this.correctAnswer,
    this.langNumberOfAnswer,
    this.answerReadAloud,
    this.distractors,
    this.explanation,
    this.hint,
  });

  int? id;
  int? quizId;
  int? drillId;
  int? wordId;
  int? referenceWordId;
  String? question;
  int? langNumberOfQuestion;
  bool? questionReadAloud;
  String? correctAnswer;
  int? langNumberOfAnswer;
  bool? answerReadAloud;
  String? distractors;
  String? explanation;
  String? hint;

  Quiz.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        quizId = json['quiz_id'],
        drillId = json['drill_id'],
        question = json['question'],
        langNumberOfQuestion = json['lang_number_of_question'],
        questionReadAloud = json['question_read_aloud'],
        correctAnswer = json['correct_answer'],
        langNumberOfAnswer = json['lang_number_of_answer'],
        answerReadAloud = json['answer_read_aloud'],
        distractors = json['distractors'],
        explanation = json['explanation'],
        hint = json['hint'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'quizId': quizId,
        'drillId': drillId,
        'question': question,
        'langNumberOfQuestion': langNumberOfQuestion,
        'questionReadAloud': questionReadAloud,
        'correctAnswer': correctAnswer,
        'langNumberOfAnswer': langNumberOfAnswer,
        'answerReadAloud': answerReadAloud,
        'distractors': distractors,
        'explanation': explanation,
        'hint': hint,
      };
}
