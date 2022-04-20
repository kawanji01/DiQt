class Sentence {
  Sentence({
    this.id = 0,
    this.dictionaryId = 0,
    this.sentenceSourceId,
    this.original = '',
    this.langNumberOfOriginal = 0,
    this.translation = '',
    this.langNumberOfTranslation = 0,
    this.explanation,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int dictionaryId;
  int? sentenceSourceId;
  String original;
  int langNumberOfOriginal;
  String translation;
  int langNumberOfTranslation;
  String? explanation;
  String? createdAt;
  String? updatedAt;

  Sentence.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        sentenceSourceId = json['sentence_source_id'],
        original = json['original'],
        langNumberOfOriginal = json['lang_number_of_original'],
        translation = json['translation'],
        langNumberOfTranslation = json['lang_number_of_translation'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'sentence_source_id': sentenceSourceId,
        'original': original,
        'lang_number_of_original': langNumberOfOriginal,
        'translation': translation,
        'lang_number_of_translation': langNumberOfTranslation,
      };
}
