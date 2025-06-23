import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:booqs_mobile/utils/answer/answer_feeback.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import '../builders/review_builder.dart';
import '../builders/answer_history_builder.dart';

void main() {
  group('AnswerFeedback', () {
    group('messageForReviewCreated', () {
      test('should return null when review is null', () {
        final answerCreator = AnswerCreator(reviewCreated: true);
        
        final result = AnswerFeedback.messageForReviewCreated(answerCreator);
        
        expect(result, isNull);
      });

      test('should return null when reviewCreated is false', () {
        final review = ReviewBuilder.build(intervalSetting: 1);
        final answerCreator = AnswerCreator(
          review: review,
          reviewCreated: false,
        );
        
        final result = AnswerFeedback.messageForReviewCreated(answerCreator);
        
        expect(result, isNull);
      });

      test('should return null when reviewCreated is null', () {
        final review = ReviewBuilder.build(intervalSetting: 1);
        final answerCreator = AnswerCreator(
          review: review,
          reviewCreated: null,
        );
        
        final result = AnswerFeedback.messageForReviewCreated(answerCreator);
        
        expect(result, isNull);
      });

      test('should return RichText when review exists and reviewCreated is true', () {
        final review = ReviewBuilder.build(intervalSetting: 1);
        final answerCreator = AnswerCreator(
          review: review,
          reviewCreated: true,
        );
        
        final result = AnswerFeedback.messageForReviewCreated(answerCreator);
        
        expect(result, isA<RichText>());
      });
    });

    group('messageForReviewIntervalStepUp', () {
      test('should return null when review is null', () {
        final answerHistory = AnswerHistoryBuilder.build(intervalStepUp: true);
        final answerCreator = AnswerCreator(answerHistory: answerHistory);
        
        final result = AnswerFeedback.messageForReviewIntervalStepUp(answerCreator);
        
        expect(result, isNull);
      });

      test('should return null when answerHistory intervalStepUp is false', () {
        final review = ReviewBuilder.build(intervalSetting: 1);
        final answerHistory = AnswerHistoryBuilder.build(intervalStepUp: false);
        final answerCreator = AnswerCreator(
          review: review,
          answerHistory: answerHistory,
        );
        
        final result = AnswerFeedback.messageForReviewIntervalStepUp(answerCreator);
        
        expect(result, isNull);
      });

      test('should return RichText when conditions are met', () {
        final review = ReviewBuilder.build(intervalSetting: 2);
        final answerHistory = AnswerHistoryBuilder.build(intervalStepUp: true);
        final answerCreator = AnswerCreator(
          review: review,
          answerHistory: answerHistory,
        );
        
        final result = AnswerFeedback.messageForReviewIntervalStepUp(answerCreator);
        
        expect(result, isA<RichText>());
      });
    });

    group('messageForReviewReleased', () {
      test('should return null when reviewReleased is false', () {
        final answerCreator = AnswerCreator(reviewReleased: false);
        
        final result = AnswerFeedback.messageForReviewReleased(answerCreator);
        
        expect(result, isNull);
      });

      test('should return null when reviewReleased is null', () {
        final answerCreator = AnswerCreator(reviewReleased: null);
        
        final result = AnswerFeedback.messageForReviewReleased(answerCreator);
        
        expect(result, isNull);
      });

      test('should return RichText when reviewReleased is true', () {
        final answerCreator = AnswerCreator(reviewReleased: true);
        
        final result = AnswerFeedback.messageForReviewReleased(answerCreator);
        
        expect(result, isA<RichText>());
      });
    });

    group('massageForSameMistakeCount', () {
      test('should return null when sameMistakeCount is null', () {
        final answerCreator = AnswerCreator(sameMistakeCount: null);
        
        final result = AnswerFeedback.massageForSameMistakeCount(answerCreator);
        
        expect(result, isNull);
      });

      test('should return null when sameMistakeCount is 1', () {
        final answerCreator = AnswerCreator(sameMistakeCount: 1);
        
        final result = AnswerFeedback.massageForSameMistakeCount(answerCreator);
        
        expect(result, isNull);
      });

      test('should return null when sameMistakeCount is 0', () {
        final answerCreator = AnswerCreator(sameMistakeCount: 0);
        
        final result = AnswerFeedback.massageForSameMistakeCount(answerCreator);
        
        expect(result, isNull);
      });

      test('should return RichText when sameMistakeCount is greater than 1', () {
        final answerCreator = AnswerCreator(sameMistakeCount: 3);
        
        final result = AnswerFeedback.massageForSameMistakeCount(answerCreator);
        
        expect(result, isA<RichText>());
      });

      test('should return RichText when sameMistakeCount is 2', () {
        final answerCreator = AnswerCreator(sameMistakeCount: 2);
        
        final result = AnswerFeedback.massageForSameMistakeCount(answerCreator);
        
        expect(result, isA<RichText>());
      });
    });

    group('messageForOvercoming', () {
      test('should return null when overcoming is null', () {
        final answerCreator = AnswerCreator(overcoming: null);
        
        final result = AnswerFeedback.messageForOvercoming(answerCreator);
        
        expect(result, isNull);
      });

      test('should return null when overcoming is false', () {
        final answerCreator = AnswerCreator(overcoming: false);
        
        final result = AnswerFeedback.messageForOvercoming(answerCreator);
        
        expect(result, isNull);
      });

      test('should return RichText when overcoming is true', () {
        final answerCreator = AnswerCreator(overcoming: true);
        
        final result = AnswerFeedback.messageForOvercoming(answerCreator);
        
        expect(result, isA<RichText>());
      });
    });

    group('reviewMessage', () {
      test('should create RichText with alarm icon and text', () {
        const text = 'Test message';
        
        final result = AnswerFeedback.reviewMessage(text);
        
        expect(result, isA<RichText>());
        expect(result.text, isA<TextSpan>());
        
        final textSpan = result.text as TextSpan;
        expect(textSpan.children, hasLength(2));
        expect(textSpan.children![0], isA<WidgetSpan>());
        expect(textSpan.children![1], isA<TextSpan>());
        
        final widgetSpan = textSpan.children![0] as WidgetSpan;
        expect(widgetSpan.child, isA<Icon>());
        
        final icon = widgetSpan.child as Icon;
        expect(icon.icon, Icons.alarm);
        expect(icon.color, Colors.white);
        expect(icon.size, 18.0);
        
        final messageSpan = textSpan.children![1] as TextSpan;
        expect(messageSpan.text, ' $text');
        expect(messageSpan.style?.color, Colors.white);
        expect(messageSpan.style?.fontSize, 16);
        expect(messageSpan.style?.fontWeight, FontWeight.bold);
      });
    });

    group('edge cases', () {
      test('should handle negative sameMistakeCount', () {
        final answerCreator = AnswerCreator(sameMistakeCount: -1);
        
        final result = AnswerFeedback.massageForSameMistakeCount(answerCreator);
        
        expect(result, isNull);
      });

      test('should handle large sameMistakeCount', () {
        final answerCreator = AnswerCreator(sameMistakeCount: 999);
        
        final result = AnswerFeedback.massageForSameMistakeCount(answerCreator);
        
        expect(result, isA<RichText>());
      });

      test('should handle empty review message text', () {
        const text = '';
        
        final result = AnswerFeedback.reviewMessage(text);
        
        expect(result, isA<RichText>());
        final textSpan = result.text as TextSpan;
        final messageSpan = textSpan.children![1] as TextSpan;
        expect(messageSpan.text, ' ');
      });
    });
  });
}