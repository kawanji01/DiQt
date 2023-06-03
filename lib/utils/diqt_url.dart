// DiQt の API の URL を生成する
import 'package:booqs_mobile/utils/locale_handler.dart';

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
    final String supportedLocale = LocaleHandler.localeForAPIByCode(locale);
    return '${const String.fromEnvironment("rootUrl")}/$supportedLocale';
  }

  //
  static String rootWithoutLocale() {
    return const String.fromEnvironment("rootUrl");
  }
}
