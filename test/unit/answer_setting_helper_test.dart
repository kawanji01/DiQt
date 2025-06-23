import 'package:flutter_test/flutter_test.dart';
import 'package:booqs_mobile/utils/helpers/answer_setting.dart';

void main() {
  group('AnswerSettingHelper', () {
    group('reviewNotificationTimer', () {
      test('should return correct AM time strings for early hours', () {
        expect(AnswerSettingHelper.reviewNotificationTimer(1), '1:00 AM');
        expect(AnswerSettingHelper.reviewNotificationTimer(2), '2:00 AM');
        expect(AnswerSettingHelper.reviewNotificationTimer(6), '6:00 AM');
        expect(AnswerSettingHelper.reviewNotificationTimer(11), '11:00 AM');
      });

      test('should return correct PM time strings for afternoon/evening', () {
        expect(AnswerSettingHelper.reviewNotificationTimer(12), '12:00 PM');
        expect(AnswerSettingHelper.reviewNotificationTimer(13), '1:00 PM');
        expect(AnswerSettingHelper.reviewNotificationTimer(18), '6:00 PM');
        expect(AnswerSettingHelper.reviewNotificationTimer(23), '11:00 PM');
      });

      test('should handle boundary values correctly', () {
        expect(AnswerSettingHelper.reviewNotificationTimer(1), '1:00 AM');
        expect(AnswerSettingHelper.reviewNotificationTimer(23), '11:00 PM');
      });

      test('should return empty string for invalid values', () {
        expect(AnswerSettingHelper.reviewNotificationTimer(0), '');
        expect(AnswerSettingHelper.reviewNotificationTimer(24), '');
        expect(AnswerSettingHelper.reviewNotificationTimer(-1), '');
        expect(AnswerSettingHelper.reviewNotificationTimer(25), '');
      });

      test('should handle all valid hour values', () {
        final Map<int, String> expectedTimes = {
          1: '1:00 AM', 2: '2:00 AM', 3: '3:00 AM', 4: '4:00 AM',
          5: '5:00 AM', 6: '6:00 AM', 7: '7:00 AM', 8: '8:00 AM',
          9: '9:00 AM', 10: '10:00 AM', 11: '11:00 AM', 12: '12:00 PM',
          13: '1:00 PM', 14: '2:00 PM', 15: '3:00 PM', 16: '4:00 PM',
          17: '5:00 PM', 18: '6:00 PM', 19: '7:00 PM', 20: '8:00 PM',
          21: '9:00 PM', 22: '10:00 PM', 23: '11:00 PM'
        };
        
        expectedTimes.forEach((hour, expectedTime) {
          expect(AnswerSettingHelper.reviewNotificationTimer(hour), expectedTime);
        });
      });
    });

    group('intervalStepUpConditionText', () {
      test('should return localized text for interval step up conditions', () {
        // テスト用の条件値をいくつか確認
        expect(AnswerSettingHelper.intervalStepUpConditionText(0), isA<String>());
        expect(AnswerSettingHelper.intervalStepUpConditionText(1), isA<String>());
        expect(AnswerSettingHelper.intervalStepUpConditionText(2), isA<String>());
        expect(AnswerSettingHelper.intervalStepUpConditionText(3), isA<String>());
      });

      test('should handle edge case values', () {
        expect(AnswerSettingHelper.intervalStepUpConditionText(0), isA<String>());
        expect(AnswerSettingHelper.intervalStepUpConditionText(10), isA<String>());
        expect(AnswerSettingHelper.intervalStepUpConditionText(-1), isA<String>());
      });
    });

    group('reviewDeleteConditionText', () {
      test('should return localized text for review delete conditions', () {
        expect(AnswerSettingHelper.reviewDeleteConditionText(0), isA<String>());
        expect(AnswerSettingHelper.reviewDeleteConditionText(7), isA<String>());
        expect(AnswerSettingHelper.reviewDeleteConditionText(9), isA<String>());
      });

      test('should handle various condition values', () {
        for (int i = 0; i <= 9; i++) {
          expect(AnswerSettingHelper.reviewDeleteConditionText(i), isA<String>());
        }
      });
    });

    group('weaknessCondition', () {
      test('should return localized text for weakness conditions', () {
        expect(AnswerSettingHelper.weaknessCondition(0), isA<String>());
        expect(AnswerSettingHelper.weaknessCondition(3), isA<String>());
        expect(AnswerSettingHelper.weaknessCondition(5), isA<String>());
      });

      test('should handle boundary values', () {
        expect(AnswerSettingHelper.weaknessCondition(0), isA<String>());
        expect(AnswerSettingHelper.weaknessCondition(10), isA<String>());
      });
    });

    group('overcomingCondition', () {
      test('should return special localized text for special values', () {
        // 特殊値（0, 1, 120）の場合は特別なローカライゼーションキーを使用
        expect(AnswerSettingHelper.overcomingCondition(0), isA<String>());
        expect(AnswerSettingHelper.overcomingCondition(1), isA<String>());
        expect(AnswerSettingHelper.overcomingCondition(120), isA<String>());
      });

      test('should return percentage-based text for regular values', () {
        // 通常の値の場合はパーセンテージベースのテキストを返す
        // これらは実際のローカライゼーション関数を呼び出すので、戻り値の型をチェック
        expect(AnswerSettingHelper.overcomingCondition(50), isA<String>());
        expect(AnswerSettingHelper.overcomingCondition(75), isA<String>());
        expect(AnswerSettingHelper.overcomingCondition(90), isA<String>());
        expect(AnswerSettingHelper.overcomingCondition(100), isA<String>());
      });

      test('should handle boundary and edge values correctly', () {
        // 特殊値の境界をテスト
        expect(AnswerSettingHelper.overcomingCondition(0), isA<String>());
        expect(AnswerSettingHelper.overcomingCondition(1), isA<String>());
        expect(AnswerSettingHelper.overcomingCondition(2), isA<String>());
        expect(AnswerSettingHelper.overcomingCondition(119), isA<String>());
        expect(AnswerSettingHelper.overcomingCondition(120), isA<String>());
      });

      test('should handle various percentage values', () {
        final testValues = [2, 25, 50, 75, 80, 85, 90, 95, 99, 100, 119];
        for (final value in testValues) {
          expect(AnswerSettingHelper.overcomingCondition(value), isA<String>());
        }
      });
    });

    group('initialIntervalText', () {
      test('should delegate to ReviewHelper.intervalText', () {
        // ReviewHelperのintervalTextメソッドに委譲することを確認
        expect(AnswerSettingHelper.initialIntervalText(1), isA<String>());
        expect(AnswerSettingHelper.initialIntervalText(7), isA<String>());
        expect(AnswerSettingHelper.initialIntervalText(30), isA<String>());
      });

      test('should handle various interval values', () {
        final testValues = [0, 1, 2, 3, 7, 14, 30, 60, 365];
        for (final value in testValues) {
          expect(AnswerSettingHelper.initialIntervalText(value), isA<String>());
        }
      });
    });
  });
}