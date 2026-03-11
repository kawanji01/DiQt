import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/answer/pronunciation_notification.dart';
import 'package:flutter_test/flutter_test.dart';

Quiz buildQuiz() {
  return Quiz(
    id: 1,
    drillId: 1,
    appliedDictionaryId: 1,
    question: 'question',
    langNumberOfQuestion: 44,
    questionReadAloud: false,
    correctAnswer: 'spoken answer',
    langNumberOfAnswer: 21,
    answerReadAloud: false,
    shortAnswerEnabled: true,
    answerMode: 'speech',
    questionHidden: false,
    autoDictLinkOfQuestion: false,
    autoDictLinkOfAnswer: false,
    acceptedQuizRequestsCount: 0,
    pendingQuizRequestsCount: 0,
    quizRequestsCount: 0,
  );
}

User buildUser() {
  return User.fromJson({
    'id': 1,
    'public_uid': 'user-1',
    'name': 'User',
    'email': 'user@example.com',
    'lang_number': 44,
    'learning_lang_number': 21,
    'time_zone_name': 'Tokyo',
    'mail_delivered': true,
    'amount_of_exp': 0,
    'answer_histories_count': 0,
    'todays_answer_histories_count': 0,
    'todays_correct_answer_histories_count': 0,
    'whole_week_answer_histories_count': 0,
    'whole_month_answer_histories_count': 0,
    'answer_days_count': 0,
    'continuous_answer_days_count': 0,
    'continuous_goal_achievement_count': 0,
    'continuous_review_completion_count': 0,
    'achievement_maps_count': 0,
    'notes_count': 0,
    'premium': true,
    'paid_via_native_app': false,
    'unread_notifications_count': 0,
    'unsolved_reviews_count': 0,
    'reviews_count': 0,
    'unsolved_weaknesses_count': 0,
    'weaknesses_count': 0,
    'drills_count': 0,
    'reward_remained': false,
    'todays_translations_count': 0,
    'todays_ai_searches_count': 0,
    'app_favored': false,
    'app_cancel_report_sent': false,
    'lang_initialized': true,
    'review_onboarding_shown': true,
    'activated': true,
  });
}

void main() {
  test('builds answer notification from pronunciation response', () {
    final Quiz quiz = buildQuiz();
    final User user = buildUser();
    final Map<String, dynamic> responseMap = {
      'status': 200,
      'answer_creator': {
        'answer_history': {
          'id': 1,
          'user_id': 1,
          'quiz_id': 1,
          'drill_id': 1,
          'answer_analysis_id': 1,
          'correct': true,
          'at_drill_page': true,
          'at_review_page': false,
          'at_weakness_page': false,
          'interval_step_up': false,
          'answer_date': '2026-03-10',
          'first_of_the_day': false,
          'answer': 'spoken answer',
          'goal_achievement': false,
          'review_completion': false,
          'continuation': false,
          'continuation_all_week': false,
          'continuation_all_month': false,
          'continuation_all_year': false,
          'time_zone_name': 'Tokyo',
          'created_at': '2026-03-10T10:00:00Z',
          'updated_at': '2026-03-10T10:00:00Z',
        },
        'base_point': 0,
        'answer_point': 0,
        'start_point': 0,
        'lap_clear_point': 0,
        'answer_days_point': 0,
        'continuous_answer_days_point': 0,
        'continuation_all_week_point': 0,
        'continuation_all_month_point': 0,
        'continuation_all_year_point': 0,
        'review_completion_point': 0,
        'continuous_review_completion_point': 0,
        'goal_achievement_point': 0,
        'continuous_goal_achievement_point': 0,
        'all_point': 0,
      },
      'user': user.toJson(),
    };

    final notification = PronunciationNotification.build(
      quiz: quiz,
      user: user,
      responseMap: responseMap,
      skipAnswerAccessGuard: true,
      countUpdatedLocally: true,
    );

    expect(notification.usersAnswer, 'spoken answer');
    expect(notification.correct, isTrue);
    expect(notification.quiz, same(quiz));
    expect(notification.user, same(user));
    expect(notification.fadeOut, isTrue);
    expect(notification.responseMap?['status'], 200);
    expect(notification.skipAnswerAccessGuard, isTrue);
    expect(notification.countUpdatedLocally, isTrue);
  });
}
