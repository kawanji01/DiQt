import 'dart:io';

class EnvHandler {
  //
  static bool isMobile() {
    return Platform.isAndroid || Platform.isIOS;
  }

  static bool isDesktop() {
    return !isMobile();
  }

  static bool isDev() {
    return const String.fromEnvironment("flavor") == 'dev';
  }

  static bool isProd() {
    return const String.fromEnvironment("flavor") == 'prod';
  }
}
