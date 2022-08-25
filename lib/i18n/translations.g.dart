/*
 * Generated file. Do not edit.
 *
 * Locales: 2
 * Strings: 502 (251.0 per locale)
 *
 * Built on 2022-08-25 at 12:40 UTC
 */

import 'package:flutter/widgets.dart';

const AppLocale _baseLocale = AppLocale.en;
AppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale {
  en, // 'en' (base locale, fallback)
  ja, // 'ja'
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
///
/// Usage:
/// String a = t.someKey.anotherKey;
_TranslationsEn _t = _currLocale.translations;
_TranslationsEn get t => _t;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
class Translations {
  Translations._(); // no constructor

  static _TranslationsEn of(BuildContext context) {
    final inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
    if (inheritedWidget == null) {
      throw 'Please wrap your app with "TranslationProvider".';
    }
    return inheritedWidget.translations;
  }
}

class LocaleSettings {
  LocaleSettings._(); // no constructor

  /// Uses locale of the device, fallbacks to base locale.
  /// Returns the locale which has been set.
  static AppLocale useDeviceLocale() {
    final locale = AppLocaleUtils.findDeviceLocale();
    return setLocale(locale);
  }

  /// Sets locale
  /// Returns the locale which has been set.
  static AppLocale setLocale(AppLocale locale) {
    _currLocale = locale;
    _t = _currLocale.translations;

    // force rebuild if TranslationProvider is used
    _translationProviderKey.currentState?.setLocale(_currLocale);

    return _currLocale;
  }

  /// Sets locale using string tag (e.g. en_US, de-DE, fr)
  /// Fallbacks to base locale.
  /// Returns the locale which has been set.
  static AppLocale setLocaleRaw(String rawLocale) {
    final locale = AppLocaleUtils.parse(rawLocale);
    return setLocale(locale);
  }

  /// Gets current locale.
  static AppLocale get currentLocale {
    return _currLocale;
  }

  /// Gets base locale.
  static AppLocale get baseLocale {
    return _baseLocale;
  }

  /// Gets supported locales in string format.
  static List<String> get supportedLocalesRaw {
    return AppLocale.values.map((locale) => locale.languageTag).toList();
  }

  /// Gets supported locales (as Locale objects) with base locale sorted first.
  static List<Locale> get supportedLocales {
    return AppLocale.values.map((locale) => locale.flutterLocale).toList();
  }
}

/// Provides utility functions without any side effects.
class AppLocaleUtils {
  AppLocaleUtils._(); // no constructor

  /// Returns the locale of the device as the enum type.
  /// Fallbacks to base locale.
  static AppLocale findDeviceLocale() {
    final String? deviceLocale =
        WidgetsBinding.instance!.window.locale.toLanguageTag();
    if (deviceLocale != null) {
      final typedLocale = _selectLocale(deviceLocale);
      if (typedLocale != null) {
        return typedLocale;
      }
    }
    return _baseLocale;
  }

  /// Returns the enum type of the raw locale.
  /// Fallbacks to base locale.
  static AppLocale parse(String rawLocale) {
    return _selectLocale(rawLocale) ?? _baseLocale;
  }
}

// context enums

enum GenderContext {
  male,
  female,
}

// interfaces generated as mixins

mixin PageData2 {
  String get title;
  String? get content => null;
}

// translation instances

late _TranslationsEn _translationsEn = _TranslationsEn.build();
late _TranslationsJa _translationsJa = _TranslationsJa.build();

// extensions for AppLocale

extension AppLocaleExtensions on AppLocale {
  /// Gets the translation instance managed by this library.
  /// [TranslationProvider] is using this instance.
  /// The plural resolvers are set via [LocaleSettings].
  _TranslationsEn get translations {
    switch (this) {
      case AppLocale.en:
        return _translationsEn;
      case AppLocale.ja:
        return _translationsJa;
    }
  }

  /// Gets a new translation instance.
  /// [LocaleSettings] has no effect here.
  /// Suitable for dependency injection and unit tests.
  ///
  /// Usage:
  /// final t = AppLocale.en.build(); // build
  /// String a = t.my.path; // access
  _TranslationsEn build() {
    switch (this) {
      case AppLocale.en:
        return _TranslationsEn.build();
      case AppLocale.ja:
        return _TranslationsJa.build();
    }
  }

  String get languageTag {
    switch (this) {
      case AppLocale.en:
        return 'en';
      case AppLocale.ja:
        return 'ja';
    }
  }

  Locale get flutterLocale {
    switch (this) {
      case AppLocale.en:
        return const Locale.fromSubtags(languageCode: 'en');
      case AppLocale.ja:
        return const Locale.fromSubtags(languageCode: 'ja');
    }
  }
}

extension StringAppLocaleExtensions on String {
  AppLocale? toAppLocale() {
    switch (this) {
      case 'en':
        return AppLocale.en;
      case 'ja':
        return AppLocale.ja;
      default:
        return null;
    }
  }
}

// wrappers

GlobalKey<_TranslationProviderState> _translationProviderKey =
    GlobalKey<_TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
  TranslationProvider({required this.child})
      : super(key: _translationProviderKey);

  final Widget child;

  @override
  _TranslationProviderState createState() => _TranslationProviderState();

  static _InheritedLocaleData of(BuildContext context) {
    final inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
    if (inheritedWidget == null) {
      throw 'Please wrap your app with "TranslationProvider".';
    }
    return inheritedWidget;
  }
}

