import 'package:booqs_mobile/models/dictionary.dart';

class SentenceSource {
  SentenceSource({
    required this.id,
    required this.dictionaryId,
    required this.title,
    required this.introduction,
    required this.publicUid,
    required this.credit,
    required this.license,
    required this.langNumberOfOriginal,
    required this.langNumberOfTranslation,
    required this.createdAt,
    required this.updatedAt,
    this.dictionary,
  });

  int id;
  int dictionaryId;
  String title;
  String? introduction;
  String publicUid;
  String? credit;
  String? license;
  int langNumberOfOriginal;
  int langNumberOfTranslation;
  DateTime createdAt;
  DateTime updatedAt;
  Dictionary? dictionary;

  SentenceSource.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        title = json['title'],
        introduction = json['introduction'],
        publicUid = json['public_uid'],
        credit = json['credit'] ?? 0,
        license = json['license'],
        langNumberOfOriginal = json['lang_number_of_original'] ?? 0,
        langNumberOfTranslation = json['lang_number_of_translation'] ?? 0,
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['quiz']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'title': title,
        'introduction': introduction,
        'public_uid': publicUid,
        'credit': credit,
        'license': license,
        'lang_number_of_original': langNumberOfOriginal,
        'lang_number_of_translation': langNumberOfTranslation,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'dictionary': dictionary,
      };
}
