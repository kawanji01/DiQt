import 'package:booqs_mobile/utils/env_handler.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsService {
  static recordError(dynamic exception, StackTrace? stack) {
    // 本番環境以外では送信しない。
    if (EnvHandler.isProd()) {
      FirebaseCrashlytics.instance.recordError(exception, stack);
    } else {
      // 開発環境などではコンソールログに出力する。
      print('$exception');
    }
  }
}
