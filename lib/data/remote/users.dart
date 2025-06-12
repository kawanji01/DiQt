import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/crashlytics_service.dart';
import 'package:booqs_mobile/utils/device_info_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/entitlement_info_service.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';
import 'package:purchases_flutter/object_wrappers.dart';

class RemoteUsers {
  // 安全なJSONデコード関数
  static Map? _safeJsonDecode(String body, String methodName) {
    if (body.isEmpty) {
      return {};
    }
    
    try {
      return json.decode(body);
    } on FormatException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(
        'JSON parse error in $methodName. Response body: $body', 
        s
      );
      return {};
    }
  }

  // 現在のログインユーザーの取得　　　users/current
  static Future<Map?> current() async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/users/current');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      CrashlyticsService.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      CrashlyticsService.recordError(e, s);
      return null;
    } catch (e, s) {
      CrashlyticsService.recordError(e, s);
      return null;
    }
  }

  // 解答中の問題集の取得
  static Future<Map> unreceivedAchievementMaps() async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/users/unreceived_achievement_maps');
      final Response res = await HttpService.get(url);

      if (ErrorHandler.isErrorResponse(res)) return ErrorHandler.errorMap(res);
      // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  // ユーザーの検索
  static Future<Map?> index(String keyword, int pageKey, int pageSize) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/users?keyword=$keyword&page=$pageKey&size=$pageSize');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  // 特定のユーザー情報を取得
  static Future<Map?> show(String publicUid) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/users/$publicUid');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  // ユーザー情報の更新
  static Future<Map> update(
      {required Map<String, dynamic> params, required String locale}) async {
    try {
      final String publicUid = params['public_uid'];

      final Map<String, dynamic> body = {'user': params};
      final url = Uri.parse(
          '${DiQtURL.root(locale: locale)}/api/v1/mobile/users/$publicUid');

      final Response res = await HttpService.patch(
        url,
        body,
      );
      if (ErrorHandler.isErrorResponse(res)) return ErrorHandler.errorMap(res);
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  // 解答中の問題集の取得
  static Future<Map> resumeDrillLaps(
      {required String type,
      required int pageKey,
      required int pageSize}) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/users/resume_drill_laps?type=$type&page=$pageKey&size=$pageSize');
      final Response res = await HttpService.get(url);

      if (ErrorHandler.isErrorResponse(res)) return ErrorHandler.errorMap(res);
      // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  // Drills
  static Future<Map> drills(
      {required String userUid,
      required int pageKey,
      required int pageSize}) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/users/$userUid/drills?page=$pageKey&size=$pageSize');
      final Response res = await HttpService.get(url);
      if (ErrorHandler.isErrorResponse(res)) return ErrorHandler.errorMap(res);
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  // 実績メダルの取得
  static Future<Map?> achievements(String publicUid) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/users/$publicUid/achievements');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) {
        return null;
      }
      // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  // 参加中の教室
  static Future<Map> schools(String publicUid) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/users/$publicUid/schools');
      final Response res = await HttpService.get(url);

      if (ErrorHandler.isErrorResponse(res)) return ErrorHandler.errorMap(res);
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  // 退会
  static Future<Map?> withdrawal(String publidUid) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/users/$publidUid');

      final Response res = await HttpService.delete(url, null);

      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  // アプリのレビュー画面を表示したことを伝える
  static Future<Map?> favorApp() async {
    try {
      final deviceInfo = DeviceInfoService();
      final String platform = deviceInfo.getPlatform();
      final String deviceName = await deviceInfo.getName();

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/users/favor_app');
      final Map<String, dynamic> body = {
        'device_info': '$platform / $deviceName'
      };

      final Response res = await HttpService.post(url, body);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  // 解約理由を送信する
  static Future<Map?> sendCancellationReport(
      EntitlementInfo entitlementInfo, String reason) async {
    try {
      final String productIdentifier = entitlementInfo.productIdentifier;
      final String device = EntitlementInfoService.device(entitlementInfo);
      final bool inTrial = EntitlementInfoService.inTrial(entitlementInfo);

      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/users/send_cancellation_report');
      final Map<String, dynamic> body = {
        'product_identifier': productIdentifier,
        'device': device,
        'in_trial': '$inTrial',
        'reason': reason
      };
      final Response res = await HttpService.post(url, body);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  // カレンダーのイベントを取得する
  static Future<Map?> loadCalendarEvents(
      String publicUid, DateTime firstDate, DateTime lastDate) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/users/$publicUid/calendar?start=$firstDate&end=$lastDate');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  // revenueCatの購入情報を取得する
  static Future<Map?> getOrCreateSubscriber() async {
    String? platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/users/get_or_create_subscriber');
      final Response res = await HttpService.post(url, {'platform': platform});
      if (res.statusCode != 200) return null;
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  // DB側の解約処理
  // クライアント側に解約APIは用意されていないので、サーバー側（Ruby）の解約APIを叩き、解約をDBと同期する。
  static Future<Map?> deleteSubscriber(String reason) async {
    try {
      final url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/users/delete_subscriber');
      final res = await HttpService.post(url, {'reason': reason});
      if (res.statusCode != 200) return null;
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  // ユーザーをプレミアム会員化する
  static Future<Map?> enablePremium() async {
    try {
      final url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/users/enable_premium');
      final res = await HttpService.post(url, null);
      return _safeJsonDecode(res.body, 'enablePremium');
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  // ユーザーを一般会員に戻す
  static Future<Map?> disablePremium() async {
    try {
      final url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/users/disable_premium');
      final res = await HttpService.post(url, null);
      return _safeJsonDecode(res.body, 'disablePremium');
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  // アイコンをアップデート
  static Future<Map> uploadIcon({required File image}) async {
    try {
      final url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/users/upload_icon');
      final res = await HttpService.multipartRequest(
          url: url, image: image, body: null);
      return {'status': res.statusCode, 'message': 'Upload Icon'};
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  // アクティベーションメールを再送する
  static Future<Map> resendActivationEmail({required String email}) async {
    try {
      final url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/users/resend_activation_email');
      final Map<String, dynamic> body = {'email': email};
      final res = await HttpService.post(url, body);
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  static Future<Map> updateEmail({required String email}) async {
    try {
      final url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/users/update_email');
      final Map<String, dynamic> body = {
        'user': {'new_email': email}
      };
      final res = await HttpService.patch(url, body);
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  static Future<Map> updateLangs({
    required int langNumber,
    required int learningLangNumber,
  }) async {
    try {
      final url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/users/update_langs');
      final Map<String, dynamic> body = {
        'user': {
          'lang_number': langNumber,
          'learning_lang_number': learningLangNumber,
        }
      };
      final res = await HttpService.patch(url, body);
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  static Future<Map> setReviewTimer(
      {required String timeZoneName,
      required int reviewNotificationTimer,
      required bool reviewNotificationEnabled}) async {
    try {
      final url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/users/set_review_timer');
      final Map<String, dynamic> body = {
        'time_zone_name': timeZoneName,
        'review_notification_timer': reviewNotificationTimer,
        'review_notification_enabled': reviewNotificationEnabled
      };
      final res = await HttpService.patch(url, body);
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  // 復習のオンボーディングモーダルを表示したことを伝える
  static Future<Map> updateReviewOnboardingShown() async {
    try {
      final url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/users/update_review_onboarding_shown');
      final res = await HttpService.patch(url, {});
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }
}
