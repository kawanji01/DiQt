// model
class Flashcard {
  final int id;
  String title;

  Flashcard(this.id, this.title);

  Flashcard.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
