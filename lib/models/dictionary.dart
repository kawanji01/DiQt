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
    this.usersAuthorizedToCreate = 4,
    this.createScreened = false,
    this.usersAuthorizedToUpdate = 4,
    this.updateScreened = false,
    this.usersAuthorizedToDestroy = 1,
    this.destroyScreened = false,
    this.usersAuthorizedToVote = 3,
    this.votesCountToCloseRequest = 3,
    this.sameEntryScreened = false,
    this.changingEntryScreened = false,
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
  int usersAuthorizedToCreate;
  bool createScreened;
  int usersAuthorizedToUpdate;
  bool updateScreened;
  int usersAuthorizedToDestroy;
  bool destroyScreened;
  int usersAuthorizedToVote;
  int votesCountToCloseRequest;
  bool sameEntryScreened;
  bool changingEntryScreened;
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
        usersAuthorizedToCreate = json['users_authorized_to_create'],
        createScreened = json['create_screened'],
        usersAuthorizedToUpdate = json['users_authorized_to_update'],
        updateScreened = json['update_screened'],
        usersAuthorizedToDestroy = json['users_authorized_to_destroy'],
        destroyScreened = json['destroy_screened'],
        usersAuthorizedToVote = json['users_authorized_to_vote'],
        votesCountToCloseRequest = json['votes_count_to_close_request'],
        sameEntryScreened = json['same_entry_screened'],
        changingEntryScreened = json['changing_entry_screened'],
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
        'users_authorized_to_create': usersAuthorizedToCreate,
        'create_screened': createScreened,
        'users_authorized_to_update': usersAuthorizedToUpdate,
        'update_screened': updateScreened,
        'users_authorized_to_destroy': usersAuthorizedToDestroy,
        'destroy_screened': destroyScreened,
        'users_authorized_to_vote': usersAuthorizedToVote,
        'votes_count_to_close_request': votesCountToCloseRequest,
        'same_entry_screened': sameEntryScreened,
        'changing_entry_screened': changingEntryScreened,
        'created_at': createdAt,
        'updated_at': updatedAt,
        // テーブルを結合してキャッシュしたdrillの情報,
        'drill': drill,
        'pos_tags': posTags,
      };
}
