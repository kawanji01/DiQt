import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/consts/time_zone.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/relationship.dart';
import 'package:booqs_mobile/models/school.dart';
import 'package:booqs_mobile/utils/language_handler.dart';

class User {
  User({
    required this.id,
    required this.publicUid,
    required this.name,
    required this.email,
    this.profile,
    this.iconImageUrl,
    required this.langNumber,
    required this.learningLangNumber,
    required this.timeZoneName,
    required this.mailDelivered,
    required this.amountOfExp,
    required this.answerHistoriesCount,
    required this.todaysAnswerHistoriesCount,
    required this.todaysCorrectAnswerHistoriesCount,
    required this.wholeWeekAnswerHistoriesCount,
    required this.wholeMonthAnswerHistoriesCount,
    required this.answerDaysCount,
    required this.continuousAnswerDaysCount,
    required this.continuousGoalAchievementCount,
    required this.continuousReviewCompletionCount,
    required this.achievementMapsCount,
    required this.notesCount,
    required this.premium,
    required this.paidViaNativeApp,
    required this.unreadNotificationsCount,
    required this.unsolvedReviewsCount,
    required this.reviewsCount,
    required this.unsolvedWeaknessesCount,
    required this.weaknessesCount,
    required this.drillsCount,
    required this.rewardRemained,
    required this.todaysTranslationsCount,
    required this.todaysAiSearchesCount,
    required this.appFavored,
    required this.appCancelReportSent,
    required this.langInitialized,
    required this.reviewOnboardingShown,
    required this.activated,
    this.authToken,
    this.schoolId,
    this.schoolParticipation,
    this.passwordBeingSet,
    this.dateCurrent,
    this.answerSetting,
    this.drillInProgress,
    this.relationship,
    this.participatingSchools,
  });

