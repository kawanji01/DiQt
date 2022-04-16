import 'package:booqs_mobile/models/answer_setting.dart';

class User {
  User({
    this.id = 0,
    this.publicUid = '',
    this.name = '',
    this.icon = '',
    this.profile = '',
    this.iconImageUrl = '',
    this.amountOfExp = 0,
    this.answerHistoriesCount = 0,
    this.todaysAnswerHistoriesCount = 0,
    this.answerDaysCount = 0,
    this.achievementMapsCount = 0,
    this.premium = false,
    this.paidViaNativeApp = false,
    this.unreadNotificationsCount = 0,
    this.unsolvedReviewsCount = 0,
    this.reviewsCount = 0,
    this.weaknessesCount = 0,
    this.rewardRemained = false,
    this.authToken,
    this.answerSetting,
  });

  int id;
  String publicUid;
  String name;
  String? icon;
  String? profile;
  String? iconImageUrl;
  int amountOfExp;
  int answerHistoriesCount;
  int todaysAnswerHistoriesCount;
  int answerDaysCount;
  int achievementMapsCount;
  bool premium;
  bool paidViaNativeApp;
  int unreadNotificationsCount;
  int unsolvedReviewsCount;
  int reviewsCount;
  int weaknessesCount;
  bool rewardRemained;
  String? authToken;
  AnswerSetting? answerSetting;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        publicUid = json['public_uid'],
        name = json['name'],
        icon = json['icon'],
        profile = json['profile'],
        iconImageUrl = json['icon_image_url'],
        amountOfExp = json['amount_of_exp'],
        answerHistoriesCount = json['answer_histories_count'],
        todaysAnswerHistoriesCount = json['todays_answer_histories_count'],
        answerDaysCount = json['answer_days_count'],
        achievementMapsCount = json['achievement_maps_count'],
        premium = json['premium'],
        paidViaNativeApp = json['paid_via_native_app'],
        unreadNotificationsCount = json['unread_notifications_count'],
        unsolvedReviewsCount = json['unsolved_reviews_count'],
        reviewsCount = json['reviews_count'],
        weaknessesCount = json['weaknesses_count'],
        rewardRemained = json['reward_remained'],
        authToken = json['token_for_native_app'],
        answerSetting = json['answer_setting'] == null
            ? null
            : AnswerSetting.fromJson(json['answer_setting']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'public_uid': publicUid,
        'name': name,
        'icon': icon,
        'profile': profile,
        'icon_image_url': iconImageUrl,
        'amount_of_exp': amountOfExp,
        'answer_histories_count': answerHistoriesCount,
        'todays_answer_histories_count': todaysAnswerHistoriesCount,
        'answer_days_count': answerDaysCount,
        'achievement_maps_count': achievementMapsCount,
        'premium': premium,
        'paid_via_native_app': paidViaNativeApp,
        'reward_remained': rewardRemained,
        'unsolved_reviews_count': unsolvedReviewsCount,
        'reviews_count': reviewsCount,
        'token_for_native_app': authToken,
        'answer_setting': answerSetting,
      };
}
