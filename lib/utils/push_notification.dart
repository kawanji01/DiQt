import 'dart:io';
import 'package:booqs_mobile/utils/device_info%20_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

    // プッシュ通知に必要なFCMtoken（デバイスごとに発行されるトークン）を取得。
    final String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
              alert: true, badge: true, sound: true);
    } else {
      // Androidでプッシュ通知をフォアグラウンドで受け取るには、送信されたプッシュ通知を捕捉して、local notificationとして表示する必要がある。
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      // local notificationの初期化： 参考：　https://zenn.dev/tomon9086/articles/d2624f6ab37c4c
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ),
      );

      // Create a new AndroidNotificationChannel instance 参考： https://firebase.flutter.dev/docs/messaging/notifications/#foreground-notifications
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.max,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("フォアグラウンドでメッセージを受け取りました");
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  icon: android.smallIcon,
                  // バナーを表示　https://zenn.dev/tomon9086/articles/d2624f6ab37c4c
                  importance: Importance.max,
                  priority: Priority.high,
                  // other properties...
                ),
              ));
        }
      });
    }

    // デバイスの識別IDなどを取得する
    final deviceInfo = DeviceInfoService();
    final String platform = deviceInfo.getPlatform();
    final String deviceIdentifier = await deviceInfo.getIndentifier();
    final String deviceName = await deviceInfo.getName();
    // DB側のユーザー（token）とデバイス（device_identifier）と通知用のトークン（fcm_token）の紐付けを更新する。
    // アプリをアンインストールしたときなどにFCMトークンはリセットされるので、こまめな更新が必要。参照：https://qiita.com/unsoluble_sugar/items/bca933735c9d3a2d60c2
    var url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/update_fcm_token');
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
