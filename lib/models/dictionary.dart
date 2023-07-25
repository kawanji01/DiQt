import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/pos_tag.dart';
import 'package:booqs_mobile/utils/language_handler.dart';

class Dictionary {
  Dictionary({
    required this.id,
    required this.title,
    this.introduction,
    this.guideline,
    this.credit,
    this.license,
    this.image,
    this.thumbnailUrl,
    required this.publicUid,
    required this.langNumberOfEntry,
    required this.langNumberOfMeaning,
    this.requestScreened = false,
    this.wordsCount = 0,
    this.sentencesCount = 0,
    this.wordRequestsCount = 0,
    this.acceptedWordRequestsCount = 0,
    this.pendingWordRequestsCount = 0,
    this.acceptedSentenceRequestsCount = 0,
    this.pendingSentenceRequestsCount = 0,
    this.acceptedQuizRequestsCount = 0,
    this.pendingQuizRequestsCount = 0,
    required this.createdAt,
    required this.updatedAt,
    // eager_loadでキャッシュしたdrillの情報
    this.drill,
    this.posTags,
  });

  int id;
  String title;
  String? introduction;
  String? guideline;
  String? credit;
  String? license;
  String? image;
  String? thumbnailUrl;
  String publicUid;
  int langNumberOfEntry;
  int langNumberOfMeaning;
  bool requestScreened;
  int wordsCount;
  int sentencesCount;
  int wordRequestsCount;
  int acceptedWordRequestsCount;
  int pendingWordRequestsCount;
  int acceptedSentenceRequestsCount;
  int pendingSentenceRequestsCount;
  int acceptedQuizRequestsCount;
  int pendingQuizRequestsCount;

  DateTime createdAt;
  DateTime updatedAt;
  // テーブルを結合してキャッシュしたdrillの情報
  Drill? drill;
  List<PosTag>? posTags;

  Dictionary.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        introduction = json['introduction'],
        guideline = json['guideline'],
        credit = json['credit'],
        license = json['license'],
        thumbnailUrl = json['thumbnail_url'],
        image = json['image'].toString(),
        publicUid = json['public_uid'],
        langNumberOfEntry = json['lang_number_of_entry'],
        langNumberOfMeaning = json['lang_number_of_meaning'],
        requestScreened = json['request_screened'],
        wordsCount = json['words_count'],
        sentencesCount = json['sentences_count'],
        wordRequestsCount = json['word_requests_count'],
        acceptedWordRequestsCount = json['accepted_word_requests_count'],
        pendingWordRequestsCount = json['pending_word_requests_count'],
        acceptedSentenceRequestsCount =
            json['accepted_sentence_requests_count'],
        pendingSentenceRequestsCount = json['pending_sentence_requests_count'],
        acceptedQuizRequestsCount = json['accepted_quiz_requests_count'],
        pendingQuizRequestsCount = json['pending_quiz_requests_count'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        // テーブルを結合してキャッシュしたdrillの情報,
        drill = json['drill'] == null ? null : Drill.fromJson(json['drill']),
        posTags = json['pos_tags'] == null
            ? []
            : json['pos_tags'].map<PosTag>((e) => PosTag.fromJson(e)).toList();

// 却下されたwordRequestのリクエストの数
  int rejectedWordRequestsCount() =>
      wordRequestsCount - acceptedWordRequestsCount - pendingWordRequestsCount;

  // 見出し語の言語
  String languageOfEntry() =>
      LanguageHandler.getLanguageFromNumber(langNumberOfEntry);
  // 意味の言語
  String languageOfMeaning() =>
      LanguageHandler.getLanguageFromNumber(langNumberOfMeaning);
  // 辞書の名前
  String typeName() => '${languageOfEntry()} - ${languageOfMeaning()}';
  //
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'introduction': introduction,
        'guideline': guideline,
        'credit': credit,
        'license': license,
        'image': image,
        'thumbnail_url': thumbnailUrl,
        'public_uid': publicUid,
        'lang_number_of_entry': langNumberOfEntry,
        'lang_number_of_meaning': langNumberOfMeaning,
        'request_screened': requestScreened,
        'words_count': wordsCount,
        'sentences_count': sentencesCount,
        'word_requests_count': wordRequestsCount,
        'accepted_word_requests_count': acceptedWordRequestsCount,
        'pending_word_requests_count': pendingWordRequestsCount,
        'accepted_sentence_requests_count': acceptedSentenceRequestsCount,
        'pending_sentence_requests_count': pendingSentenceRequestsCount,
        'accepted_quiz_requests_count': acceptedQuizRequestsCount,
        'pending_quiz_requests_count': pendingQuizRequestsCount,

        'created_at': createdAt,
        'updated_at': updatedAt,
        // テーブルを結合してキャッシュしたdrillの情報,
        'drill': drill,
        'pos_tags': posTags,
      };
}
