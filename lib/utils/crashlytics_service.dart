import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsService {
  static reccordError(dynamic exception, StackTrace? stack) {
    // 本番環境以外では送信しない。
    if (const String.fromEnvironment("flavor") == 'prod') {
      FirebaseCrashlytics.instance.recordError(exception, stack);
    }
  }
}
