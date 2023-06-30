import 'package:booqs_mobile/utils/env_handler.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService {
  static initialize() {
    // デスクトップでは実行しない
    if (EnvHandler.isDesktop()) return;
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  static recordError(dynamic exception, StackTrace? stack) {
    // デスクトップでは実行しない
    if (EnvHandler.isDesktop()) return;
    // 本番環境以外では送信しない。
    if (EnvHandler.isProd()) {
      FirebaseCrashlytics.instance.recordError(exception, stack);
    } else {
      // 開発環境などではコンソールログに出力する。
      if (kDebugMode) {
        print('$exception');
      }
    }
  }
}
