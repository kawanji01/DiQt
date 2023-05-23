import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

class AppBadgerService {
  //// 復習のバッジつける処理 ////
  static Future<void> syncReviewBadgeOnPushNotification() async {
    print('initReviewBadges');

    if (await FlutterAppBadger.isAppBadgeSupported() == false) {
      print('isAppBadgeSupported: false');
      return;
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          'FirebaseMessaging.onMessage.listen: ${message.notification?.title ?? ''}');

      if (message.data.containsKey('category') == false) {
        print('category: blank');
        return;
      }
      if (message.data['category'] != 'review') {
        print('category: false');
        return;
      }

      try {
        final Map<String, dynamic> contentsJson =
            jsonDecode(message.data['contents']);
        final int reviewsCount = contentsJson['reviews_count'] ?? 0;
        // print('reviewsCount: $reviewsCount');
        FlutterAppBadger.updateBadgeCount(reviewsCount); //バッジの数を指定
        print(' FlutterAppBadger.updateBadgeCount: completed');
      } catch (e) {
        print('syncReviewBadgeOnPushNotification: $e');
      }
    });
    return;
  }

  // バッジを更新する
  static Future<void> updateReviewBadge(int unsolvedReviewsCount) async {
    if (await FlutterAppBadger.isAppBadgeSupported() == false) {
      print('isAppBadgeSupported: false');
      return;
    }

    if (unsolvedReviewsCount == 0) {
      FlutterAppBadger.removeBadge(); //バッジを削除
    } else {
      FlutterAppBadger.updateBadgeCount(unsolvedReviewsCount);
    }
  }
}
