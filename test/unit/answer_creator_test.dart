import 'package:flutter_test/flutter_test.dart';
import 'package:booqs_mobile/models/answer_creator.dart';

void main() {
  group('AnswerCreator', () {
    group('constructor', () {
      test('should create instance with default values', () {
        final answerCreator = AnswerCreator();
        
        expect(answerCreator.user, isNull);
        expect(answerCreator.answerHistory, isNull);
        expect(answerCreator.reviewCreated, false);
        expect(answerCreator.reviewReleased, false);
        expect(answerCreator.overcoming, false);
        expect(answerCreator.weaknessClear, false);
        expect(answerCreator.basePoint, 0);
        expect(answerCreator.answerPoint, 0);
        expect(answerCreator.allPoint, 0);
      });

      test('should create instance with provided values', () {
        final answerCreator = AnswerCreator(
          todaysAnswerHistoriesCount: 5,
          solvedQuizzesCount: 10,
          reviewCreated: true,
          overcoming: true,
          basePoint: 100,
          answerPoint: 50,
          allPoint: 150,
        );
        
        expect(answerCreator.todaysAnswerHistoriesCount, 5);
        expect(answerCreator.solvedQuizzesCount, 10);
        expect(answerCreator.reviewCreated, true);
        expect(answerCreator.overcoming, true);
        expect(answerCreator.basePoint, 100);
        expect(answerCreator.answerPoint, 50);
        expect(answerCreator.allPoint, 150);
      });
    });

    group('fromJson', () {
      test('should create instance from JSON with all fields', () {
        final json = {
          'todays_answer_histories_count': 5,
          'todays_correct_answer_histories_count': 3,
          'solved_quizzes_count': 10,
          'unsolved_reviews_count': 2,
          'answer_days_count': 7,
          'continuous_answer_days_count': 3,
          'continuation_all_week_count': 1,
          'continuation_all_month_count': 0,
          'continuation_all_year_count': 0,
          'continuous_goal_achievement_count': 2,
          'continuous_review_completion_count': 1,
          'review_created': true,
          'review_released': false,
          'same_mistake_count': 1,
          'overcoming': true,
          'weakness_clear': false,
          'base_point': 100,
          'answer_point': 50,
          'start_point': 25,
          'lap_clear_point': 20,
          'answer_days_point': 10,
          'continuous_answer_days_point': 15,
          'continuation_all_week_point': 30,
          'continuation_all_month_point': 0,
          'continuation_all_year_point': 0,
          'review_completion_point': 40,
          'continuous_review_completion_point': 25,
          'goal_achievement_point': 35,
          'continuous_goal_achievement_point': 45,
          'all_point': 395,
        };

        final answerCreator = AnswerCreator.fromJson(json);
        
        expect(answerCreator.todaysAnswerHistoriesCount, 5);
        expect(answerCreator.todaysCorrectAnswerHistoriesCount, 3);
        expect(answerCreator.solvedQuizzesCount, 10);
        expect(answerCreator.unsolvedReviewsCount, 2);
        expect(answerCreator.answerDaysCount, 7);
        expect(answerCreator.continuousAnswerDaysCount, 3);
        expect(answerCreator.reviewCreated, true);
        expect(answerCreator.reviewReleased, false);
        expect(answerCreator.overcoming, true);
        expect(answerCreator.weaknessClear, false);
        expect(answerCreator.basePoint, 100);
        expect(answerCreator.allPoint, 395);
      });

      test('should handle null values in JSON', () {
        final json = {
          'todays_answer_histories_count': null,
          'review_created': null,
          'base_point': null,
          'all_point': null,
        };

        expect(() => AnswerCreator.fromJson(json), throwsA(isA<TypeError>()));
      });

      test('should handle empty JSON', () {
        final json = <String, dynamic>{};

        expect(() => AnswerCreator.fromJson(json), throwsA(isA<TypeError>()));
      });
    });

    group('toJson', () {
      test('should convert instance to JSON', () {
        final answerCreator = AnswerCreator(
          todaysAnswerHistoriesCount: 5,
          solvedQuizzesCount: 10,
          reviewCreated: true,
          overcoming: false,
          basePoint: 100,
          answerPoint: 50,
          allPoint: 150,
        );

        final json = answerCreator.toJson();
        
        expect(json['todays_answer_histories_count'], 5);
        expect(json['solved_quizzes_count'], 10);
        expect(json['review_created'], true);
        expect(json['overcoming'], false);
        expect(json['base_point'], 100);
        expect(json['answer_point'], 50);
        expect(json['all_point'], 150);
      });

      test('should handle null values in toJson', () {
        final answerCreator = AnswerCreator(
          todaysAnswerHistoriesCount: null,
          reviewCreated: null,
          basePoint: 0,
        );

        final json = answerCreator.toJson();
        
        expect(json['todays_answer_histories_count'], isNull);
        expect(json['review_created'], isNull);
        expect(json['base_point'], 0);
      });

      test('should include all point fields', () {
        final answerCreator = AnswerCreator(
          basePoint: 10,
          answerPoint: 20,
          startPoint: 5,
          lapClearPoint: 15,
          answerDaysPoint: 25,
          continuousAnswerDaysPoint: 30,
          allPoint: 105,
        );

        final json = answerCreator.toJson();
        
        expect(json['base_point'], 10);
        expect(json['answer_point'], 20);
        expect(json['start_point'], 5);
        expect(json['lap_clear_point'], 15);
        expect(json['answer_days_point'], 25);
        expect(json['continuous_answer_days_point'], 30);
        expect(json['all_point'], 105);
      });
    });

    group('JSON serialization round-trip', () {
      test('should maintain data integrity through fromJson -> toJson', () {
        final originalJson = {
          'todays_answer_histories_count': 5,
          'solved_quizzes_count': 10,
          'review_created': true,
          'overcoming': false,
          'base_point': 100,
          'answer_point': 50,
          'start_point': 25,
          'lap_clear_point': 20,
          'answer_days_point': 10,
          'continuous_answer_days_point': 15,
          'continuation_all_week_point': 30,
          'continuation_all_month_point': 0,
          'continuation_all_year_point': 0,
          'review_completion_point': 40,
          'continuous_review_completion_point': 25,
          'goal_achievement_point': 35,
          'continuous_goal_achievement_point': 45,
          'all_point': 150,
        };

        final answerCreator = AnswerCreator.fromJson(originalJson);
        final serializedJson = answerCreator.toJson();
        
        expect(serializedJson['todays_answer_histories_count'], 
               originalJson['todays_answer_histories_count']);
        expect(serializedJson['solved_quizzes_count'], 
               originalJson['solved_quizzes_count']);
        expect(serializedJson['review_created'], 
               originalJson['review_created']);
        expect(serializedJson['overcoming'], 
               originalJson['overcoming']);
        expect(serializedJson['base_point'], 
               originalJson['base_point']);
        expect(serializedJson['answer_point'], 
               originalJson['answer_point']);
        expect(serializedJson['all_point'], 
               originalJson['all_point']);
      });
    });

    group('edge cases', () {
      test('should handle extreme values', () {
        final answerCreator = AnswerCreator(
          todaysAnswerHistoriesCount: 999999,
          basePoint: -100,
          allPoint: 0,
        );

        final json = answerCreator.toJson();
        final recreated = AnswerCreator.fromJson(json);
        
        expect(recreated.todaysAnswerHistoriesCount, 999999);
        expect(recreated.basePoint, -100);
        expect(recreated.allPoint, 0);
      });

      test('should handle boolean edge cases', () {
        final answerCreator = AnswerCreator(
          reviewCreated: true,
          reviewReleased: false,
          overcoming: true,
          weaknessClear: false,
        );

        final json = answerCreator.toJson();
        final recreated = AnswerCreator.fromJson(json);
        
        expect(recreated.reviewCreated, true);
        expect(recreated.reviewReleased, false);
        expect(recreated.overcoming, true);
        expect(recreated.weaknessClear, false);
      });
    });
  });
}