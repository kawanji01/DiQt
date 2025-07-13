import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryService {
  static String? _sentryDsn;

  /// Sentryの初期化
  static Future<void> initialize() async {
    // dart-defineから取得（本番用）、なければ.envから取得（開発用）
    _sentryDsn = const String.fromEnvironment('sentryDsn', defaultValue: '') != ''
        ? const String.fromEnvironment('sentryDsn')
        : dotenv.env['SENTRY_DSN'];
  }

  /// Sentryの設定
  static void configure(SentryFlutterOptions options) {
    options.dsn = _sentryDsn;
    options.tracesSampleRate = 1.0;
    options.enableAutoSessionTracking = true;
    options.attachStacktrace = true;
    options.enableAutoPerformanceTracing = true;
    
    // デバッグモードでは無効にする
    options.debug = false;
    
    // プライバシー保護のため、ユーザー情報は送信しない
    options.sendDefaultPii = false;
    
    // リリースとEnvironmentの設定
    options.release = 'booqs_mobile@1.4.73+273';
    options.environment = _getEnvironment();
  }

  /// エラーを手動でSentryに送信
  static Future<void> captureException(
    dynamic exception, {
    dynamic stackTrace,
    String? hint,
  }) async {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      hint: hint != null ? Hint.withMap({'hint': hint}) : null,
    );
  }

  /// メッセージをSentryに送信
  static Future<void> captureMessage(
    String message, {
    SentryLevel level = SentryLevel.info,
  }) async {
    await Sentry.captureMessage(message, level: level);
  }

  /// ユーザーコンテキストの設定
  static void setUserContext({
    String? id,
    String? email,
    String? username,
  }) {
    Sentry.configureScope((scope) {
      scope.setUser(SentryUser(
        id: id,
        email: email,
        username: username,
      ));
    });
  }

  /// カスタムタグの追加
  static void setTag(String key, String value) {
    Sentry.configureScope((scope) {
      scope.setTag(key, value);
    });
  }

  /// カスタムコンテキストの追加
  static void setContext(String key, Map<String, dynamic> context) {
    Sentry.configureScope((scope) {
      scope.setContexts(key, context);
    });
  }

  /// 環境の取得
  static String _getEnvironment() {
    // dart-defineのflavorから環境を判定
    final flavor = const String.fromEnvironment('flavor', defaultValue: '');
    if (flavor == 'dev') {
      return 'development';
    } else if (flavor == 'prod') {
      return 'production';
    }
    
    // fallback: API_HOSTから判定
    final apiHost = dotenv.env['API_HOST'] ?? '';
    if (apiHost.contains('localhost')) {
      return 'development';
    } else if (apiHost.contains('diqt.net')) {
      return 'production';
    }
    return 'unknown';
  }
}