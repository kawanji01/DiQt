import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/models/relationship.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';

class RemoteRelationships {
  // フォロー。フォローする相手のUIDを引数にする
  static Future<Map?> create(String publicUid) async {
    try {
      final Map<String, dynamic> body = {'public_uid': publicUid};

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/relationships');
      final Response res = await HttpService.post(
        url,
        body,
      );
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
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

  static Future<Map?> destroy(Relationship relationship) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/relationships/${relationship.id}');

      final Response res = await HttpService.delete(url, null);
      if (res.statusCode != 200) return null;

      Map resMap = json.decode(res.body);
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
}
