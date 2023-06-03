// DiQt の API の URL を生成する
class DiQtURL {
  //
  static String root({String? locale}) {
    if (locale == null) {
      return DiQtURL.rootWithoutLocale();
    } else {
      return DiQtURL.rootWithLocale(locale);
    }
  }

  //
  static String rootWithLocale(String locale) {
    return '${const String.fromEnvironment("rootUrl")}/$locale';
  }

  //
  static String rootWithoutLocale() {
    return const String.fromEnvironment("rootUrl");
  }
}