class _TranslationProviderState extends State<TranslationProvider> {
  AppLocale locale = _currLocale;

  void setLocale(AppLocale newLocale) {
    setState(() {
      locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedLocaleData(
      locale: locale,
      child: widget.child,
    );
  }
}

class _InheritedLocaleData extends InheritedWidget {
  final AppLocale locale;
  Locale get flutterLocale => locale.flutterLocale; // shortcut
  final _TranslationsEn translations; // store translations to avoid switch call

  _InheritedLocaleData({required this.locale, required Widget child})
      : translations = locale.translations,
        super(child: child);

  @override
  bool updateShouldNotify(_InheritedLocaleData oldWidget) {
    return oldWidget.locale != locale;
  }
}

// pluralization feature not used

// helpers

final _localeRegex =
    RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
AppLocale? _selectLocale(String localeRaw) {
  final match = _localeRegex.firstMatch(localeRaw);
  AppLocale? selected;
  if (match != null) {
    final language = match.group(1);
    final country = match.group(5);

    // match exactly
    selected = AppLocale.values.cast<AppLocale?>().firstWhere(
        (supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'),
        orElse: () => null);

    if (selected == null && language != null) {
      // match language
      selected = AppLocale.values.cast<AppLocale?>().firstWhere(
          (supported) => supported?.languageTag.startsWith(language) == true,
          orElse: () => null);
    }

    if (selected == null && country != null) {
      // match country
      selected = AppLocale.values.cast<AppLocale?>().firstWhere(
          (supported) => supported?.languageTag.contains(country) == true,
          orElse: () => null);
    }
  }
  return selected;
}

// translations

// Path: <root>
class _TranslationsEn {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  _TranslationsEn.build();

  late final _TranslationsEn _root = this; // ignore: unused_field

  // Translations
  Map<String, String> get lang => {
        'language_setting': 'Language',
        'auto-configure': 'Auto-configure',
        'undefined': 'Undefined',
        'af': 'Afrikaans',
        'sq': 'Albanian',
        'am': 'Amharic',
        'ar': 'Arabic',
        'hy': 'Armenian',
        'az': 'Azerbaijani',
        'eu': 'Basque',
        'be': 'Belarusian',
        'bn': 'Bengali',
        'bs': 'Bosnian',
        'bg': 'Bulgarian',
        'ca': 'Catalan',
        'ceb': 'Cebuano',
        'zh-CN': 'Chinese (Simplified)',
        'zh': 'Chinese',
        'zh-TW': 'Chinese (Traditional)',
        'co': 'Corsican',
        'hr': 'Croatian',
        'cs': 'Czech',
        'da': 'Danish',
        'nl': 'Dutch',
        'en': 'English',
        'eo': 'Esperanto',
        'et': 'Estonian',
        'fi': 'Finnish',
        'fr': 'French',
        'fy': 'Frisian',
        'gl': 'Galician',
        'ka': 'Georgian',
        'de': 'German',
        'el': 'Greek',
        'gu': 'Gujarati',
        'ht': 'Haitian Creole',
        'ha': 'Hausa',
        'haw': 'Hawaiian',
        'he': 'Hebrew',
        'iw': 'Hebrew',
        'hi': 'Hindi',
        'hmn': 'Hmong',
        'hu': 'Hungarian',
        'is': 'Icelandic',
        'ig': 'Igbo',
        'id': 'Indonesian',
        'ga': 'Irish',
        'it': 'Italian',
        'ja': 'Japanese',
        'jv': 'Javanese',
        'kn': 'Kannada',
        'kk': 'Kazakh',
        'km': 'Khmer',
        'rw': 'Kinyarwanda',
        'ko': 'Korean',
        'ku': 'Kurdish',
        'ky': 'Kyrgyz',
        'lo': 'Lao',
        'la': 'Latin',
        'lv': 'Latvian',
        'lt': 'Lithuanian',
        'lb': 'Luxembourgish',
        'mk': 'Macedonian',
        'mg': 'Malagasy',
        'ms': 'Malay',
        'ml': 'Malayalam',
        'mt': 'Maltese',
        'mi': 'Maori',
        'mr': 'Marathi',
        'mn': 'Mongolian',
        'my': 'Myanmar (Burmese)',
        'ne': 'Nepali',
        'no': 'Norwegian',
        'ny': 'Nyanja (Chichewa)',
        'or': 'Odia (Oriya)',
        'ps': 'Pashto',
        'fa': 'Persian',
        'pl': 'Polish',
        'pt': 'Portuguese (Portugal, Brazil)',
        'pa': 'Punjabi',
        'ro': 'Romanian',
        'ru': 'Russian',
        'sm': 'Samoan',
        'gd': 'Scots Gaelic',
        'sr': 'Serbian',
        'st': 'Sesotho',
        'sn': 'Shona',
        'sd': 'Sindhi',
        'si': 'Sinhala (Sinhalese)',
        'sk': 'Slovak',
        'sl': 'Slovenian',
        'so': 'Somali',
        'es': 'Spanish',
        'su': 'Sundanese',
        'sw': 'Swahili',
        'sv': 'Swedish',
        'tl': 'Tagalog (Filipino)',
        'tg': 'Tajik',
        'ta': 'Tamil',
        'tt': 'Tatar',
        'te': 'Telugu',
        'th': 'Thai',
        'tr': 'Turkish',
        'tk': 'Turkmen',
        'uk': 'Ukrainian',
        'ur': 'Urdu',
        'ug': 'Uyghur',
        'uz': 'Uzbek',
        'vi': 'Vietnamese',
        'cy': 'Welsh',
        'xh': 'Xhosa',
        'yi': 'Yiddish',
        'yo': 'Yoruba',
        'zu': 'Zulu',
        'af-ZA': 'Afrikaans (South Africa)',
        'sq-AL': 'Albanian (Albania)',
        'am-ET': 'Amharic (Ethiopia)',
        'ar-DZ': 'Arabic (Algeria)',
        'ar-BH': 'Arabic (Bahrain)',
        'ar-EG': 'Arabic (Egypt)',
        'ar-IQ': 'Arabic (Iraq)',
        'ar-IL': 'Arabic (Israel)',
        'ar-JO': 'Arabic (Jordan)',
        'ar-KW': 'Arabic (Kuwait)',
        'ar-LB': 'Arabic (Lebanon)',
        'ar-MA': 'Arabic (Morocco)',
        'ar-OM': 'Arabic (Oman)',
        'ar-QA': 'Arabic (Qatar)',
        'ar-SA': 'Arabic (Saudi Arabia)',
        'ar-PS': 'Arabic (State of Palestine)',
        'ar-TN': 'Arabic (Tunisia)',
        'ar-AE': 'Arabic (United Arab Emirates)',
        'ar-YE': 'Arabic (Yemen)',
        'hy-AM': 'Armenian (Armenia)',
        'az-AZ': 'Azerbaijani (Azerbaijan)',
        'eu-ES': 'Basque (Spain)',
        'bn-BD': 'Bengali (Bangladesh)',
        'bn-IN': 'Bengali (India)',
        'bs-BA': 'Bosnian (Bosnia and Herzegovina)',
        'bg-BG': 'Bulgarian (Bulgaria)',
        'my-MM': 'Burmese (Myanmar)',
        'ca-ES': 'Catalan (Spain)',
        'yue-Hant-HK': 'Chinese, Cantonese (Traditional Hong Kong)',
        'cmn-Hans-CN': 'Chinese, Mandarin (Simplified, China)',
        'cmn-Hant-TW': 'Chinese, Mandarin (Traditional, Taiwan)',
        'hr-HR': 'Croatian (Croatia)',
        'cs-CZ': 'Czech (Czech Republic)',
        'da-DK': 'Danish (Denmark)',
        'nl-BE': 'Dutch (Belgium)',
        'nl-NL': 'Dutch (Netherlands)',
        'en-AU': 'English (Australia)',
        'en-CA': 'English (Canada)',
        'en-GH': 'English (Ghana)',
        'en-HK': 'English (Hong Kong)',
        'en-IN': 'English (India)',
        'en-IE': 'English (Ireland)',
        'en-KE': 'English (Kenya)',
        'en-NZ': 'English (New Zealand)',
        'en-NG': 'English (Nigeria)',
        'en-PK': 'English (Pakistan)',
        'en-PH': 'English (Philippines)',
        'en-SG': 'English (Singapore)',
        'en-ZA': 'English (South Africa)',
        'en-TZ': 'English (Tanzania)',
        'en-GB': 'English (United Kingdom)',
        'en-US': 'English (United States)',
        'et-EE': 'Estonian (Estonia)',
        'fil-PH': 'Filipino (Philippines)',
        'fi-FI': 'Finnish (Finland)',
        'fr-BE': 'French (Belgium)',
        'fr-CA': 'French (Canada)',
        'fr-FR': 'French (France)',
        'fr-CH': 'French (Switzerland)',
        'gl-ES': 'Galician (Spain)',
        'ka-GE': 'Georgian (Georgia)',
        'de-AT': 'German (Austria)',
        'de-DE': 'German (Germany)',
        'de-CH': 'German (Switzerland)',
        'el-GR': 'Greek (Greece)',
        'gu-IN': 'Gujarati (India)',
        'iw-IL': 'Hebrew (Israel)',
        'hi-IN': 'Hindi (India)',
        'hu-HU': 'Hungarian (Hungary)',
        'is-IS': 'Icelandic (Iceland)',
        'id-ID': 'Indonesian (Indonesia)',
        'it-IT': 'Italian (Italy)',
        'it-CH': 'Italian (Switzerland)',
        'ja-JP': 'Japanese (Japan)',
        'jv-ID': 'Javanese (Indonesia)',
        'kn-IN': 'Kannada (India)',
        'kk-KZ': 'Kazakh (Kazakhstan)',
        'km-KH': 'Khmer (Cambodia)',
        'ko-KR': 'Korean (South Korea)',
        'lo-LA': 'Lao (Laos)',
        'lv-LV': 'Latvian (Latvia)',
        'lt-LT': 'Lithuanian (Lithuania)',
        'mk-MK': 'Macedonian (North Macedonia)',
        'ms-MY': 'Malay (Malaysia)',
        'ml-IN': 'Malayalam (India)',
        'mr-IN': 'Marathi (India)',
        'mn-MN': 'Mongolian (Mongolia)',
        'ne-NP': 'Nepali (Nepal)',
        'no-NO': 'Norwegian Bokmål (Norway)',
        'fa-IR': 'Persian (Iran)',
        'pl-PL': 'Polish (Poland)',
        'pt-BR': 'Portuguese (Brazil)',
        'pt-PT': 'Portuguese (Portugal)',
        'pa-Guru-IN': 'Punjabi (Gurmukhi India)',
        'ro-RO': 'Romanian (Romania)',
        'ru-RU': 'Russian (Russia)',
        'sr-RS': 'Serbian (Serbia)',
        'si-LK': 'Sinhala (Sri Lanka)',
        'sk-SK': 'Slovak (Slovakia)',
        'sl-SI': 'Slovenian (Slovenia)',
        'es-AR': 'Spanish (Argentina)',
        'es-BO': 'Spanish (Bolivia)',
        'es-CL': 'Spanish (Chile)',
        'es-CO': 'Spanish (Colombia)',
        'es-CR': 'Spanish (Costa Rica)',
        'es-DO': 'Spanish (Dominican Republic)',
        'es-EC': 'Spanish (Ecuador)',
        'es-SV': 'Spanish (El Salvador)',
        'es-GT': 'Spanish (Guatemala)',
        'es-HN': 'Spanish (Honduras)',
        'es-MX': 'Spanish (Mexico)',
        'es-NI': 'Spanish (Nicaragua)',
        'es-PA': 'Spanish (Panama)',
        'es-PY': 'Spanish (Paraguay)',
        'es-PE': 'Spanish (Peru)',
        'es-PR': 'Spanish (Puerto Rico)',
        'es-ES': 'Spanish (Spain)',
        'es-US': 'Spanish (United States)',
        'es-UY': 'Spanish (Uruguay)',
        'es-VE': 'Spanish (Venezuela)',
        'su-ID': 'Sundanese (Indonesia)',
        'sw-KE': 'Swahili (Kenya)',
        'sw-TZ': 'Swahili (Tanzania)',
        'sv-SE': 'Swedish (Sweden)',
        'ta-IN': 'Tamil (India)',
        'ta-MY': 'Tamil (Malaysia)',
        'ta-SG': 'Tamil (Singapore)',
        'ta-LK': 'Tamil (Sri Lanka)',
        'te-IN': 'Telugu (India)',
        'th-TH': 'Thai (Thailand)',
        'tr-TR': 'Turkish (Turkey)',
        'uk-UA': 'Ukrainian (Ukraine)',
        'ur-IN': 'Urdu (India)',
        'ur-PK': 'Urdu (Pakistan)',
        'uz-UZ': 'Uzbek (Uzbekistan)',
        'vi-VN': 'Vietnamese (Vietnam)',
        'zu-ZA': 'Zulu (South Africa)',
      };
}

// Path: <root>
class _TranslationsJa extends _TranslationsEn {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  _TranslationsJa.build() : super.build();

  @override
  late final _TranslationsJa _root = this; // ignore: unused_field

  // Translations
  @override
  Map<String, String> get lang => {
        'language_setting': '言語設定',
        'auto-configure': '自動で設定する',
        'undefined': '未定義',
        'af': 'アフリカーンス語',
        'sq': 'アルバニア語',
        'am': 'アムハラ語',
        'ar': 'アラビア文字',
        'hy': 'アルメニア語',
        'az': 'アゼルバイジャン語',
        'eu': 'バスク語',
        'be': 'ベラルーシ語',
        'bn': 'ベンガル文字',
        'bs': 'ボスニア語',
        'bg': 'ブルガリア語',
        'ca': 'カタロニア語',
        'ceb': 'セブ語',
        'zh-CN': '中国語（簡体）',
        'zh': '中国語',
        'zh-TW': '中国語（繁体）',
        'co': 'コルシカ語',
        'hr': 'クロアチア語',
        'cs': 'チェコ語',
        'da': 'デンマーク語',
        'nl': 'オランダ語',
        'en': '英語',
        'eo': 'エスペラント語',
        'et': 'エストニア語',
        'fi': 'フィンランド語',
        'fr': 'フランス語',
        'fy': 'フリジア語',
        'gl': 'ガリシア語',
        'ka': 'グルジア語',
        'de': 'ドイツ語',
        'el': 'ギリシャ語',
        'gu': 'グジャラト語',
        'ht': 'クレオール語（ハイチ）',
        'ha': 'ハウサ語',
        'haw': 'ハワイ語',
        'he': 'ヘブライ語',
        'iw': 'ヘブライ語',
        'hi': 'ヒンディー語',
        'hmn': 'モン語',
        'hu': 'ハンガリー語',
        'is': 'アイスランド語',
        'ig': 'イボ語',
        'id': 'インドネシア語',
        'ga': 'アイルランド語',
        'it': 'イタリア語',
        'ja': '日本語',
        'jv': 'ジャワ語',
        'kn': 'カンナダ語',
        'kk': 'カザフ語',
        'km': 'クメール語',
        'rw': 'キニヤルワンダ語',
        'ko': '韓国語',
        'ku': 'クルド語',
        'ky': 'キルギス語',
        'lo': 'ラオ語',
        'la': 'ラテン語',
        'lv': 'ラトビア語',
        'lt': 'リトアニア語',
        'lb': 'ルクセンブルク語',
        'mk': 'マケドニア語',
        'mg': 'マラガシ語',
        'ms': 'マレー語',
        'ml': 'マラヤーラム文字',
        'mt': 'マルタ語',
        'mi': 'マオリ語',
        'mr': 'マラーティー語',
        'mn': 'モンゴル語',
        'my': 'ミャンマー語（ビルマ語）',
        'ne': 'ネパール語',
        'no': 'ノルウェー語',
        'ny': 'ニャンジャ語（チェワ語）',
        'or': 'オリヤ語',
        'ps': 'パシュト語',
        'fa': 'ペルシャ語',
        'pl': 'ポーランド語',
        'pt': 'ポルトガル語（ポルトガル、ブラジル）',
        'pa': 'パンジャブ語',
        'ro': 'ルーマニア語',
        'ru': 'ロシア語',
        'sm': 'サモア語',
        'gd': 'スコットランド ゲール語',
        'sr': 'セルビア語',
        'st': 'セソト語',
        'sn': 'ショナ語',
        'sd': 'シンド語',
        'si': 'シンハラ語',
        'sk': 'スロバキア語',
        'sl': 'スロベニア語',
        'so': 'ソマリ語',
        'es': 'スペイン語',
        'su': 'スンダ語',
        'sw': 'スワヒリ語',
        'sv': 'スウェーデン語',
        'tl': 'タガログ語（フィリピン語）',
        'tg': 'タジク語',
        'ta': 'タミル語',
        'tt': 'タタール語',
        'te': 'テルグ語',
        'th': 'タイ語',
        'tr': 'トルコ語',
        'tk': 'トルクメン語',
        'uk': 'ウクライナ語',
        'ur': 'ウルドゥー語',
        'ug': 'ウイグル語',
        'uz': 'ウズベク語',
        'vi': 'ベトナム語',
        'cy': 'ウェールズ語',
        'xh': 'コーサ語',
        'yi': 'イディッシュ語',
        'yo': 'ヨルバ語',
        'zu': 'ズールー語',
        'af-ZA': 'アフリカーンス語（南アフリカ）',
        'sq-AL': 'アルバニア語（アルバニア）',
        'am-ET': 'アムハラ語（エチオピア）',
        'ar-DZ': 'アラビア語（アルジェリア）',
        'ar-BH': 'アラビア語（バーレーン）',
        'ar-EG': 'アラビア語（エジプト）',
        'ar-IQ': 'アラビア語（イラク）',
        'ar-IL': 'アラビア語（イスラエル）',
        'ar-JO': 'アラビア語（ヨルダン）',
        'ar-KW': 'アラビア語（クウェート）',
        'ar-LB': 'アラビア語（レバノン）',
        'ar-MA': 'アラビア語（モロッコ）',
        'ar-OM': 'アラビア語（オマーン）',
        'ar-QA': 'アラビア語（カタール）',
        'ar-SA': 'アラビア語（サウジアラビア）',
        'ar-PS': 'アラビア語（パレスチナ国）',
        'ar-TN': 'アラビア語（チュニジア）',
        'ar-AE': 'アラビア語（アラブ首長国連邦）',
        'ar-YE': 'アラビア語（イエメン）',
        'hy-AM': 'アルメニア語（アルメニア）',
        'az-AZ': 'アゼルバイジャン語（アゼルバイジャン）',
        'eu-ES': 'バスク語（スペイン）',
        'bn-BD': 'ベンガル語（バングラデシュ）',
        'bn-IN': 'ベンガル語（インド）',
        'bs-BA': 'ボスニア語（ボスニア ヘルツェゴビナ）',
        'bg-BG': 'ブルガリア語（ブルガリア）',
        'my-MM': 'ビルマ語（ミャンマー）',
        'ca-ES': 'カタルーニャ語（スペイン）',
        'yue-Hant-HK': '広東語（繁体字、香港）',
        'cmn-Hans-CN': '中国語（簡体字、中国本土）',
        'cmn-Hant-TW': '中国語（繁体字、台湾）',
        'hr-HR': 'クロアチア語（クロアチア）',
        'cs-CZ': 'チェコ語（チェコ共和国）',
        'da-DK': 'デンマーク語（デンマーク）',
        'nl-BE': 'オランダ語（ベルギー）',
        'nl-NL': 'オランダ語（オランダ）',
        'en-AU': '英語（オーストラリア）',
        'en-CA': '英語（カナダ）',
        'en-GH': '英語（ガーナ）',
        'en-HK': '英語（香港）',
        'en-IN': '英語（インド）',
        'en-IE': '英語（アイルランド）',
        'en-KE': '英語（ケニア）',
        'en-NZ': '英語（ニュージーランド）',
        'en-NG': '英語（ナイジェリア）',
        'en-PK': '英語（パキスタン）',
        'en-PH': '英語（フィリピン）',
        'en-SG': '英語（シンガポール）',
        'en-ZA': '英語（南アフリカ）',
        'en-TZ': '英語（タンザニア）',
        'en-GB': '英語（イギリス）',
        'en-US': '英語（米国）',
        'et-EE': 'エストニア語（エストニア）',
        'fil-PH': 'フィリピン語（フィリピン）',
        'fi-FI': 'フィンランド語（フィンランド）',
        'fr-BE': 'フランス語（ベルギー）',
        'fr-CA': 'フランス語（カナダ）',
        'fr-FR': 'フランス語（フランス）',
        'fr-CH': 'フランス語（スイス）',
        'gl-ES': 'ガリシア語（スペイン）',
        'ka-GE': 'ジョージア語（ジョージア）',
        'de-AT': 'ドイツ語（オーストリア）',
        'de-DE': 'ドイツ語（ドイツ）',
        'de-CH': 'ドイツ語（スイス）',
        'el-GR': 'ギリシャ語（ギリシャ）',
        'gu-IN': 'グジャラト語（インド）',
        'iw-IL': 'ヘブライ語（イスラエル）',
        'hi-IN': 'ヒンディー語（インド）',
        'hu-HU': 'ハンガリー語（ハンガリー）',
        'is-IS': 'アイスランド語（アイスランド）',
        'id-ID': 'インドネシア語（インドネシア）',
        'it-IT': 'イタリア語（イタリア）',
        'it-CH': 'イタリア語（スイス）',
        'ja-JP': '日本語（日本）',
        'jv-ID': 'ジャワ語（インドネシア）',
        'kn-IN': 'カンナダ語（インド）',
        'kk-KZ': 'カザフ語（カザフスタン）',
        'km-KH': 'クメール語（カンボジア）',
        'ko-KR': '韓国語（韓国）',
        'lo-LA': 'ラオ語（ラオス）',
        'lv-LV': 'ラトビア語（ラトビア）',
        'lt-LT': 'リトアニア語（リトアニア）',
        'mk-MK': 'マケドニア語（北マケドニア）',
        'ms-MY': 'マレー語（マレーシア）',
        'ml-IN': 'マラヤーラム語（インド）',
        'mr-IN': 'マラーティー語（インド）',
        'mn-MN': 'モンゴル語（モンゴル）',
        'ne-NP': 'ネパール語（ネパール）',
        'no-NO': 'ノルウェー語（ノルウェー）',
        'fa-IR': 'ペルシャ語（イラン）',
        'pl-PL': 'ポーランド語（ポーランド）',
        'pt-BR': 'ポルトガル語（ブラジル）',
        'pt-PT': 'ポルトガル語（ポルトガル）',
        'pa-Guru-IN': 'パンジャブ語（グルムキー、インド）',
        'ro-RO': 'ルーマニア語（ルーマニア）',
        'ru-RU': 'ロシア語（ロシア）',
        'sr-RS': 'セルビア語（セルビア）',
        'si-LK': 'シンハラ語（スリランカ）',
        'sk-SK': 'スロバキア語（スロバキア）',
        'sl-SI': 'スロベニア語（スロベニア）',
        'es-AR': 'スペイン語（アルゼンチン）',
        'es-BO': 'スペイン語（ボリビア）',
        'es-CL': 'スペイン語（チリ）',
        'es-CO': 'スペイン語（コロンビア）',
        'es-CR': 'スペイン語（コスタリカ）',
        'es-DO': 'スペイン語（ドミニカ共和国）',
        'es-EC': 'スペイン語（エクアドル）',
        'es-SV': 'スペイン語（エルサルバドル）',
        'es-GT': 'スペイン語（グアテマラ）',
        'es-HN': 'スペイン語（ホンジュラス）',
        'es-MX': 'スペイン語（メキシコ）',
        'es-NI': 'スペイン語（ニカラグア）',
        'es-PA': 'スペイン語（パナマ）',
        'es-PY': 'スペイン語（パラグアイ）',
        'es-PE': 'スペイン語（ペルー）',
        'es-PR': 'スペイン語（プエルトリコ）',
        'es-ES': 'スペイン語（スペイン）',
        'es-US': 'スペイン語（米国）',
        'es-UY': 'スペイン語（ウルグアイ）',
        'es-VE': 'スペイン語（ベネズエラ）',
        'su-ID': 'スンダ語（インドネシア）',
        'sw-KE': 'スワヒリ語（ケニア）',
        'sw-TZ': 'スワヒリ語（タンザニア）',
        'sv-SE': 'スウェーデン語（スウェーデン）',
        'ta-IN': 'タミル語（インド）',
        'ta-MY': 'タミル語（マレーシア）',
        'ta-SG': 'タミル語（シンガポール）',
        'ta-LK': 'タミル語（スリランカ）',
        'te-IN': 'テルグ語（インド）',
        'th-TH': 'タイ語（タイ）',
        'tr-TR': 'トルコ語（トルコ）',
        'uk-UA': 'ウクライナ語（ウクライナ）',
        'ur-IN': 'ウルドゥー語（インド）',
        'ur-PK': 'ウルドゥー語（パキスタン）',
        'uz-UZ': 'ウズベク語（ウズベキスタン）',
        'vi-VN': 'ベトナム語（ベトナム）',
        'zu-ZA': 'ズールー語（南アフリカ）',
      };
}
