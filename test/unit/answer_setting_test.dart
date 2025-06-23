import 'package:flutter_test/flutter_test.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import '../builders/answer_setting_builder.dart';

void main() {
  group('AnswerSetting', () {
    group('constructor', () {
      test('should create instance with required values', () {
        final now = DateTime.now();
        final answerSetting = AnswerSetting(
          id: 1,
          userId: 100,
          intervalStepUpCondition: 2,
          initialInterval: 1,
          dailyGoal: 30,
          choicesCovered: false,
          questionCovered: false,
          strictSolvingMode: false,
          reviewNotificationTimer: 12,
          reviewNotificationTimerSet: false,
          reviewNotificationEnabled: false,
          strictReviewingMode: false,
          seEnabled: true,
          effectEnabled: true,
          speechRate: 50,
          reviewDeleteCondition: 7,
          weaknessCondition: 3,
          overcomingCondition: 80,
          createdAt: now,
          updatedAt: now,
        );
        
        expect(answerSetting.id, 1);
        expect(answerSetting.userId, 100);
        expect(answerSetting.intervalStepUpCondition, 2);
        expect(answerSetting.dailyGoal, 30);
        expect(answerSetting.choicesCovered, false);
        expect(answerSetting.seEnabled, true);
        expect(answerSetting.speechRate, 50);
      });

      test('should create instance with different boolean combinations', () {
        final answerSetting = AnswerSettingBuilder.build(
          choicesCovered: true,
          questionCovered: true,
          strictSolvingMode: true,
          reviewNotificationEnabled: true,
          strictReviewingMode: true,
          seEnabled: false,
          effectEnabled: false,
        );
        
        expect(answerSetting.choicesCovered, true);
        expect(answerSetting.questionCovered, true);
        expect(answerSetting.strictSolvingMode, true);
        expect(answerSetting.reviewNotificationEnabled, true);
        expect(answerSetting.strictReviewingMode, true);
        expect(answerSetting.seEnabled, false);
        expect(answerSetting.effectEnabled, false);
      });
    });

    group('fromJson', () {
      test('should create instance from JSON with all fields', () {
        final json = {
          'id': 1,
          'user_id': 100,
          'interval_step_up_condition': 3,
          'initial_interval': 2,
          'daily_goal': 50,
          'choices_covered': true,
          'question_covered': true,
          'strict_solving_mode': false,
          'review_notification_timer': 18,
          'review_notification_timer_set': true,
          'review_notification_enabled': true,
          'strict_reviewing_mode': false,
          'se_enabled': true,
          'effect_enabled': false,
          'speech_rate': 75,
          'review_delete_condition': 5,
          'weakness_condition': 2,
          'overcoming_condition': 90,
          'created_at': '2024-01-01T00:00:00Z',
          'updated_at': '2024-01-02T12:30:00Z',
        };

        final answerSetting = AnswerSetting.fromJson(json);
        
        expect(answerSetting.id, 1);
        expect(answerSetting.userId, 100);
        expect(answerSetting.intervalStepUpCondition, 3);
        expect(answerSetting.initialInterval, 2);
        expect(answerSetting.dailyGoal, 50);
        expect(answerSetting.choicesCovered, true);
        expect(answerSetting.questionCovered, true);
        expect(answerSetting.strictSolvingMode, false);
        expect(answerSetting.reviewNotificationTimer, 18);
        expect(answerSetting.reviewNotificationTimerSet, true);
        expect(answerSetting.reviewNotificationEnabled, true);
        expect(answerSetting.strictReviewingMode, false);
        expect(answerSetting.seEnabled, true);
        expect(answerSetting.effectEnabled, false);
        expect(answerSetting.speechRate, 75);
        expect(answerSetting.reviewDeleteCondition, 5);
        expect(answerSetting.weaknessCondition, 2);
        expect(answerSetting.overcomingCondition, 90);
        expect(answerSetting.createdAt, DateTime.parse('2024-01-01T00:00:00Z'));
        expect(answerSetting.updatedAt, DateTime.parse('2024-01-02T12:30:00Z'));
      });

      test('should handle edge values correctly', () {
        final json = {
          'id': 999,
          'user_id': 0,
          'interval_step_up_condition': 0,
          'initial_interval': 9,
          'daily_goal': 1,
          'choices_covered': false,
          'question_covered': false,
          'strict_solving_mode': false,
          'review_notification_timer': 1,
          'review_notification_timer_set': false,
          'review_notification_enabled': false,
          'strict_reviewing_mode': false,
          'se_enabled': false,
          'effect_enabled': false,
          'speech_rate': 0,
          'review_delete_condition': 0,
          'weakness_condition': 0,
          'overcoming_condition': 0,
          'created_at': '2023-12-31T23:59:59Z',
          'updated_at': '2024-01-01T00:00:01Z',
        };

        final answerSetting = AnswerSetting.fromJson(json);
        
        expect(answerSetting.id, 999);
        expect(answerSetting.userId, 0);
        expect(answerSetting.intervalStepUpCondition, 0);
        expect(answerSetting.initialInterval, 9);
        expect(answerSetting.dailyGoal, 1);
        expect(answerSetting.reviewNotificationTimer, 1);
        expect(answerSetting.speechRate, 0);
        expect(answerSetting.reviewDeleteCondition, 0);
        expect(answerSetting.weaknessCondition, 0);
        expect(answerSetting.overcomingCondition, 0);
      });

      test('should handle maximum values correctly', () {
        final json = {
          'id': 2147483647,
          'user_id': 2147483647,
          'interval_step_up_condition': 999,
          'initial_interval': 999,
          'daily_goal': 9999,
          'choices_covered': true,
          'question_covered': true,
          'strict_solving_mode': true,
          'review_notification_timer': 23,
          'review_notification_timer_set': true,
          'review_notification_enabled': true,
          'strict_reviewing_mode': true,
          'se_enabled': true,
          'effect_enabled': true,
          'speech_rate': 100,
          'review_delete_condition': 999,
          'weakness_condition': 999,
          'overcoming_condition': 120,
          'created_at': '2024-12-31T23:59:59.999Z',
          'updated_at': '2024-12-31T23:59:59.999Z',
        };

        final answerSetting = AnswerSetting.fromJson(json);
        
        expect(answerSetting.reviewNotificationTimer, 23);
        expect(answerSetting.speechRate, 100);
        expect(answerSetting.overcomingCondition, 120);
        expect(answerSetting.dailyGoal, 9999);
      });
    });

    group('toJson', () {
      test('should convert instance to JSON', () {
        final now = DateTime.parse('2024-01-01T12:00:00Z');
        final answerSetting = AnswerSettingBuilder.build(
          id: 5,
          userId: 200,
          intervalStepUpCondition: 4,
          dailyGoal: 100,
          choicesCovered: true,
          seEnabled: false,
          speechRate: 25,
          createdAt: now,
          updatedAt: now,
        );

        final json = answerSetting.toJson();
        
        expect(json['id'], 5);
        expect(json['user_id'], 200);
        expect(json['interval_step_up_condition'], 4);
        expect(json['daily_goal'], 100);
        expect(json['choices_covered'], true);
        expect(json['se_enabled'], false);
        expect(json['speech_rate'], 25);
        expect(json['created_at'], now);
        expect(json['updated_at'], now);
      });

      test('should include all boolean fields correctly', () {
        final answerSetting = AnswerSettingBuilder.build(
          choicesCovered: true,
          questionCovered: false,
          strictSolvingMode: true,
          reviewNotificationTimerSet: false,
          reviewNotificationEnabled: true,
          strictReviewingMode: false,
          seEnabled: true,
          effectEnabled: false,
        );

        final json = answerSetting.toJson();
        
        expect(json['choices_covered'], true);
        expect(json['question_covered'], false);
        expect(json['strict_solving_mode'], true);
        expect(json['review_notification_timer_set'], false);
        expect(json['review_notification_enabled'], true);
        expect(json['strict_reviewing_mode'], false);
        expect(json['se_enabled'], true);
        expect(json['effect_enabled'], false);
      });
    });

    group('JSON serialization round-trip', () {
      test('should maintain data integrity through fromJson -> toJson', () {
        final originalJson = {
          'id': 10,
          'user_id': 500,
          'interval_step_up_condition': 2,
          'initial_interval': 3,
          'daily_goal': 75,
          'choices_covered': true,
          'question_covered': false,
          'strict_solving_mode': true,
          'review_notification_timer': 15,
          'review_notification_timer_set': true,
          'review_notification_enabled': false,
          'strict_reviewing_mode': true,
          'se_enabled': false,
          'effect_enabled': true,
          'speech_rate': 60,
          'review_delete_condition': 3,
          'weakness_condition': 4,
          'overcoming_condition': 85,
          'created_at': '2024-06-15T10:30:00Z',
          'updated_at': '2024-06-16T14:45:00Z',
        };

        final answerSetting = AnswerSetting.fromJson(originalJson);
        final serializedJson = answerSetting.toJson();
        
        expect(serializedJson['id'], originalJson['id']);
        expect(serializedJson['user_id'], originalJson['user_id']);
        expect(serializedJson['interval_step_up_condition'], originalJson['interval_step_up_condition']);
        expect(serializedJson['daily_goal'], originalJson['daily_goal']);
        expect(serializedJson['choices_covered'], originalJson['choices_covered']);
        expect(serializedJson['se_enabled'], originalJson['se_enabled']);
        expect(serializedJson['speech_rate'], originalJson['speech_rate']);
        expect(serializedJson['created_at'], DateTime.parse(originalJson['created_at'] as String));
        expect(serializedJson['updated_at'], DateTime.parse(originalJson['updated_at'] as String));
      });
    });

    group('edge cases', () {
      test('should handle boundary values for timer settings', () {
        final answerSetting1 = AnswerSettingBuilder.build(reviewNotificationTimer: 1);
        final answerSetting23 = AnswerSettingBuilder.build(reviewNotificationTimer: 23);
        
        expect(answerSetting1.reviewNotificationTimer, 1);
        expect(answerSetting23.reviewNotificationTimer, 23);
      });

      test('should handle boundary values for speech rate', () {
        final answerSetting0 = AnswerSettingBuilder.build(speechRate: 0);
        final answerSetting100 = AnswerSettingBuilder.build(speechRate: 100);
        
        expect(answerSetting0.speechRate, 0);
        expect(answerSetting100.speechRate, 100);
      });

      test('should handle all boolean combinations', () {
        final answerSetting = AnswerSettingBuilder.build(
          choicesCovered: true,
          questionCovered: true,
          strictSolvingMode: true,
          reviewNotificationTimerSet: true,
          reviewNotificationEnabled: true,
          strictReviewingMode: true,
          seEnabled: true,
          effectEnabled: true,
        );
        
        expect(answerSetting.choicesCovered, true);
        expect(answerSetting.questionCovered, true);
        expect(answerSetting.strictSolvingMode, true);
        expect(answerSetting.reviewNotificationTimerSet, true);
        expect(answerSetting.reviewNotificationEnabled, true);
        expect(answerSetting.strictReviewingMode, true);
        expect(answerSetting.seEnabled, true);
        expect(answerSetting.effectEnabled, true);
      });

      test('should handle special condition values', () {
        final answerSetting = AnswerSettingBuilder.build(
          intervalStepUpCondition: 0,
          reviewDeleteCondition: 9,
          weaknessCondition: 0,
          overcomingCondition: 120,
        );
        
        expect(answerSetting.intervalStepUpCondition, 0);
        expect(answerSetting.reviewDeleteCondition, 9);
        expect(answerSetting.weaknessCondition, 0);
        expect(answerSetting.overcomingCondition, 120);
      });

      test('should handle extreme daily goal values', () {
        final answerSetting1 = AnswerSettingBuilder.build(dailyGoal: 1);
        final answerSetting1000 = AnswerSettingBuilder.build(dailyGoal: 1000);
        
        expect(answerSetting1.dailyGoal, 1);
        expect(answerSetting1000.dailyGoal, 1000);
      });
    });
  });
}