class Word {
  Word(
      {this.id,
      this.dictionaryId,
      this.sentenceId,
      this.entry = '',
      this.langNumberOfEntry,
      this.meaning = '',
      this.langNumberOfMeaning,
      this.explanation = '',
      this.ipa,
      this.reading,
      this.phrase,
      this.frequency,
      this.tags,
      this.initial,
      // 結合したsentence
      originalOfSentence,
      translationOfSentence});

  int? id;
  int? dictionaryId;
  int? sentenceId;
  String entry;
  int? langNumberOfEntry;
  String meaning;
  int? langNumberOfMeaning;
  String explanation;
  String? ipa;
  String? reading;
  bool? phrase;
  int? frequency;
  String? tags;
  String? initial;
  // 結合したsentence
  String? originalOfSentence;
  String? translationOfSentence;

  Word.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        sentenceId = json['sentence_id'],
        entry = json['entry'],
        langNumberOfEntry = json['lang_number_of_entry'],
        meaning = json['meaning'],
        langNumberOfMeaning = json['lang_number_of_meaning'],
        explanation = json['explanation'],
        ipa = json['ipa'],
        reading = json['reading'],
        phrase = json['phrase'],
        frequency = json['frequency'],
        tags = json['tags'],
        initial = json['initial'],
        // 結合したsentence
        originalOfSentence = json['sentence']?['original'] ?? '',
        translationOfSentence = json['sentence']?['translation'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionaryId': dictionaryId,
        'sentenceId': sentenceId,
        'entry': entry,
        'langNumberOfEntry': langNumberOfEntry,
        'meaning': meaning,
        'langNumberOfMeaning': langNumberOfMeaning,
        'explanation': explanation,
        'ipa': ipa,
        'reading': reading,
        'phrase': phrase,
        'frequency': frequency,
        'tags': tags,
        'initial': initial,
        // 結合したsentence
        'originalOfSentence': originalOfSentence,
        'translationOfSentence': translationOfSentence,
      };
}
