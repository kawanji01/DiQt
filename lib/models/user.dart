import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/relationship.dart';

class User {
  User({
    required this.id,
    required this.publicUid,
    required this.name,
    this.profile,
    this.iconImageUrl,
    required this.amountOfExp,
    required this.answerHistoriesCount,
    required this.todaysAnswerHistoriesCount,
    required this.todaysIncorrectAnswerHistoriesCount,
    required this.answerDaysCount,
    required this.continuousAnswerDaysCount,
    required this.continuousGoalAchievementCount,
    required this.continuousCompleteReviewCount,
    required this.achievementMapsCount,
    required this.premium,
    required this.paidViaNativeApp,
    required this.unreadNotificationsCount,
    required this.unsolvedReviewsCount,
    required this.reviewsCount,
    required this.unsolvedWeaknessesCount,
    required this.weaknessesCount,
    required this.rewardRemained,
    this.authToken,
    this.dateCurrent,
    this.answerSetting,
    this.drillInProgress,
    this.relationship,
    this.participatingChapters,
  });

  int id;
  String publicUid;
  String name;
  String? profile;
  String? iconImageUrl;
  int amountOfExp;
  int answerHistoriesCount;
  int todaysAnswerHistoriesCount;
  int todaysIncorrectAnswerHistoriesCount;
  int answerDaysCount;
  int continuousAnswerDaysCount;
  int continuousGoalAchievementCount;
  int continuousCompleteReviewCount;
  int achievementMapsCount;
  bool premium;
  bool paidViaNativeApp;
  int unreadNotificationsCount;
  int unsolvedReviewsCount;
  int reviewsCount;
  int unsolvedWeaknessesCount;
  int weaknessesCount;
  bool rewardRemained;
  String? authToken;
  DateTime? dateCurrent;
  AnswerSetting? answerSetting;
  Drill? drillInProgress;
  Relationship? relationship;
  List<Chapter>? participatingChapters;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        publicUid = json['public_uid'],
        name = json['name'],
        profile = json['profile'],
        iconImageUrl = json['icon_image_url'],
        amountOfExp = json['amount_of_exp'],
        answerHistoriesCount = json['answer_histories_count'],
        todaysAnswerHistoriesCount = json['todays_answer_histories_count'],
        todaysIncorrectAnswerHistoriesCount =
            json['todays_incorrect_answer_histories_count'],
        answerDaysCount = json['answer_days_count'],
        continuousAnswerDaysCount = json['continuous_answer_days_count'],
        continuousGoalAchievementCount =
            json['continuous_goal_achievement_count'],
        continuousCompleteReviewCount =
            json['continuous_complete_review_count'],
        achievementMapsCount = json['achievement_maps_count'],
        premium = json['premium'],
        paidViaNativeApp = json['paid_via_native_app'],
        unreadNotificationsCount = json['unread_notifications_count'],
        unsolvedReviewsCount = json['unsolved_reviews_count'],
        reviewsCount = json['reviews_count'],
        unsolvedWeaknessesCount = json['unsolved_weaknesses_count'],
        weaknessesCount = json['weaknesses_count'],
        rewardRemained = json['reward_remained'],
        authToken = json['token_for_native_app'],
        dateCurrent = json['date_current'] == null
            ? null
            : DateTime.parse(json['date_current']),
        answerSetting = json['answer_setting'] == null
            ? null
            : AnswerSetting.fromJson(json['answer_setting']),
        drillInProgress = json['drill_in_progress'] == null
            ? null
            : Drill.fromJson(json['drill_in_progress']),
        relationship = json['relationship'] == null
            ? null
            : Relationship.fromJson(json['relationship']),
        participatingChapters = json['participating_chapters'] == null
            ? []
            : json['participating_chapters']
                .map<Chapter>((e) => Chapter.fromJson(e))
                .toList();
// mapでjsonをList<Chapter>に変換する ref: https://zenn.dev/tris/articles/61c4a9ca398472#map%E3%81%AE%E5%9F%BA%E6%9C%AC
// toList()によってList<Chapter>がList<dynamic>に解釈されてしまう問題の解決 ref: https://pryogram.com/flutter/define-type-to-list-method/
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
        'todays_incorrect_answer_histories_count':
            todaysIncorrectAnswerHistoriesCount,
        'answer_days_count': answerDaysCount,
        'continuous_answer_days_count': continuousAnswerDaysCount,
        'continuous_goal_achievement_count': continuousGoalAchievementCount,
        'continuous_complete_review_count': continuousCompleteReviewCount,
        'achievement_maps_count': achievementMapsCount,
        'premium': premium,
        'paid_via_native_app': paidViaNativeApp,
        'reward_remained': rewardRemained,
        'unsolved_reviews_count': unsolvedReviewsCount,
        'reviews_count': reviewsCount,
        'unsolved_weaknesses_count': unsolvedWeaknessesCount,
        'weaknesses_count': weaknessesCount,
        'token_for_native_app': authToken,
        'date_current': dateCurrent,
        'answer_setting': answerSetting,
        'drill_in_progress': drillInProgress,
        'relationship': relationship,
      };
}
