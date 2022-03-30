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
    premium = false,
    paidViaNativeApp = false,
    unreadNotificationsCount = 0,
    unsolvedReviewsCount = 0,
    weaknessesCount = 0,
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
  bool? premium;
  bool? paidViaNativeApp;
  int? unreadNotificationsCount;
  int? unsolvedReviewsCount;
  int? weaknessesCount;
  bool? rewardRemained;

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
        achievementMapsCount = json['achievement_maps_count'],
        premium = json['premium'] as bool,
        paidViaNativeApp = json['paid_via_native_app'] as bool,
        unreadNotificationsCount = json['unread_notifications_count'],
        unsolvedReviewsCount = json['unsolved_reviews_count'],
        weaknessesCount = json['weaknesses_count'],
        rewardRemained = json['reward_remained'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'public_uid': publicUid,
        'name': name,
        'icon': icon,
        'profile': profile,
        'icon_image_url': iconImageUrl,
        'amount_of_exp': amountOfExp,
        'answer_histories_count': answerHistoriesCount,
        'answer_days_count': answerDaysCount,
        'achievement_maps_count': achievementMapsCount,
        'premium': premium,
        'paid_via_native_app': paidViaNativeApp,
        'reward_remained': rewardRemained,
        'unsolved_reviews_count': unsolvedReviewsCount,
      };
}
