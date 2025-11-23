// デフォルトの言語は日本語（44）
const String defaultLangCode = 'ja';
const int defaultLangNumber = 44;
// 多言語化(i18n)に対応している言語番号
const List<int> supportedLangNumbers = [21, 44];
const List<int> supportedTTSLangNumbers = [21, 44];

// 分かち書きが必要な言語は、日本語、中国語、中国語(繁体字)、中国語（簡体字）、タイ語
const List<int> segmentationNeededLangNumbers = [
  44,
  110,
  14,
  15,
  97,
];

// 右横書き文字
// アラビア語、ヘブライ語、ペルシア語、ウルドゥー語
const List<int> rightToLeftScriptsNumbers = [4, 35, 72, 101];

// 言語コードと言語番号(ID)の対応づけ。
// IDで管理しているのは、zh-CN と zh-Hans のように言語コードの表記揺れに対応するため。
// localeの切り替え以外では、主に揺れのないIDを利用する
const Map<String, int> languageCodeMap = {
  'undefined': 0,
  'af': 1,
  'sq': 2,
  'am': 3,
  'ar': 4,
  'hy': 5,
  'az': 6,
  'eu': 7,
  'be': 8,
  'bn': 9,
  'bs': 10,
  'bg': 11,
  'ca': 12,
  'ceb': 13,
  'zh': 110, // 繁体字も簡体字も含めた中国語
  'yue': 115, // 広東語
  'zh-CN': 14,
  'zh-Hans': 14,
  'zh-TW': 15,
  'zh-Hant': 15,
  'co': 16,
  'hr': 17,
  'cs': 18,
  'da': 19,
  'nl': 20,
  'en': 21,
  'eo': 22,
  'et': 23,
  'fi': 24,
  'fr': 25,
  'fy': 26,
  'gl': 27,
  'ka': 28,
  'de': 29,
  'el': 30,
  'gu': 31,
  'ht': 32,
  'ha': 33,
  'haw': 34,
  'he': 35,
  'iw': 35,
  'hi': 36,
  'hmn': 37,
  'hu': 38,
  'is': 39,
  'ig': 40,
  'id': 41,
  'ga': 42,
  'it': 43,
  'ja': 44,
  'jv': 45,
  'kn': 46,
  'kk': 47,
  'km': 48,
  'rw': 49,
  'ko': 50,
  'ku': 51,
  'ky': 52,
  'lo': 53,
  'la': 54,
  'lv': 55,
  'lt': 56,
  'lb': 57,
  'mk': 58,
  'mg': 59,
  'ms': 60,
  'ml': 61,
  'mt': 62,
  'mi': 63,
  'mr': 64,
  'mn': 65,
  'my': 66,
  'ne': 67,
  'no': 68,
  'ny': 69,
  'or': 70,
  'ps': 71,
  'fa': 72,
  'pl': 73,
  'pt': 74,
  'pa': 75,
  'ro': 76,
  'ru': 77,
  'sm': 78,
  'gd': 79,
  'sr': 80,
  'st': 81,
  'sn': 82,
  'sd': 83,
  'si': 84,
  'sk': 85,
  'sl': 86,
  'so': 87,
  'es': 88,
  'su': 89,
  'sw': 90,
  'sv': 91,
  'tl': 92,
  'fil': 92,
  'tg': 93,
  'ta': 94,
  'tt': 95,
  'te': 96,
  'th': 97,
  'tr': 98,
  'tk': 99,
  'uk': 100,
  'ur': 101,
  'ug': 102,
  'uz': 103,
  'vi': 104,
  'cy': 105,
  'xh': 106,
  'yi': 107,
  'yo': 108,
  'zu': 109,
  // 110はzh（中国語）
  'ff': 111, // フラニ語（フラ語） / TTS対応外
  'sa': 112, // サンスクリット語 / TTS対応外
  'ban': 113, // バリ語 / TTS対応外
  'bo': 114, // チベット語 / TTS対応外
};

// Azure Computer Vision の Image Analysis API で使用できる言語コード
const List<String> azureImageAnalysisLanguages = [
  'ar',
  'az',
  'bg',
  'bs',
  'ca',
  'cs',
  'cy',
  'da',
  'de',
  'el',
  'en',
  'es',
  'et',
  'eu',
  'fi',
  'fr',
  'ga',
  'gl',
  'he',
  'hi',
  'hr',
  'hu',
  'id',
  'it',
  'ja',
  'kk',
  'ko',
  'lt',
  'lv',
  'mk',
  'ms',
  'nb',
  'nl',
  'pl',
  'prs',
  'pt-BR',
  'pt',
  'pt-PT',
  'ro',
  'ru',
  'sk',
  'sl',
  'sr-Cryl',
  'sr-Latn',
  'sv',
  'th',
  'tr',
  'uk',
  'vi',
  'zh',
  'zh-Hans',
  'zh-Hant'
];

// CEFR-J言語コードマップ
const Map<String, int> cefrjLanguageCodeMap = {
  'en': 21, // 英語
  'ja': 44, // 日本語
  'fr': 25, // フランス語
  'de': 29, // ドイツ語
  'es': 88, // スペイン語
  'it': 43, // イタリア語
  'ru': 77, // ロシア語
  'zh': 110, // 中国語（繁体字）
  'ko': 50, // 韓国語
  'pt': 74, // ポルトガル語
  'pl': 73, // ポーランド語
  'cs': 18, // チェコ語
  'mn': 65, // モンゴル語
  'id': 41, // インドネシア語
  'ms': 60, // マレー語
  'tl': 92, // タガログ語
  'th': 97, // タイ語
  'lo': 53, // ラオ語
  'vi': 104, // ベトナム語
  'km': 48, // カンボジア語
  'my': 66, // ミャンマー語
  'ur': 101, // ウルドゥー語
  'hi': 36, // ヒンディー語
  'bn': 9, // ベンガル語
  'ar': 4, // アラビア語
  'fa': 72, // ペルシア語
  'tr': 98, // トルコ語
  'uz': 103, // ウズベク語
};
// 単語帳で使用できる辞書ID
const Map<String, int> wordBookSupportedDictIds = {
  'en': 1,
  'es': 10,
  'it': 11,
  'ru': 13,
  'fr': 14,
  'de': 12,
  'pt': 15,
  'zh': 18,
  'pl': 19,
  'ar': 21,
  'ja': 7,
  'cs': 32,
  'ko': 33,
  'vi': 38,
  'tr': 39,
  'tl': 41,
  'th': 48,
  'hi': 46,
  'id': 45,
  'fa': 51,
  'km': 59,
  'ms': 65,
  'bn': 68,
  'my': 72,
  'ur': 62,
  'mn': 73,
  'uz': 149,
  'lo': 151
};
