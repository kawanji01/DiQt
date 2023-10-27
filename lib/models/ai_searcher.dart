import 'package:booqs_mobile/models/user.dart';

class AISearcher {
  AISearcher({
    this.user,
    this.keyword,
    this.sourceLangNumber,
    this.sourceLangCode,
    this.sourceLanguage,
    this.targetLangNumber,
    this.targetLangCode,
    this.targetLanguage,
    this.promptKey,
    this.results,
  });
  User? user;
  String? keyword;
  int? sourceLangNumber;
  String? sourceLangCode;
  String? sourceLanguage;
  int? targetLangNumber;
  String? targetLangCode;
  String? targetLanguage;
  String? promptKey;
  String? results;

  AISearcher.fromJson(Map<String, dynamic> json)
      : user = json['user'] == null ? null : User.fromJson(json['user']),
        keyword = json['keyword'],
        sourceLangNumber = json['source_lang_number'],
        sourceLangCode = json['source_lang_code'],
        sourceLanguage = json['source_language'],
        targetLangNumber = json['target_lang_number'],
        targetLangCode = json['target_lang_code'],
        targetLanguage = json['target_language'],
        promptKey = json['prompt_key'],
        results = json['results'];

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'keyword': keyword,
        'source_lang_number': sourceLangNumber,
        'source_lang_code': sourceLangCode,
        'source_language': sourceLanguage,
        'target_lang_number': targetLangNumber,
        'target_lang_code': targetLangCode,
        'target_language': targetLanguage,
        'prompt_key': promptKey,
        'results': results,
      };
}
