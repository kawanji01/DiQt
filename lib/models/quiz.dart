import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/models/word.dart';

class Quiz {
  Quiz({
    required this.id,
    required this.drillId,
    this.dictionaryId,
    required this.appliedDictionaryId,
    this.wordId,
    this.syncedWordId,
    this.sentenceId,
    required this.question,
    required this.langNumberOfQuestion,
    required this.questionReadAloud,
    this.questionAudioUrl,
    required this.correctAnswer,
    required this.langNumberOfAnswer,
    required this.answerReadAloud,
    this.answerAudioUrl,
    this.distractor1,
    this.distractor2,
    this.distractor3,
    required this.shortAnswerEnabled,
    required this.questionHidden,
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
    this.word,
    this.sentence,
  });

  int id;
  int drillId;
  int? dictionaryId;
  int? appliedDictionaryId;
  int? wordId;
  int? reversedWordId;
  int? syncedWordId;
  int? sentenceId;
  int? reversedSentenceId;
  String question;
  int langNumberOfQuestion;
  bool questionReadAloud;
  String? questionAudioUrl;
  String correctAnswer;
  String? answerAudioUrl;
  int langNumberOfAnswer;
  bool answerReadAloud;
  bool questionHidden;
  String? distractor1;
  String? distractor2;
  String? distractor3;
  bool shortAnswerEnabled;
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
  Word? word;
  Sentence? sentence;

  Quiz.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        drillId = json['drill_id'],
        dictionaryId = json['dictionary_id'],
        appliedDictionaryId = json['applied_dictionary_id'],
        wordId = json['word_id'],
        reversedWordId = json['reversed_word_id'],
        syncedWordId = json['synced_word_id'],
        sentenceId = json['sentence_id'],
        reversedSentenceId = json['reversed_sentence_id'],
        question = json['question'],
        langNumberOfQuestion = json['lang_number_of_question'],
        questionReadAloud = json['question_read_aloud'],
        questionAudioUrl = json['question_audio_url'],
        correctAnswer = json['correct_answer'] ?? '',
        langNumberOfAnswer = json['lang_number_of_answer'],
        answerReadAloud = json['answer_read_aloud'],
        answerAudioUrl = json['answer_audio_url'],
        distractor1 = json['distractor_1'],
        distractor2 = json['distractor_2'],
        distractor3 = json['distractor_3'],
        shortAnswerEnabled = json['short_answer_enabled'],
        questionHidden = json['question_hidden'],
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
            : Weakness.fromJson(json['weakness']),
        word = json['word'] == null ? null : Word.fromJson(json['word']),
        sentence = json['sentence'] == null
            ? null
            : Sentence.fromJson(json['sentence']);

  int? belongedWordId() => wordId ?? reversedWordId ?? syncedWordId;
  int? belongedSentenceId() => sentenceId ?? reversedSentenceId;
  bool belongsToWord() => belongedWordId() != null;
  bool belongsToSentence() => belongedSentenceId() != null;
  bool belongsToDictionary() => belongsToWord() || belongsToSentence();

  // 却下されたQuizRequestのリクエストの数
  int rejectedQuizRequestsCount() =>
      quizRequestsCount - acceptedQuizRequestsCount - pendingQuizRequestsCount;
  Map<String, dynamic> toJson() => {
        'id': id,
        'drill_id': drillId,
        'dictionary_id': dictionaryId,
        'applied_dictionary_id': appliedDictionaryId,
        'word_id': wordId,
        'synced_word_id': syncedWordId,
        'sentence_id': sentenceId,
        'reversed_sentence_id': reversedSentenceId,
        'question': question,
        'lang_number_of_question': langNumberOfQuestion,
        'question_audio_url': questionAudioUrl,
        'question_read_aloud': questionReadAloud,
        'correct_answer': correctAnswer,
        'lang_number_of_answer': langNumberOfAnswer,
        'answer_read_aloud': answerReadAloud,
        'answer_audio_url': answerAudioUrl,
        'distractor_1': distractor1,
        'distractor_2': distractor2,
        'distractor_3': distractor3,
        'short_answer_enabled': shortAnswerEnabled,
        'question_hidden': questionHidden,
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
