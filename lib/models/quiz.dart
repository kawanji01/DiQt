import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/weakness.dart';

class Quiz {
  Quiz({
    required this.id,
    required this.drillId,
    this.dictionaryId,
    required this.appliedDictionaryId,
    this.wordId,
    this.referenceWordId,
    this.sentenceId,
    required this.question,
    required this.langNumberOfQuestion,
    required this.questionReadAloud,
    required this.correctAnswer,
    required this.langNumberOfAnswer,
    required this.answerReadAloud,
    this.distractor1,
    this.distractor2,
    this.distractor3,
    required this.flashcard,
    this.explanation,
    this.hint,
    required this.autoDictLinkOfQuestion,
    required this.autoDictLinkOfAnswer,
    required this.acceptedQuizRequestsCount,
    required this.pendingQuizRequestsCount,
    required this.quizRequestsCount,
    this.drill,
    this.review,
    this.note,
    this.answerAnalysis,
    this.weakness,
  });

  int id;
  int drillId;
  int? dictionaryId;
  int appliedDictionaryId;
  int? wordId;
  int? referenceWordId;
  int? sentenceId;
  String question;
  int langNumberOfQuestion;
  bool questionReadAloud;
  String correctAnswer;
  int langNumberOfAnswer;
  bool answerReadAloud;
  String? distractor1;
  String? distractor2;
  String? distractor3;
  bool flashcard;
  String? explanation;
  String? hint;
  bool autoDictLinkOfQuestion;
  bool autoDictLinkOfAnswer;
  int acceptedQuizRequestsCount;
  int pendingQuizRequestsCount;
  int quizRequestsCount;
  Drill? drill;
  Dictionary? dictionary;
  Review? review;
  Note? note;
  AnswerAnalysis? answerAnalysis;
  Weakness? weakness;

  Quiz.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        drillId = json['drill_id'],
        dictionaryId = json['dictionary_id'],
        appliedDictionaryId = json['applied_dictionary_id'],
        wordId = json['word_id'],
        referenceWordId = json['reference_word_id'],
        sentenceId = json['sentence_id'],
        question = json['question'],
        langNumberOfQuestion = json['lang_number_of_question'],
        questionReadAloud = json['question_read_aloud'],
        correctAnswer = json['correct_answer'],
        langNumberOfAnswer = json['lang_number_of_answer'],
        answerReadAloud = json['answer_read_aloud'],
        distractor1 = json['distractor_1'],
        distractor2 = json['distractor_2'],
        distractor3 = json['distractor_3'],
        flashcard = json['flashcard'],
        explanation = json['explanation'],
        hint = json['hint'],
        autoDictLinkOfQuestion = json['auto_dict_link_of_question'],
        autoDictLinkOfAnswer = json['auto_dict_link_of_answer'],
        acceptedQuizRequestsCount = json['accepted_quiz_requests_count'],
        pendingQuizRequestsCount = json['pending_quiz_requests_count'],
        quizRequestsCount = json['quiz_requests_count'],
        drill = json['drill'] == null ? null : Drill.fromJson(json['drill']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['dictionary']),
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
        'drill_id': drillId,
        'dictionary_id': dictionaryId,
        'applied_dictionary_id': appliedDictionaryId,
        'word_id': wordId,
        'reference_word_id': referenceWordId,
        'sentence_id': sentenceId,
        'question': question,
        'lang_number_of_question': langNumberOfQuestion,
        'question_read_aloud': questionReadAloud,
        'correct_answer': correctAnswer,
        'lang_number_of_answer': langNumberOfAnswer,
        'answer_read_aloud': answerReadAloud,
        'distractor_1': distractor1,
        'distractor_2': distractor2,
        'distractor_3': distractor3,
        'flashcard': flashcard,
        'explanation': explanation,
        'hint': hint,
        'auto_dict_link_of_question': autoDictLinkOfQuestion,
        'auto_dict_link_of_answer': autoDictLinkOfAnswer,
        'accepted_quiz_requests_count': acceptedQuizRequestsCount,
        'pending_quiz_requests_count': pendingQuizRequestsCount,
        'quiz_requests_count': quizRequestsCount,
        'drill': drill,
        'dictionary': dictionary,
        'review': review,
        'note': note,
        'answer_analysis': answerAnalysis,
        'weakness': weakness,
      };
}
