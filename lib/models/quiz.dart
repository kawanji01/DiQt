import 'package:booqs_mobile/models/drill.dart';

class Quiz {
  Quiz({
    this.id = 0,
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
    this.drill,
  });

  int id;
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
  Drill? drill;

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
        hint = json['hint'],
        drill = json['drill'] == null ? null : Drill.fromJson(json['drill']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'quiz_id': quizId,
        'drill_id': drillId,
        'question': question,
        'lang_number_of_question': langNumberOfQuestion,
        'question_read_aloud': questionReadAloud,
        'correct_answer': correctAnswer,
        'lang_number_of_answer': langNumberOfAnswer,
        'answer_read_aloud': answerReadAloud,
        'distractors': distractors,
        'explanation': explanation,
        'hint': hint,
        'drill': drill,
      };
}
