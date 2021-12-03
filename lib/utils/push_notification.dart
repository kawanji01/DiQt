import 'dart:io';

import 'package:booqs_mobile/utils/device_indentifier.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PushNotification {
  static Future<bool> initialize(BuildContext context) async {
    // ユーザー取得用のトークンを取得
    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');
    // トークンがない == ログインしていない 場合は終了
    if (token == null) return false;

    // Firebaseを初期化
    await Firebase.initializeApp();
    // 通知の許可を求める。
    //await FirebaseMessaging.instance.requestPermission(
    //  announcement: true,
    //  carPlay: true,
    //  criticalAlert: true,
    //  sound: true,
    //);
    // 通知をフォアグラウンドで受け取れるようにする。参照： https://zenn.dev/rafekun/articles/ef8a22f9fe90bd
    //await FirebaseMessaging.instance
    //    .setForegroundNotificationPresentationOptions(
    //  alert: true, // Required to display a heads up notification
    //  badge: true,
    //  sound: true,
    //);
    await FirebaseMessaging.instance.requestPermission();
    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
              alert: true, badge: true, sound: true);
    }
    // プッシュ通知に必要なFCMtoken（デバイスごとに発行されるトークン）を取得。
    final String? fcmToken = await FirebaseMessaging.instance.getToken();

    // デバイスの識別IDなどを取得する
    String deviceIdentifier = "unknown";
    String platform = "unknown";
    String deviceName = "unknown";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.androidId!;
      deviceName = androidInfo.model!;
      platform = 'android';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor!;
      deviceName = iosInfo.utsname.machine!;
      platform = 'ios';
    }
    // DB側のユーザー（token）とデバイス（device_identifier）と通知用のトークン（fcm_token）の紐付けを更新する。
    // アプリをアンインストールしたときなどにFCMトークンはリセットされるので、こまめな更新が必要。参照：https://qiita.com/unsoluble_sugar/items/bca933735c9d3a2d60c2
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/users/update_fcm_token');
    await http.post(url, body: {
      'token': token,
      'fcm_token': '$fcmToken',
      'device_identifier': deviceIdentifier,
      'device_name': deviceName,
      'platform': platform,
    });

    //if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //  print('User granted permission');
    // } else if (settings.authorizationStatus ==
    //     AuthorizationStatus.provisional) {
    //   print('User granted provisional permission');
    // } else {
    //   print('User declined or has not accepted permission');
    //}
    return true;
  }
}
