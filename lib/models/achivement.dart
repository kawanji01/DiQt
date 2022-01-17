class Achievement {
  Achievement({
    this.id,
    this.orderNumber,
    this.name = '',
    this.introduction,
    this.praiseText,
    this.exp,
    this.imageUrl,
    this.lockedImageUrl,
    this.tutorial = false,
    this.numberOfAnswers = false,
    this.daysAnswered = false,
    this.master = false,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? orderNumber;
  String name;
  String? introduction;
  String? praiseText;
  int? exp;
  String? imageUrl;
  String? lockedImageUrl;
  bool tutorial;
  bool numberOfAnswers;
  bool daysAnswered;
  bool master;
  String? createdAt;
  String? updatedAt;

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
        daysAnswered = json['days_answered'],
        master = json['master'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

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
        'days_answered': daysAnswered,
        'master': master,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
