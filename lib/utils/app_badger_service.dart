import 'dart:convert';

import 'package:booqs_mobile/utils/crashlytics_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badge_control/flutter_app_badge_control.dart';
import 'package:booqs_mobile/utils/sentry_service.dart';

class AppBadgerService {
  //// 復習のバッジつける処理 ////
  static Future<void> syncReviewBadgeOnPushNotification() async {
    if (await FlutterAppBadgeControl.isAppBadgeSupported() == false) {
      return;
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('FirebaseMessaging.onMessage.listen: ${message.notification?.title ?? ''}');

      if (message.data.containsKey('category') == false) {
        return;
      }
      if (message.data['category'] != 'review') {
        return;
      }

      try {
        final Map<String, dynamic> contentsJson =
            jsonDecode(message.data['contents']);
        final int reviewsCount = contentsJson['reviews_count'] ?? 0;
        updateReviewBadge(reviewsCount); //バッジの数を指定
      } catch (e, str) {
        CrashlyticsService.recordError(e, str);
        SentryService.captureException(e, stackTrace: str);
      }
    });
    return;
  }

  // バッジを更新する
  static Future<void> updateReviewBadge(int unsolvedReviewsCount) async {
    try {
      if (await FlutterAppBadgeControl.isAppBadgeSupported() == false) {
        return;
      }

      if (unsolvedReviewsCount == 0) {
        FlutterAppBadgeControl.removeBadge(); //バッジを削除
      } else {
        FlutterAppBadgeControl.updateBadgeCount(unsolvedReviewsCount);
      }
    } catch (e, str) {
      CrashlyticsService.recordError(e, str);
      await SentryService.captureException(e, stackTrace: str);
    }
  }
}
