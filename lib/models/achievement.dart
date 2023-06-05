class Achievement {
  Achievement({
    required this.id,
    required this.orderNumber,
    required this.name,
    this.introduction,
    this.praiseText,
    required this.exp,
    required this.imageUrl,
    required this.lockedImageUrl,
    required this.tutorial,
    required this.numberOfAnswers,
    // required this.daysAnswered,
    required this.master,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int orderNumber;
  String name;
  String? introduction;
  String? praiseText;
  int exp;
  String imageUrl;
  String lockedImageUrl;
  bool tutorial;
  bool numberOfAnswers;
  // bool daysAnswered;
  bool master;
  DateTime createdAt;
  DateTime updatedAt;

  Achievement.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        orderNumber = json['order_number'],
        name = json['name'] ?? '',
        introduction = json['introduction'] ?? '',
        praiseText = json['praise_text'] ?? '',
        exp = json['exp'],
        imageUrl = json['cloudinary_image'] ?? '',
        lockedImageUrl = json['cloudinary_image_locked'] ?? '',
        tutorial = json['tutorial'],
        numberOfAnswers = json['number_of_answers'],
        //daysAnswered = json['days_answered'],
        master = json['master'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_number': orderNumber,
        'name': name,
        'introduction': introduction,
        'praise_text': praiseText,
        'exp': exp,
        'cloudinary_image': imageUrl,
        'cloudinary_image_locked': lockedImageUrl,
        'tutorial': tutorial,
        'number_of_answers': numberOfAnswers,
        //'days_answered': daysAnswered,
        'master': master,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
