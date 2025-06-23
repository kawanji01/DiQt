import 'package:booqs_mobile/models/dictionary.dart';

class DictionaryBuilder {
  static Dictionary build({
    int? id,
    String? title,
    String? introduction,
    String? guideline,
    String? credit,
    String? license,
    String? image,
    String? thumbnailUrl,
    String? publicUid,
    int? langNumberOfEntry,
    int? langNumberOfMeaning,
    int? wordsCount,
    int? sentencesCount,
    int? wordRequestsCount,
    int? sentenceRequestsCount,
    int? quizRequestsCount,
    int? acceptedWordRequestsCount,
    int? pendingWordRequestsCount,
    int? acceptedSentenceRequestsCount,
    int? pendingSentenceRequestsCount,
    int? acceptedQuizRequestsCount,
    int? pendingQuizRequestsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? sentenceRequired,
    bool? ipaRequired,
    bool? posTagRequired,
  }) {
    final now = DateTime.now();
    return Dictionary(
      id: id ?? 1,
      title: title ?? 'Test Dictionary',
      introduction: introduction,
      guideline: guideline,
      credit: credit,
      license: license,
      image: image,
      thumbnailUrl: thumbnailUrl,
      publicUid: publicUid ?? 'test-dict-123',
      langNumberOfEntry: langNumberOfEntry ?? 21,  // English
      langNumberOfMeaning: langNumberOfMeaning ?? 44,  // Japanese
      wordsCount: wordsCount ?? 100,
      sentencesCount: sentencesCount ?? 50,
      wordRequestsCount: wordRequestsCount ?? 10,
      sentenceRequestsCount: sentenceRequestsCount ?? 5,
      quizRequestsCount: quizRequestsCount ?? 3,
      acceptedWordRequestsCount: acceptedWordRequestsCount ?? 5,
      pendingWordRequestsCount: pendingWordRequestsCount ?? 2,
      acceptedSentenceRequestsCount: acceptedSentenceRequestsCount ?? 4,
      pendingSentenceRequestsCount: pendingSentenceRequestsCount ?? 1,
      acceptedQuizRequestsCount: acceptedQuizRequestsCount ?? 2,
      pendingQuizRequestsCount: pendingQuizRequestsCount ?? 1,
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? now,
      sentenceRequired: sentenceRequired ?? false,
      ipaRequired: ipaRequired ?? false,
      posTagRequired: posTagRequired ?? false,
    );
  }
}