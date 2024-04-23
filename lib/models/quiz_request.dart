import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/quiz_request_vote.dart';
import 'package:booqs_mobile/models/school.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/word.dart';

class QuizRequest {
  QuizRequest({
    required this.id,
    required this.quizId,
    required this.drillId,
    required this.userId,
    required this.dictionaryId,
    required this.question,
    required this.previousQuestion,
    required this.langNumberOfQuestion,
    required this.previousLangNumberOfQuestion,
    required this.questionReadAloud,
    required this.previousQuestionReadAloud,
    required this.questionHidden,
    required this.previousQuestionHidden,
    required this.hint,
    required this.previousHint,
    required this.correctAnswer,
    required this.previousCorrectAnswer,
    required this.distractor1,
    required this.distractor2,
    required this.distractor3,
    required this.previousDistractor1,
    required this.previousDistractor2,
    required this.previousDistractor3,
    required this.langNumberOfAnswer,
    required this.previousLangNumberOfAnswer,
    required this.answerReadAloud,
    required this.previousAnswerReadAloud,
    required this.shortAnswerEnabled,
    required this.previousShortAnswerEnabled,
    required this.explanation,
    required this.previousExplanation,
    required this.addition,
    required this.modification,
    required this.elimination,
    required this.acceptance,
    required this.rejection,
    required this.comment,
    required this.quizRequestCommentsCount,
    required this.upvotesCount,
    required this.downvotesCount,
    required this.pendingReason,
    required this.createdAt,
    required this.updatedAt,
    this.votesCountToClose,
    this.quizRequestVote,
    this.user,
    this.quiz,
    this.drill,
    this.school,
    this.word,
    this.sentence,
    this.dictionary,
  });

  int id;
  int? quizId;
  int? drillId;
  int? userId;
  int? dictionaryId;
  String? question;
  String? previousQuestion;
  int? langNumberOfQuestion;
  int? previousLangNumberOfQuestion;
  bool? questionReadAloud;
  bool? previousQuestionReadAloud;
  bool? questionHidden;
  bool? previousQuestionHidden;
  String? hint;
  String? previousHint;
  String? correctAnswer;
  String? previousCorrectAnswer;
  String? distractor1;
  String? distractor2;
  String? distractor3;
  String? previousDistractor1;
  String? previousDistractor2;
  String? previousDistractor3;
  int? langNumberOfAnswer;
  int? previousLangNumberOfAnswer;
  bool? answerReadAloud;
  bool? previousAnswerReadAloud;
  bool? shortAnswerEnabled;
  bool? previousShortAnswerEnabled;
  String? explanation;
  String? previousExplanation;
  bool addition;
  bool modification;
  bool elimination;
  bool acceptance;
  bool rejection;
  String? comment;
  int quizRequestCommentsCount;
  int upvotesCount;
  int downvotesCount;
  String? pendingReason;
  DateTime createdAt;
  DateTime updatedAt;
  int? votesCountToClose;
  QuizRequestVote? quizRequestVote;
  User? user;
  Quiz? quiz;
  Drill? drill;
  School? school;
  Word? word;
  Sentence? sentence;
  Dictionary? dictionary;

