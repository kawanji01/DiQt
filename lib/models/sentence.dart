import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence_source.dart';

class Sentence {
  Sentence({
    required this.id,
    required this.dictionaryId,
    this.sentenceSourceId,
    required this.original,
    required this.langNumberOfOriginal,
    this.originalSsml,
    this.originalAudioUrl,
    required this.translation,
    required this.langNumberOfTranslation,
    this.translationJa,
    this.translationEn,
    this.explanation,
    required this.acceptedSentenceRequestsCount,
    required this.pendingSentenceRequestsCount,
    required this.sentenceRequestsCount,
    required this.createdAt,
    required this.updatedAt,
    this.quiz,
    this.reversedQuiz,
    this.sentenceSource,
    this.dictionary,
  });

  int id;
  int dictionaryId;
  int? sentenceSourceId;
  String original;
  int langNumberOfOriginal;
  String? originalSsml;
  String? originalAudioUrl;
  String translation;
  int langNumberOfTranslation;
  String? translationJa;
  String? translationEn;
  String? explanation;
  int acceptedSentenceRequestsCount;
  int pendingSentenceRequestsCount;
  int sentenceRequestsCount;
  DateTime createdAt;
  DateTime updatedAt;
  Quiz? quiz;
  Quiz? reversedQuiz;
  SentenceSource? sentenceSource;
  Dictionary? dictionary;

  Sentence.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        sentenceSourceId = json['sentence_source_id'],
        original = json['original'],
        langNumberOfOriginal = json['lang_number_of_original'],
        originalSsml = json['original_ssml'],
        originalAudioUrl = json['original_audio_url'],
        translation = json['translation'] ?? '',
        langNumberOfTranslation = json['lang_number_of_translation'],
        // 後方互換性を保つため、新旧両方のカラム名に対応
        translationJa = json['translation_ja'] ?? json['ja_translation'],
        translationEn = json['translation_en'] ?? json['en_translation'],
        explanation = json['explanation'],
        acceptedSentenceRequestsCount =
            json['accepted_sentence_requests_count'],
        pendingSentenceRequestsCount = json['pending_sentence_requests_count'],
        sentenceRequestsCount = json['sentence_requests_count'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        quiz = json['quiz'] == null ? null : Quiz.fromJson(json['quiz']),
        reversedQuiz = json['reversed_quiz'] == null
            ? null
            : Quiz.fromJson(json['reversed_quiz']),
        sentenceSource = json['sentence_source'] == null
            ? null
            : SentenceSource.fromJson(json['sentence_source']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['dictionary']);

  // 言語番号から言語コードを取得
  String langCodeOfTranslation() {
    return languageCodeMap.entries
        .firstWhere((entry) => entry.value == langNumberOfTranslation)
        .key;
  }

  // 却下されたwordRequestのリクエストの数
  int rejectedSentenceRequestsCount() =>
      sentenceRequestsCount -
      acceptedSentenceRequestsCount -
      pendingSentenceRequestsCount;

  bool monolingual() => langNumberOfOriginal == langNumberOfTranslation;
  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'sentence_source_id': sentenceSourceId,
        'original': original,
        'lang_number_of_original': langNumberOfOriginal,
        'original_ssml': originalSsml,
        'original_audio_url': originalAudioUrl,
        'translation': translation,
        'lang_number_of_translation': langNumberOfTranslation,
        'translation_ja': translationJa,
        'translation_en': translationEn,
        'accepted_sentence_requests_count': acceptedSentenceRequestsCount,
        'pending_sentence_requests_count': pendingSentenceRequestsCount,
        'sentence_requests_count': sentenceRequestsCount,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'quiz': quiz,
        'reversed_quiz': reversedQuiz,
        'sentence_source': sentenceSource,
        'dictionary': dictionary,
      };
}
