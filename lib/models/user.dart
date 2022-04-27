import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/relationship.dart';

class User {
  User({
    required this.id,
    required this.publicUid,
    required this.name,
    //this.icon, carrierWaveを利用しているので、'_InternalLinkedHashMap<String, dynamic>' is not a subtype of type 'String?'が発生する
    this.profile = '',
    this.iconImageUrl = '',
    required this.amountOfExp,
    required this.answerHistoriesCount,
    required this.todaysAnswerHistoriesCount,
    required this.answerDaysCount,
    required this.achievementMapsCount,
    required this.premium,
    required this.paidViaNativeApp,
    required this.unreadNotificationsCount,
    required this.unsolvedReviewsCount,
    required this.reviewsCount,
    required this.weaknessesCount,
    required this.rewardRemained,
    this.authToken,
    this.answerSetting,
    this.drillInProgress,
    this.relationship,
  });

  int id;
  String publicUid;
  String name;
  //String? icon;
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
  Drill? drillInProgress;
  Relationship? relationship;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        publicUid = json['public_uid'],
        name = json['name'],
        //icon = json['icon'],
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
            : AnswerSetting.fromJson(json['answer_setting']),
        drillInProgress = json['drill_in_progress'] == null
            ? null
            : Drill.fromJson(json['drill_in_progress']),
        relationship = json['relationship'] == null
            ? null
            : Relationship.fromJson(json['relationship']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'public_uid': publicUid,
        'name': name,
        //'icon': icon,
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
        'drill_in_progress': drillInProgress,
        'relationship': relationship,
      };
}
