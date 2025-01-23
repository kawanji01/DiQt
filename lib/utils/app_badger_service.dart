import 'dart:convert';

import 'package:booqs_mobile/utils/crashlytics_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AppBadgerService {
  //// 復習のバッジつける処理 ////
  static Future<void> syncReviewBadgeOnPushNotification() async {
    // if (await FlutterAppBadger.isAppBadgeSupported() == false) {
    //  return;
    // }
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
        // TODO: ここでバッジの数を指定する。flutter_app_badger がdiscontinuedなので、代替案を探す。
        final int reviewsCount = contentsJson['reviews_count'] ?? 0;
        // FlutterAppBadger.updateBadgeCount(reviewsCount); //バッジの数を指定
      } catch (e, str) {
        CrashlyticsService.recordError(e, str);
      }
    });
    return;
  }

  // バッジを更新する
  static Future<void> updateReviewBadge(int unsolvedReviewsCount) async {
    try {
      // if (await FlutterAppBadger.isAppBadgeSupported() == false) {
      //  return;
      // }

      // if (unsolvedReviewsCount == 0) {
      //  FlutterAppBadger.removeBadge(); //バッジを削除
      // } else {
      //  FlutterAppBadger.updateBadgeCount(unsolvedReviewsCount);
      //}
    } catch (e, str) {
      CrashlyticsService.recordError(e, str);
    }
  }
}
