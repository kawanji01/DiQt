import 'package:booqs_mobile/utils/locale_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('utils/locale_handler', () {
    const String unsupportedLocale = 'fr';
    test(
        'LocaleHandler.localeByCode returns correct locale for supported language codes',
        () {
      expect(LocaleHandler.localeByCode('en'), equals('en'));
      expect(LocaleHandler.localeByCode('ja'), equals('ja'));
      // デバイスのlocale（例: en-US）はそのまま返す。
      final String deviceLocale =
          WidgetsBinding.instance.window.locale.toLanguageTag();
      expect(LocaleHandler.localeByCode(deviceLocale), equals(deviceLocale));
    });

    test(
        'LocaleHandler.localeByCode returns default locale for unsupported language codes',
        () {
      expect(LocaleHandler.localeByCode('fr'), isNot('fr'));
    });

    // 対応していない言語コード（デバイス標準のlocaleを含む）に対しては、言語コードと国コードで構成されたデバイスの locale （例: en-US）を返す
    test(
        'LocaleHandler.localeByCode returns device languageTag(languageCode-CountryCode) for unsupported language codes',
        () {
      final String deviceLocale =
          WidgetsBinding.instance.window.locale.toLanguageTag();
      expect(
          LocaleHandler.localeByCode(unsupportedLocale), equals(deviceLocale));
    });

    // LocaleHandler.localeForAPIByCode （API用のlocaleを取得するメソッド）
    test(
        'LocaleHandler.localeForAPIByCode returns correct locale for supported language codes',
        () {
      expect(LocaleHandler.localeForAPIByCode('en'), equals('en'));
      expect(LocaleHandler.localeForAPIByCode('ja'), equals('ja'));
    });

    test(
        'LocaleHandler.localeForAPIByCode returns default locale for unsupported language codes',
        () {
      // 対応していない言語コード
      expect(LocaleHandler.localeForAPIByCode(unsupportedLocale),
          isNot(unsupportedLocale));
      // languageCode-countryCodeになっているコード
      expect(LocaleHandler.localeForAPIByCode('ja-ja'), isNot('ja-ja'));
      expect(LocaleHandler.localeForAPIByCode('en-US'), isNot('en-US'));
    });

    // 対応していない言語コードに対しては、構成されたデバイスの言語コード （例: en）を返す
    test(
        'LocaleHandler.localeForAPIByCode returns device locale for unsupported language codes',
        () {
      final String deviceLangCode =
          WidgetsBinding.instance.window.locale.languageCode;
      expect(LocaleHandler.localeForAPIByCode(unsupportedLocale),
          equals(deviceLangCode));
    });
  });
}