  int id;
  String publicUid;
  String name;
  String? email;
  String? profile;
  String? iconImageUrl;
  int langNumber;
  int learningLangNumber;
  String timeZoneName;
  bool mailDelivered;
  int amountOfExp;
  int answerHistoriesCount;
  int todaysAnswerHistoriesCount;
  int todaysCorrectAnswerHistoriesCount;
  int wholeWeekAnswerHistoriesCount;
  int wholeMonthAnswerHistoriesCount;
  int answerDaysCount;
  int continuousAnswerDaysCount;
  int continuousGoalAchievementCount;
  int continuousReviewCompletionCount;
  int achievementMapsCount;
  int notesCount;
  bool premium;
  bool paidViaNativeApp;
  int unreadNotificationsCount;
  int unsolvedReviewsCount;
  int reviewsCount;
  int unsolvedWeaknessesCount;
  int weaknessesCount;
  int drillsCount;
  bool rewardRemained;
  int todaysTranslationsCount;
  int todaysAiSearchesCount;
  bool appFavored;
  bool appCancelReportSent;
  bool langInitialized;
  bool reviewOnboardingShown;
  bool activated;
  int? schoolId;
  bool? schoolParticipation;
  String? authToken;
  bool? passwordBeingSet;
  DateTime? dateCurrent;
  AnswerSetting? answerSetting;
  Drill? drillInProgress;
  Relationship? relationship;
  List<School>? participatingSchools;
  List<Drill>? drills;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        publicUid = json['public_uid'],
        name = json['name'],
        email = json['email'] ?? '',
        profile = json['profile'],
        iconImageUrl = json['icon_image_url'],
        langNumber = json['lang_number'] ?? defaultLangNumber,
        learningLangNumber = json['learning_lang_number'] ?? defaultLangNumber,
        timeZoneName = json['time_zone_name'] ?? defaultTimeZone,
        mailDelivered = json['mail_delivered'] ?? true,
        amountOfExp = json['amount_of_exp'],
        answerHistoriesCount = json['answer_histories_count'],
        todaysAnswerHistoriesCount = json['todays_answer_histories_count'],
        todaysCorrectAnswerHistoriesCount =
            json['todays_correct_answer_histories_count'],
        wholeWeekAnswerHistoriesCount =
            json['whole_week_answer_histories_count'] ?? 0,
        wholeMonthAnswerHistoriesCount =
            json['whole_month_answer_histories_count'] ?? 0,
        answerDaysCount = json['answer_days_count'],
        continuousAnswerDaysCount = json['continuous_answer_days_count'],
        continuousGoalAchievementCount =
            json['continuous_goal_achievement_count'],
        continuousReviewCompletionCount =
            json['continuous_review_completion_count'] ?? 0,
        achievementMapsCount = json['achievement_maps_count'],
        notesCount = json['notes_count'],
        premium = json['premium'],
        paidViaNativeApp = json['paid_via_native_app'],
        unreadNotificationsCount = json['unread_notifications_count'],
        unsolvedReviewsCount = json['unsolved_reviews_count'],
        reviewsCount = json['reviews_count'],
        unsolvedWeaknessesCount = json['unsolved_weaknesses_count'],
        weaknessesCount = json['weaknesses_count'],
        drillsCount = json['drills_count'],
        rewardRemained = json['reward_remained'],
        todaysTranslationsCount = json['todays_translations_count'],
        todaysAiSearchesCount = json['todays_ai_searches_count'],
        appFavored = json['app_favored'],
        appCancelReportSent = json['app_cancel_report_sent'],
        langInitialized = json['lang_initialized'],
        reviewOnboardingShown = json['review_onboarding_shown'],
        activated = json['activated'],
        authToken = json['token_for_native_app'],
        schoolId = json['school_id'],
        schoolParticipation = json['school_participation'],
        passwordBeingSet = json['password_being_set'],
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
        drills = json['drills'] == null
            ? []
            : json['drills'].map<Chapter>((e) => Drill.fromJson(e)).toList(),
        participatingSchools = json['participating_schools'] == null
            ? []
            : json['participating_schools']
                .map<Chapter>((e) => Chapter.fromJson(e))
                .toList();

// 言語コード
  String langCode() => LanguageHandler.getLangCode(langNumber);
// Locale
  String locale() {
    return LanguageHandler.getLangCode(langNumber);
  }

// mapでjsonをList<Chapter>に変換する ref: https://zenn.dev/tris/articles/61c4a9ca398472#map%E3%81%AE%E5%9F%BA%E6%9C%AC
// toList()によってList<Chapter>がList<dynamic>に解釈されてしまう問題の解決 ref: https://pryogram.com/flutter/define-type-to-list-method/
  Map<String, dynamic> toJson() => {
        'id': id,
        'public_uid': publicUid,
        'name': name,
        'email': email,
        //'icon': icon,
        'profile': profile,
        'icon_image_url': iconImageUrl,
        'lang_number': langNumber,
        'learning_lang_number': learningLangNumber,
        'time_zone_name': timeZoneName,
        'mail_delivered': mailDelivered,
        'amount_of_exp': amountOfExp,
        'answer_histories_count': answerHistoriesCount,
        'todays_answer_histories_count': todaysAnswerHistoriesCount,
        'todays_correct_answer_histories_count':
            todaysCorrectAnswerHistoriesCount,
        'whole_week_answer_histories_count': wholeWeekAnswerHistoriesCount,
        'whole_month_answer_histories_count': wholeMonthAnswerHistoriesCount,
        'answer_days_count': answerDaysCount,
        'continuous_answer_days_count': continuousAnswerDaysCount,
        'continuous_goal_achievement_count': continuousGoalAchievementCount,
        'continuous_review_completion_count': continuousReviewCompletionCount,
        'achievement_maps_count': achievementMapsCount,
        'notes_count': notesCount,
        'premium': premium,
        'paid_via_native_app': paidViaNativeApp,
        'reward_remained': rewardRemained,
        'unread_notifications_count': unreadNotificationsCount,
        'unsolved_reviews_count': unsolvedReviewsCount,
        'reviews_count': reviewsCount,
        'unsolved_weaknesses_count': unsolvedWeaknessesCount,
        'weaknesses_count': weaknessesCount,
        'drills_count': drillsCount,
        'todays_translations_count': todaysTranslationsCount,
        'todays_ai_searches_count': todaysAiSearchesCount,
        'app_favored': appFavored,
        'app_cancel_report_sent': appCancelReportSent,
        'lang_initialized': langInitialized,
        'review_onboarding_shown': reviewOnboardingShown,
        'activated': activated,
        'token_for_native_app': authToken,
        'school_id': schoolId,
        'school_participation': schoolParticipation,
        'date_current': dateCurrent,
        'answer_setting': answerSetting,
        'drill_in_progress': drillInProgress,
        'relationship': relationship,
        'drills': drills,
        'participating_schools': participatingSchools,
      };
}
