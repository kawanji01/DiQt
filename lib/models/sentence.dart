class Sentence {
  Sentence({
    this.id,
    this.sentenceDictionaryId,
    this.original,
    this.langNumberOfOriginal,
    this.translation,
    this.langNumberOfTranslation,
    this.explanation,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? sentenceDictionaryId;
  String? original;
  int? langNumberOfOriginal;
  String? translation;
  int? langNumberOfTranslation;
  String? explanation;
  String? createdAt;
  String? updatedAt;

  Sentence.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sentenceDictionaryId = json['sentence_dictionary_id'],
        original = json['original'],
        langNumberOfOriginal = json['lang_number_of_original'],
        translation = json['translation'],
        langNumberOfTranslation = json['lang_number_of_translation'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'sentenceDictionaryId': sentenceDictionaryId,
        'original': original,
        'langNumberOfText': langNumberOfOriginal,
        'translation': translation,
        'langNumberOfTranslation': langNumberOfTranslation,
      };
}
