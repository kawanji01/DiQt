import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/weakness.dart';

class Quiz {
  Quiz({
    this.id = 0,
    this.quizId,
    this.drillId = 0,
    this.wordId,
    this.referenceWordId,
    this.question = '',
    this.langNumberOfQuestion,
    this.questionReadAloud = false,
    this.correctAnswer = '',
    this.langNumberOfAnswer,
    this.answerReadAloud = false,
    this.distractors,
    this.explanation,
    this.hint,
    this.drill,
    this.review,
    this.note,
    this.answerAnalysis,
    this.weakness,
  });

  int id;
  int? quizId;
  int drillId;
  int? wordId;
  int? referenceWordId;
  String question;
  int? langNumberOfQuestion;
  bool questionReadAloud;
  String correctAnswer;
  int? langNumberOfAnswer;
  bool answerReadAloud;
  String? distractors;
  String? explanation;
  String? hint;
  Drill? drill;
  Review? review;
  Note? note;
  AnswerAnalysis? answerAnalysis;
  Weakness? weakness;

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
        drill = json['drill'] == null ? null : Drill.fromJson(json['drill']),
        review =
            json['review'] == null ? null : Review.fromJson(json['review']),
        note = json['note'] == null ? null : Note.fromJson(json['note']),
        answerAnalysis = json['answer_analysis'] == null
            ? null
            : AnswerAnalysis.fromJson(json['answer_analysis']),
        weakness = json['weakness'] == null
            ? null
            : Weakness.fromJson(json['weakness']);

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
        'review': review,
        'note': note,
        'answer_analysis': answerAnalysis,
        'weakness': weakness,
      };
}
