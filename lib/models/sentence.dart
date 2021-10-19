class Sentence {
  Sentence({
    this.id,
    this.sentenceDictionaryId,
    this.text,
    this.langNumberOfText,
    this.translation,
    this.langNumberOfTranslation,
    this.explanation,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? sentenceDictionaryId;
  String? text;
  int? langNumberOfText;
  String? translation;
  int? langNumberOfTranslation;
  String? explanation;
  String? createdAt;
  String? updatedAt;

  Sentence.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sentenceDictionaryId = json['sentence_dictionary_id'],
        text = json['text'],
        langNumberOfText = json['langNumberOfText'],
        translation = json['translation'],
        langNumberOfTranslation = json['langNumberOfTranslation'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'sentenceDictionaryId': sentenceDictionaryId,
        'text': text,
        'langNumberOfText': langNumberOfText,
        'translation': translation,
        'langNumberOfTranslation': langNumberOfTranslation,
      };
}
