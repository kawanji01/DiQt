import 'dart:io';
import 'package:booqs_mobile/data/local/secrets.dart';
import 'package:booqs_mobile/utils/crashlytics_service.dart';
import 'package:booqs_mobile/utils/device_info_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/env_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationHandler {
  //// 初期化 START ////
  static Future<bool> initialize(BuildContext context) async {
    if (EnvHandler.isDesktop()) return false;

    final String? token = await LocalSecrets.authToken();
    // トークンがない == ログインしていない 場合は終了
    if (token == null) return false;
    // ダイアログで通知の許可をもらう
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // OSごとの設定
    if (Platform.isIOS) {
      await _setIOSForegroundNotification();
    } else {
      await _setAndroidForegroundNotification();
    }

    // ユーザーごとにプッシュ通知を送れるようにDBに保存する
    final bool result = await _saveFCMTokenOnDB();
    return result;
  }
  //// 初期化 END ////

  // iOSの設定 ref: https://firebase.flutter.dev/docs/messaging/notifications/#foreground-notifications
  static Future<void> _setIOSForegroundNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  //// Androidの設定 START ref: https://firebase.flutter.dev/docs/messaging/notifications/#foreground-notifications
  // AndroidはlocalNotificationで通知しないとなので長い。
  static Future<void> _setAndroidForegroundNotification() async {
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

  // 通知タップ時の画面遷移先の設定
  // mainで実行される。
  static void setTransitonWhenNotificationTapped(BuildContext context) {
    if (EnvHandler.isDesktop()) return;

    // アプリが初めて起動されたときの処理
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      //print('message: $message');
      //final date = message?.data;
      //print('date: $date');
      //final String caterogy = message?.data['category'];
      //print('category: $caterogy');

      final String route = message?.data['route'] ?? '/';
      //print('route: $route');
      if (message != null) {
        Navigator.of(context).pushNamed(route);
      }
    });
    // バックグラウンドにある状態で通知がタップされたときの処理
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //print('message: $message');
      //final date = message.data;
      //print('date: $date');
      //final String caterogy = message.data['category'];
      //print('category: $caterogy');

      final String route = message.data['route'] ?? '/';
      // print('route: $route');
      Navigator.of(context).pushNamed(route);
    });
  }
  //// Android設定 END ////

  //// サーバーからプッシュ通知を送れるように、DBのユーザーのDeviceSettingにFCMを保存する START ////
  static Future<bool> _saveFCMTokenOnDB() async {
    try {
      // プッシュ通知に必要なFCMtoken（デバイスごとに発行されるトークン）を取得。
      final String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) {
        return false;
      }
      // デバイスの識別IDなどを取得する
      final deviceInfo = DeviceInfoService();
      final String platform = deviceInfo.getPlatform();
      final String deviceIdentifier = await deviceInfo.getIndentifier();
      final String deviceName = await deviceInfo.getName();
      // DB側のユーザー（token）とデバイス（device_identifier）と通知用のトークン（fcm_token）の紐付けを更新する。
      // アプリをアンインストールしたときなどにFCMトークンはリセットされるので、こまめな更新が必要。ref： https://qiita.com/unsoluble_sugar/items/bca933735c9d3a2d60c2
      final url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/users/update_fcm_token');
      await HttpService.post(url, {
        'fcm_token': fcmToken,
        'device_identifier': deviceIdentifier,
        'device_name': deviceName,
        'platform': platform,
      });
      return true;
    } catch (e, s) {
      CrashlyticsService.recordError(e, s);
      return false;
    }
  }
  //// サーバーからプッシュ通知を送れるように、DBのユーザーのDeviceSettingにFCMを保存する END ////
  ///
  ///
}
