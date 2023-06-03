// DiQt の API の URL を生成する
class DiQtURL {
  //
  static String root({String? locale}) {
    if (locale == null) {
      return DiQtURL.root();
    } else {
      return DiQtURL.rootWithLocale(locale);
    }
  }

  //
  static String rootWithLocale(String locale) {
    return '${const String.fromEnvironment("rootUrl")}/$locale';
  }

  //
  static String root() {
    return const String.fromEnvironment("rootUrl");
  }
}
