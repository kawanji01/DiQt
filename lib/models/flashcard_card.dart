class FlashcardCard {
  FlashcardCard({
    this.id,
    this.dictionaryId,
    this.entry = '',
    this.meaning = '',
  });

  int? id;
  int? dictionaryId;
  String entry;
  String meaning;

  FlashcardCard.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        entry = json['entry'],
        meaning = json['meaning'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionaryId': dictionaryId,
        'entry': entry,
        'meaning': meaning
      };
}
