class User {
  User({
    this.id,
    this.publicUid,
    this.name = '',
    this.icon = '',
    this.profile = '',
    iconImageUrl = '',
    amountOfExp = 0,
    answerHistoriesCount = 0,
    answerDaysCount = 0,
    achievementMapsCount = 0,
  });

  int? id;
  String? publicUid;
  String? name;
  String? icon;
  String? profile;
  String? iconImageUrl;
  int? amountOfExp;
  int? answerHistoriesCount;
  int? answerDaysCount;
  int? achievementMapsCount;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        publicUid = json['public_uid'],
        name = json['name'],
        icon = json['icon'],
        profile = json['profile'],
        iconImageUrl = json['icon_image_url'],
        amountOfExp = json['amount_of_exp'],
        answerHistoriesCount = json['answer_histories_count'],
        answerDaysCount = json['answer_days_count'],
        achievementMapsCount = json['achievement_maps_count'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'publicUid': publicUid,
        'name': name,
        'icon': icon,
        'profile': profile,
        'iconImageUrl': iconImageUrl,
        'amountOfExp': amountOfExp,
        'answerHistoriesCount': answerHistoriesCount,
        'answerDaysCount': answerDaysCount,
        'achievementMapsCount': achievementMapsCount,
      };
}