  QuizRequest.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        quizId = json['quiz_id'],
        userId = json['user_id'],
        question = json['question'],
        previousQuestion = json['previous_question'],
        langNumberOfQuestion = json['lang_number_of_question'],
        previousLangNumberOfQuestion = json['previous_lang_number_of_question'],
        questionReadAloud = json['question_read_aloud'],
        previousQuestionReadAloud = json['previous_question_read_aloud'],
        questionHidden = json['question_hidden'],
        previousQuestionHidden = json['previous_question_hidden'],
        hint = json['hint'],
        previousHint = json['previous_hint'],
        correctAnswer = json['correct_answer'],
        previousCorrectAnswer = json['previous_correct_answer'],
        distractor1 = json['distractor_1'],
        distractor2 = json['distractor_2'],
        distractor3 = json['distractor_3'],
        previousDistractor1 = json['previous_distractor_1'],
        previousDistractor2 = json['previous_distractor_2'],
        previousDistractor3 = json['previous_distractor_3'],
        langNumberOfAnswer = json['lang_number_of_answer'],
        previousLangNumberOfAnswer = json['previous_lang_number_of_answer'],
        answerReadAloud = json['answer_read_aloud'],
        previousAnswerReadAloud = json['previous_answer_read_aloud'],
        shortAnswerEnabled = json['short_answer_enabled'],
        previousShortAnswerEnabled = json['previous_short_answer_enabled'],
        explanation = json['explanation'],
        previousExplanation = json['previous_explanation'],
        addition = json['addition'],
        modification = json['modification'],
        elimination = json['elimination'],
        acceptance = json['acceptance'],
        rejection = json['rejection'],
        comment = json['comment'],
        quizRequestCommentsCount = json['quiz_request_comments_count'],
        upvotesCount = json['upvotes_count'],
        downvotesCount = json['downvotes_count'],
        pendingReason = json['pending_reason'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        votesCountToClose = json['votes_count_to_close'],
        quizRequestVote = json['quiz_request_vote'] != null
            ? QuizRequestVote.fromJson(json['quiz_request_vote'])
            : null,
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        quiz = json['quiz'] != null ? Quiz.fromJson(json['quiz']) : null,
        drill = json['drill'] != null ? Drill.fromJson(json['drill']) : null,
        school =
            json['school'] != null ? School.fromJson(json['school']) : null,
        word = json['word'] != null ? Word.fromJson(json['word']) : null,
        sentence = json['sentence'] != null
            ? Sentence.fromJson(json['sentence'])
            : null,
        dictionary = json['dictionary'] != null
            ? Dictionary.fromJson(json['dictionary'])
            : null;

  bool closed() {
    return acceptance == true || rejection == true;
  }

  bool notClosed() {
    return acceptance == false && rejection == false;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'quiz_id': quizId,
        'user_id': userId,
        'question': question,
        'previous_question': previousQuestion,
        'lang_number_of_question': langNumberOfQuestion,
        'previous_lang_number_of_question': previousLangNumberOfQuestion,
        'question_read_aloud': questionReadAloud,
        'previous_question_read_aloud': previousQuestionReadAloud,
        'hint': hint,
        'previous_hint': previousHint,
        'correct_answer': correctAnswer,
        'previous_correct_answer': previousCorrectAnswer,
        'distractor_1': distractor1,
        'distractor_2': distractor2,
        'distractor_3': distractor3,
        'previous_distractor_1': previousDistractor1,
        'previous_distractor_2': previousDistractor2,
        'previous_distractor_3': previousDistractor3,
        'lang_number_of_answer': langNumberOfAnswer,
        'previous_lang_number_of_answer': previousLangNumberOfAnswer,
        'answer_read_aloud': answerReadAloud,
        'previous_answer_read_aloud': previousAnswerReadAloud,
        'explanation': explanation,
        'previous_explanation': previousExplanation,
        'addition': addition,
        'modification': modification,
        'elimination': elimination,
        'acceptance': acceptance,
        'rejection': rejection,
        'comment': comment,
        'quiz_request_comments_count': quizRequestCommentsCount,
        'upvotes_count': upvotesCount,
        'downvotes_count': downvotesCount,
        'pending_reason': pendingReason,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'votes_count_to_close': votesCountToClose,
        'quiz_request_vote': quizRequestVote?.toJson(),
        'user': user?.toJson(),
        'quiz': quiz?.toJson(),
        'drill': drill?.toJson(),
        'school': school?.toJson(),
        'word': word?.toJson(),
        'sentence': sentence?.toJson(),
        'dictionary': dictionary?.toJson(),
      };
}
