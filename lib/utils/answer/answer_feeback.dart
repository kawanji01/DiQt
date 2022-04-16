import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/answer_history.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/services/review_helper.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';

class AnswerFeedback {
  static Future<void> call(
      BuildContext context, AnswerCreator answerCreator) async {
    List<Widget> messageList = [];
    Widget? reviewCreated = messageForReviewCreated(answerCreator);
    if (reviewCreated != null) messageList.add(reviewCreated);

    Widget? reviewIntervalStepUp =
        messageForReviewIntervalStepUp(answerCreator);
    if (reviewIntervalStepUp != null) messageList.add(reviewIntervalStepUp);

    Widget? reviewReleased = messageForReviewReleased(answerCreator);
    if (reviewReleased != null) messageList.add(reviewReleased);

    Widget? sameMistakeCount = massageForSameMistakeCount(answerCreator);
    if (sameMistakeCount != null) messageList.add(sameMistakeCount);

    if (messageList.isEmpty) return;

    Widget child = Column(
      mainAxisSize: MainAxisSize.min,
      children: messageList,
    );
    Toasts.showBlack(context, child);

    /*  // 復習の新規作成
    await AnswerFeedback.reviewCreated(context, answerCreator);
    // 復習の間隔伸長
    await AnswerFeedback.reviewIntervalStepUp(context, answerCreator);
    // 復習の解除
    await AnswerFeedback.reviewReleased(context, answerCreator);
    // 同じ間違い
    await AnswerFeedback.sameMistakeCount(context, answerCreator); */
  }

  // 復習が新規で設定された通知
  static Future<void> reviewCreated(
      BuildContext context, AnswerCreator answerCreator) async {
    final Review? review = answerCreator.review;
    if (review != null && answerCreator.reviewCreated == true) {
      final String interval =
          ReviewHelperService.intervalSetting(review.intervalSetting);

      Toasts.reviewSetting(context, interval);
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  static Widget? messageForReviewCreated(AnswerCreator answerCreator) {
    final Review? review = answerCreator.review;
    if (review != null && answerCreator.reviewCreated == true) {
      final String interval =
          ReviewHelperService.intervalSetting(review.intervalSetting);
      return reviewMessage(interval);
    }
  }

  static RichText reviewMessage(String text) {
    return RichText(
        text: TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.alarm,
          color: Colors.white,
          size: 18.0,
        ),
      ),
      TextSpan(
          text: ' $text',
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))
    ]));
  }

  // 復習の間隔が伸長した通知
  static Future<void> reviewIntervalStepUp(
      BuildContext context, AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final Review? review = answerCreator.review;
    if (review != null && answerHistory!.intervalStepUp) {
      final String interval =
          ReviewHelperService.intervalSetting(review.intervalSetting);
      Toasts.reviewSetting(context, '繰り上がりで$interval');
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  static Widget? messageForReviewIntervalStepUp(AnswerCreator answerCreator) {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final Review? review = answerCreator.review;
    if (review != null && answerHistory!.intervalStepUp) {
      final String interval =
          ReviewHelperService.intervalSetting(review.intervalSetting);
      final String text = '繰り上がりで$interval';
      return reviewMessage(text);
    }
  }

  // 復習設定が解除された通知
  static Future<void> reviewReleased(
      BuildContext context, AnswerCreator answerCreator) async {
    if (answerCreator.reviewReleased == true) {
      Toasts.reviewSetting(context, '復習が解除されました');
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  static Widget? messageForReviewReleased(AnswerCreator answerCreator) {
    if (answerCreator.reviewReleased == true) {
      String text = '復習が解除されました';
      return reviewMessage(text);
    }
  }

  // 同じ間違いの通知
  static Future<void> sameMistakeCount(
      BuildContext context, AnswerCreator answerCreator) async {
    int? sameMistakeCount = answerCreator.sameMistakeCount;
    if (sameMistakeCount != null && sameMistakeCount > 1) {
      final richText = RichText(
          text: TextSpan(children: [
        const WidgetSpan(
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 18.0,
          ),
        ),
        TextSpan(
            text: ' この間違いは$sameMistakeCount回目です',
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))
      ]));
      Toasts.showBlack(context, richText);
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  static Widget? massageForSameMistakeCount(AnswerCreator answerCreator) {
    int? sameMistakeCount = answerCreator.sameMistakeCount;
    if (sameMistakeCount != null && sameMistakeCount > 1) {
      return RichText(
          text: TextSpan(children: [
        const WidgetSpan(
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 18.0,
          ),
        ),
        TextSpan(
            text: ' この間違いは$sameMistakeCount回目です',
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))
      ]));
    }
  }
}
