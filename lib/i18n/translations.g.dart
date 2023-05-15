/// Generated file. Do not edit.
///
/// Locales: 2
/// Strings: 560 (280 per locale)
///
/// Built on 2023-05-14 at 11:12 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, _TranslationsEn> {
	en(languageCode: 'en', build: _TranslationsEn.build),
	ja(languageCode: 'ja', build: _TranslationsJa.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, _TranslationsEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_TranslationsEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_TranslationsEn get t => LocaleSettings.instance.currentTranslations;

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
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _TranslationsEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _TranslationsEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _TranslationsEn> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, _TranslationsEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _TranslationsEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_TranslationsEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _TranslationsEn> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _TranslationsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class _TranslationsEn implements BaseTranslations<AppLocale, _TranslationsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, _TranslationsEn> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final _TranslationsEn _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsLangEn lang = _TranslationsLangEn._(_root);
	late final _TranslationsCalendarsEn calendars = _TranslationsCalendarsEn._(_root);
	late final _TranslationsDictionaryMapsEn dictionaryMaps = _TranslationsDictionaryMapsEn._(_root);
	late final _TranslationsWordsEn words = _TranslationsWordsEn._(_root);
}

// Path: lang
class _TranslationsLangEn {
	_TranslationsLangEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get language_setting => 'Language';
	String get auto_configure => 'Auto_configure';
	String get undefined => 'Undefined';
	String get af => 'Afrikaans';
	String get sq => 'Albanian';
	String get am => 'Amharic';
	String get ar => 'Arabic';
	String get hy => 'Armenian';
	String get az => 'Azerbaijani';
	String get eu => 'Basque';
	String get be => 'Belarusian';
	String get bn => 'Bengali';
	String get bs => 'Bosnian';
	String get bg => 'Bulgarian';
	String get ca => 'Catalan';
	String get ceb => 'Cebuano';
	String get zh_CN => 'Chinese (Simplified)';
	String get zh => 'Chinese';
	String get zh_TW => 'Chinese (Traditional)';
	String get co => 'Corsican';
	String get hr => 'Croatian';
	String get cs => 'Czech';
	String get da => 'Danish';
	String get nl => 'Dutch';
	String get en => 'English';
	String get eo => 'Esperanto';
	String get et => 'Estonian';
	String get fi => 'Finnish';
	String get fr => 'French';
	String get fy => 'Frisian';
	String get gl => 'Galician';
	String get ka => 'Georgian';
	String get de => 'German';
	String get el => 'Greek';
	String get gu => 'Gujarati';
	String get ht => 'Haitian Creole';
	String get ha => 'Hausa';
	String get haw => 'Hawaiian';
	String get he => 'Hebrew';
	String get iw => 'Hebrew';
	String get hi => 'Hindi';
	String get hmn => 'Hmong';
	String get hu => 'Hungarian';
	String get Icelandic => 'Icelandic';
	String get ig => 'Igbo';
	String get id => 'Indonesian';
	String get ga => 'Irish';
	String get it => 'Italian';
	String get ja => 'Japanese';
	String get jv => 'Javanese';
	String get kn => 'Kannada';
	String get kk => 'Kazakh';
	String get km => 'Khmer';
	String get rw => 'Kinyarwanda';
	String get ko => 'Korean';
	String get ku => 'Kurdish';
	String get ky => 'Kyrgyz';
	String get lo => 'Lao';
	String get la => 'Latin';
	String get lv => 'Latvian';
	String get lt => 'Lithuanian';
	String get lb => 'Luxembourgish';
	String get mk => 'Macedonian';
	String get mg => 'Malagasy';
	String get ms => 'Malay';
	String get ml => 'Malayalam';
	String get mt => 'Maltese';
	String get mi => 'Maori';
	String get mr => 'Marathi';
	String get mn => 'Mongolian';
	String get my => 'Myanmar (Burmese)';
	String get ne => 'Nepali';
	String get no => 'Norwegian';
	String get ny => 'Nyanja (Chichewa)';
	String get or => 'Odia (Oriya)';
	String get ps => 'Pashto';
	String get fa => 'Persian';
	String get pl => 'Polish';
	String get pt => 'Portuguese (Portugal, Brazil)';
	String get pa => 'Punjabi';
	String get ro => 'Romanian';
	String get ru => 'Russian';
	String get sm => 'Samoan';
	String get gd => 'Scots Gaelic';
	String get sr => 'Serbian';
	String get st => 'Sesotho';
	String get sn => 'Shona';
	String get sd => 'Sindhi';
	String get si => 'Sinhala (Sinhalese)';
	String get sk => 'Slovak';
	String get sl => 'Slovenian';
	String get so => 'Somali';
	String get es => 'Spanish';
	String get su => 'Sundanese';
	String get sw => 'Swahili';
	String get sv => 'Swedish';
	String get tl => 'Tagalog (Filipino)';
	String get tg => 'Tajik';
	String get ta => 'Tamil';
	String get tt => 'Tatar';
	String get te => 'Telugu';
	String get th => 'Thai';
	String get tr => 'Turkish';
	String get tk => 'Turkmen';
	String get uk => 'Ukrainian';
	String get ur => 'Urdu';
	String get ug => 'Uyghur';
	String get uz => 'Uzbek';
	String get vi => 'Vietnamese';
	String get cy => 'Welsh';
	String get xh => 'Xhosa';
	String get yi => 'Yiddish';
	String get yo => 'Yoruba';
	String get zu => 'Zulu';
	String get af_ZA => 'Afrikaans (South Africa)';
	String get sq_AL => 'Albanian (Albania)';
	String get am_ET => 'Amharic (Ethiopia)';
	String get ar_DZ => 'Arabic (Algeria)';
	String get ar_BH => 'Arabic (Bahrain)';
	String get ar_EG => 'Arabic (Egypt)';
	String get ar_IQ => 'Arabic (Iraq)';
	String get ar_IL => 'Arabic (Israel)';
	String get ar_JO => 'Arabic (Jordan)';
	String get ar_KW => 'Arabic (Kuwait)';
	String get ar_LB => 'Arabic (Lebanon)';
	String get ar_MA => 'Arabic (Morocco)';
	String get ar_OM => 'Arabic (Oman)';
	String get ar_QA => 'Arabic (Qatar)';
	String get ar_SA => 'Arabic (Saudi Arabia)';
	String get ar_PS => 'Arabic (State of Palestine)';
	String get ar_TN => 'Arabic (Tunisia)';
	String get ar_AE => 'Arabic (United Arab Emirates)';
	String get ar_YE => 'Arabic (Yemen)';
	String get hy_AM => 'Armenian (Armenia)';
	String get az_AZ => 'Azerbaijani (Azerbaijan)';
	String get eu_ES => 'Basque (Spain)';
	String get bn_BD => 'Bengali (Bangladesh)';
	String get bn_IN => 'Bengali (India)';
	String get bs_BA => 'Bosnian (Bosnia and Herzegovina)';
	String get bg_BG => 'Bulgarian (Bulgaria)';
	String get my_MM => 'Burmese (Myanmar)';
	String get ca_ES => 'Catalan (Spain)';
	String get yue_Hant_HK => 'Chinese, Cantonese (Traditional Hong Kong)';
	String get cmn_Hans_CN => 'Chinese, Mandarin (Simplified, China)';
	String get cmn_Hant_TW => 'Chinese, Mandarin (Traditional, Taiwan)';
	String get hr_HR => 'Croatian (Croatia)';
	String get cs_CZ => 'Czech (Czech Republic)';
	String get da_DK => 'Danish (Denmark)';
	String get nl_BE => 'Dutch (Belgium)';
	String get nl_NL => 'Dutch (Netherlands)';
	String get en_AU => 'English (Australia)';
	String get en_CA => 'English (Canada)';
	String get en_GH => 'English (Ghana)';
	String get en_HK => 'English (Hong Kong)';
	String get en_IN => 'English (India)';
	String get en_IE => 'English (Ireland)';
	String get en_KE => 'English (Kenya)';
	String get en_NZ => 'English (New Zealand)';
	String get en_NG => 'English (Nigeria)';
	String get en_PK => 'English (Pakistan)';
	String get en_PH => 'English (Philippines)';
	String get en_SG => 'English (Singapore)';
	String get en_ZA => 'English (South Africa)';
	String get en_TZ => 'English (Tanzania)';
	String get en_GB => 'English (United Kingdom)';
	String get en_US => 'English (United States)';
	String get et_EE => 'Estonian (Estonia)';
	String get fil_PH => 'Filipino (Philippines)';
	String get fi_FI => 'Finnish (Finland)';
	String get fr_BE => 'French (Belgium)';
	String get fr_CA => 'French (Canada)';
	String get fr_FR => 'French (France)';
	String get fr_CH => 'French (Switzerland)';
	String get gl_ES => 'Galician (Spain)';
	String get ka_GE => 'Georgian (Georgia)';
	String get de_AT => 'German (Austria)';
	String get de_DE => 'German (Germany)';
	String get de_CH => 'German (Switzerland)';
	String get el_GR => 'Greek (Greece)';
	String get gu_IN => 'Gujarati (India)';
	String get iw_IL => 'Hebrew (Israel)';
	String get hi_IN => 'Hindi (India)';
	String get hu_HU => 'Hungarian (Hungary)';
	String get is_IS => 'Icelandic (Iceland)';
	String get id_ID => 'Indonesian (Indonesia)';
	String get it_IT => 'Italian (Italy)';
	String get it_CH => 'Italian (Switzerland)';
	String get ja_JP => 'Japanese (Japan)';
	String get jv_ID => 'Javanese (Indonesia)';
	String get kn_IN => 'Kannada (India)';
	String get kk_KZ => 'Kazakh (Kazakhstan)';
	String get km_KH => 'Khmer (Cambodia)';
	String get ko_KR => 'Korean (South Korea)';
	String get lo_LA => 'Lao (Laos)';
	String get lv_LV => 'Latvian (Latvia)';
	String get lt_LT => 'Lithuanian (Lithuania)';
	String get mk_MK => 'Macedonian (North Macedonia)';
	String get ms_MY => 'Malay (Malaysia)';
	String get ml_IN => 'Malayalam (India)';
	String get mr_IN => 'Marathi (India)';
	String get mn_MN => 'Mongolian (Mongolia)';
	String get ne_NP => 'Nepali (Nepal)';
	String get no_NO => 'Norwegian Bokmål (Norway)';
	String get fa_IR => 'Persian (Iran)';
	String get pl_PL => 'Polish (Poland)';
	String get pt_BR => 'Portuguese (Brazil)';
	String get pt_PT => 'Portuguese (Portugal)';
	String get pa_Guru_IN => 'Punjabi (Gurmukhi India)';
	String get ro_RO => 'Romanian (Romania)';
	String get ru_RU => 'Russian (Russia)';
	String get sr_RS => 'Serbian (Serbia)';
	String get si_LK => 'Sinhala (Sri Lanka)';
	String get sk_SK => 'Slovak (Slovakia)';
	String get sl_SI => 'Slovenian (Slovenia)';
	String get es_AR => 'Spanish (Argentina)';
	String get es_BO => 'Spanish (Bolivia)';
	String get es_CL => 'Spanish (Chile)';
	String get es_CO => 'Spanish (Colombia)';
	String get es_CR => 'Spanish (Costa Rica)';
	String get es_DO => 'Spanish (Dominican Republic)';
	String get es_EC => 'Spanish (Ecuador)';
	String get es_SV => 'Spanish (El Salvador)';
	String get es_GT => 'Spanish (Guatemala)';
	String get es_HN => 'Spanish (Honduras)';
	String get es_MX => 'Spanish (Mexico)';
	String get es_NI => 'Spanish (Nicaragua)';
	String get es_PA => 'Spanish (Panama)';
	String get es_PY => 'Spanish (Paraguay)';
	String get es_PE => 'Spanish (Peru)';
	String get es_PR => 'Spanish (Puerto Rico)';
	String get es_ES => 'Spanish (Spain)';
	String get es_US => 'Spanish (United States)';
	String get es_UY => 'Spanish (Uruguay)';
	String get es_VE => 'Spanish (Venezuela)';
	String get su_ID => 'Sundanese (Indonesia)';
	String get sw_KE => 'Swahili (Kenya)';
	String get sw_TZ => 'Swahili (Tanzania)';
	String get sv_SE => 'Swedish (Sweden)';
	String get ta_IN => 'Tamil (India)';
	String get ta_MY => 'Tamil (Malaysia)';
	String get ta_SG => 'Tamil (Singapore)';
	String get ta_LK => 'Tamil (Sri Lanka)';
	String get te_IN => 'Telugu (India)';
	String get th_TH => 'Thai (Thailand)';
	String get tr_TR => 'Turkish (Turkey)';
	String get uk_UA => 'Ukrainian (Ukraine)';
	String get ur_IN => 'Urdu (India)';
	String get ur_PK => 'Urdu (Pakistan)';
	String get uz_UZ => 'Uzbek (Uzbekistan)';
	String get vi_VN => 'Vietnamese (Vietnam)';
	String get zu_ZA => 'Zulu (South Africa)';
}

// Path: calendars
class _TranslationsCalendarsEn {
	_TranslationsCalendarsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get sunday => 'Sun.';
	String get monday => 'Mon.';
	String get tuesday => 'Tue.';
	String get wednesday => 'Wed.';
	String get thursday => 'Th.';
	String get friday => 'Fri.';
	String get saturday => 'Sat.';
	String get prev => 'Prev';
	String get next => 'Next';
	String get prevYear => 'PrevYear';
	String get nextYear => 'NextYear';
	String get today => 'Today';
	String get month => 'Month';
	String get week => 'Week';
	String get day => 'Day';
	String answers({required Object count}) => '${count}';
	String get reviewed => 'Review';
}

// Path: dictionaryMaps
class _TranslationsDictionaryMapsEn {
	_TranslationsDictionaryMapsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get set_dictionaries => 'Set My dictionaries';
	String get add_dictionaries => 'Add My dictionaries';
	String get remove_dictionaries => 'Remove My dictionaries';
	String get select_dictionaries_to_use => 'Select dictionaries to add';
	String get add => 'Add';
	String get select_dictionaries_to_remove => 'Select dictionaries to remove';
	String get remove => 'Remove';
	String get set => 'Set';
	String get update_success => 'My Dictionaries Set';
	String get update_failed => 'Setting My Dictionaries Failed';
}

// Path: words
class _TranslationsWordsEn {
	_TranslationsWordsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get entry => 'Entry';
	String get meaning => 'Meaning';
}

// Path: <root>
class _TranslationsJa implements _TranslationsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsJa.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ja,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ja>.
	@override final TranslationMetadata<AppLocale, _TranslationsEn> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _TranslationsJa _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsLangJa lang = _TranslationsLangJa._(_root);
	@override late final _TranslationsCalendarsJa calendars = _TranslationsCalendarsJa._(_root);
	@override late final _TranslationsDictionaryMapsJa dictionaryMaps = _TranslationsDictionaryMapsJa._(_root);
	@override late final _TranslationsWordsJa words = _TranslationsWordsJa._(_root);
}

// Path: lang
class _TranslationsLangJa implements _TranslationsLangEn {
	_TranslationsLangJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get language_setting => '言語設定';
	@override String get auto_configure => '自動で設定する';
	@override String get undefined => '未定義';
	@override String get af => 'アフリカーンス語';
	@override String get sq => 'アルバニア語';
	@override String get am => 'アムハラ語';
	@override String get ar => 'アラビア文字';
	@override String get hy => 'アルメニア語';
	@override String get az => 'アゼルバイジャン語';
	@override String get eu => 'バスク語';
	@override String get be => 'ベラルーシ語';
	@override String get bn => 'ベンガル文字';
	@override String get bs => 'ボスニア語';
	@override String get bg => 'ブルガリア語';
	@override String get ca => 'カタロニア語';
	@override String get ceb => 'セブ語';
	@override String get zh_CN => '中国語（簡体）';
	@override String get zh => '中国語';
	@override String get zh_TW => '中国語（繁体）';
	@override String get co => 'コルシカ語';
	@override String get hr => 'クロアチア語';
	@override String get cs => 'チェコ語';
	@override String get da => 'デンマーク語';
	@override String get nl => 'オランダ語';
	@override String get en => '英語';
	@override String get eo => 'エスペラント語';
	@override String get et => 'エストニア語';
	@override String get fi => 'フィンランド語';
	@override String get fr => 'フランス語';
	@override String get fy => 'フリジア語';
	@override String get gl => 'ガリシア語';
	@override String get ka => 'グルジア語';
	@override String get de => 'ドイツ語';
	@override String get el => 'ギリシャ語';
	@override String get gu => 'グジャラト語';
	@override String get ht => 'クレオール語（ハイチ）';
	@override String get ha => 'ハウサ語';
	@override String get haw => 'ハワイ語';
	@override String get he => 'ヘブライ語';
	@override String get iw => 'ヘブライ語';
	@override String get hi => 'ヒンディー語';
	@override String get hmn => 'モン語';
	@override String get hu => 'ハンガリー語';
	@override String get Icelandic => 'アイスランド語';
	@override String get ig => 'イボ語';
	@override String get id => 'インドネシア語';
	@override String get ga => 'アイルランド語';
	@override String get it => 'イタリア語';
	@override String get ja => '日本語';
	@override String get jv => 'ジャワ語';
	@override String get kn => 'カンナダ語';
	@override String get kk => 'カザフ語';
	@override String get km => 'クメール語';
	@override String get rw => 'キニヤルワンダ語';
	@override String get ko => '韓国語';
	@override String get ku => 'クルド語';
	@override String get ky => 'キルギス語';
	@override String get lo => 'ラオ語';
	@override String get la => 'ラテン語';
	@override String get lv => 'ラトビア語';
	@override String get lt => 'リトアニア語';
	@override String get lb => 'ルクセンブルク語';
	@override String get mk => 'マケドニア語';
	@override String get mg => 'マラガシ語';
	@override String get ms => 'マレー語';
	@override String get ml => 'マラヤーラム文字';
	@override String get mt => 'マルタ語';
	@override String get mi => 'マオリ語';
	@override String get mr => 'マラーティー語';
	@override String get mn => 'モンゴル語';
	@override String get my => 'ミャンマー語（ビルマ語）';
	@override String get ne => 'ネパール語';
	@override String get no => 'ノルウェー語';
	@override String get ny => 'ニャンジャ語（チェワ語）';
	@override String get or => 'オリヤ語';
	@override String get ps => 'パシュト語';
	@override String get fa => 'ペルシャ語';
	@override String get pl => 'ポーランド語';
	@override String get pt => 'ポルトガル語（ポルトガル、ブラジル）';
	@override String get pa => 'パンジャブ語';
	@override String get ro => 'ルーマニア語';
	@override String get ru => 'ロシア語';
	@override String get sm => 'サモア語';
	@override String get gd => 'スコットランド ゲール語';
	@override String get sr => 'セルビア語';
	@override String get st => 'セソト語';
	@override String get sn => 'ショナ語';
	@override String get sd => 'シンド語';
	@override String get si => 'シンハラ語';
	@override String get sk => 'スロバキア語';
	@override String get sl => 'スロベニア語';
	@override String get so => 'ソマリ語';
	@override String get es => 'スペイン語';
	@override String get su => 'スンダ語';
	@override String get sw => 'スワヒリ語';
	@override String get sv => 'スウェーデン語';
	@override String get tl => 'タガログ語（フィリピン語）';
	@override String get tg => 'タジク語';
	@override String get ta => 'タミル語';
	@override String get tt => 'タタール語';
	@override String get te => 'テルグ語';
	@override String get th => 'タイ語';
	@override String get tr => 'トルコ語';
	@override String get tk => 'トルクメン語';
	@override String get uk => 'ウクライナ語';
	@override String get ur => 'ウルドゥー語';
	@override String get ug => 'ウイグル語';
	@override String get uz => 'ウズベク語';
	@override String get vi => 'ベトナム語';
	@override String get cy => 'ウェールズ語';
	@override String get xh => 'コーサ語';
	@override String get yi => 'イディッシュ語';
	@override String get yo => 'ヨルバ語';
	@override String get zu => 'ズールー語';
	@override String get af_ZA => 'アフリカーンス語（南アフリカ）';
	@override String get sq_AL => 'アルバニア語（アルバニア）';
	@override String get am_ET => 'アムハラ語（エチオピア）';
	@override String get ar_DZ => 'アラビア語（アルジェリア）';
	@override String get ar_BH => 'アラビア語（バーレーン）';
	@override String get ar_EG => 'アラビア語（エジプト）';
	@override String get ar_IQ => 'アラビア語（イラク）';
	@override String get ar_IL => 'アラビア語（イスラエル）';
	@override String get ar_JO => 'アラビア語（ヨルダン）';
	@override String get ar_KW => 'アラビア語（クウェート）';
	@override String get ar_LB => 'アラビア語（レバノン）';
	@override String get ar_MA => 'アラビア語（モロッコ）';
	@override String get ar_OM => 'アラビア語（オマーン）';
	@override String get ar_QA => 'アラビア語（カタール）';
	@override String get ar_SA => 'アラビア語（サウジアラビア）';
	@override String get ar_PS => 'アラビア語（パレスチナ国）';
	@override String get ar_TN => 'アラビア語（チュニジア）';
	@override String get ar_AE => 'アラビア語（アラブ首長国連邦）';
	@override String get ar_YE => 'アラビア語（イエメン）';
	@override String get hy_AM => 'アルメニア語（アルメニア）';
	@override String get az_AZ => 'アゼルバイジャン語（アゼルバイジャン）';
	@override String get eu_ES => 'バスク語（スペイン）';
	@override String get bn_BD => 'ベンガル語（バングラデシュ）';
	@override String get bn_IN => 'ベンガル語（インド）';
	@override String get bs_BA => 'ボスニア語（ボスニア ヘルツェゴビナ）';
	@override String get bg_BG => 'ブルガリア語（ブルガリア）';
	@override String get my_MM => 'ビルマ語（ミャンマー）';
	@override String get ca_ES => 'カタルーニャ語（スペイン）';
	@override String get yue_Hant_HK => '広東語（繁体字、香港）';
	@override String get cmn_Hans_CN => '中国語（簡体字、中国本土）';
	@override String get cmn_Hant_TW => '中国語（繁体字、台湾）';
	@override String get hr_HR => 'クロアチア語（クロアチア）';
	@override String get cs_CZ => 'チェコ語（チェコ共和国）';
	@override String get da_DK => 'デンマーク語（デンマーク）';
	@override String get nl_BE => 'オランダ語（ベルギー）';
	@override String get nl_NL => 'オランダ語（オランダ）';
	@override String get en_AU => '英語（オーストラリア）';
	@override String get en_CA => '英語（カナダ）';
	@override String get en_GH => '英語（ガーナ）';
	@override String get en_HK => '英語（香港）';
	@override String get en_IN => '英語（インド）';
	@override String get en_IE => '英語（アイルランド）';
	@override String get en_KE => '英語（ケニア）';
	@override String get en_NZ => '英語（ニュージーランド）';
	@override String get en_NG => '英語（ナイジェリア）';
	@override String get en_PK => '英語（パキスタン）';
	@override String get en_PH => '英語（フィリピン）';
	@override String get en_SG => '英語（シンガポール）';
	@override String get en_ZA => '英語（南アフリカ）';
	@override String get en_TZ => '英語（タンザニア）';
	@override String get en_GB => '英語（イギリス）';
	@override String get en_US => '英語（米国）';
	@override String get et_EE => 'エストニア語（エストニア）';
	@override String get fil_PH => 'フィリピン語（フィリピン）';
	@override String get fi_FI => 'フィンランド語（フィンランド）';
	@override String get fr_BE => 'フランス語（ベルギー）';
	@override String get fr_CA => 'フランス語（カナダ）';
	@override String get fr_FR => 'フランス語（フランス）';
	@override String get fr_CH => 'フランス語（スイス）';
	@override String get gl_ES => 'ガリシア語（スペイン）';
	@override String get ka_GE => 'ジョージア語（ジョージア）';
	@override String get de_AT => 'ドイツ語（オーストリア）';
	@override String get de_DE => 'ドイツ語（ドイツ）';
	@override String get de_CH => 'ドイツ語（スイス）';
	@override String get el_GR => 'ギリシャ語（ギリシャ）';
	@override String get gu_IN => 'グジャラト語（インド）';
	@override String get iw_IL => 'ヘブライ語（イスラエル）';
	@override String get hi_IN => 'ヒンディー語（インド）';
	@override String get hu_HU => 'ハンガリー語（ハンガリー）';
	@override String get is_IS => 'アイスランド語（アイスランド）';
	@override String get id_ID => 'インドネシア語（インドネシア）';
	@override String get it_IT => 'イタリア語（イタリア）';
	@override String get it_CH => 'イタリア語（スイス）';
	@override String get ja_JP => '日本語（日本）';
	@override String get jv_ID => 'ジャワ語（インドネシア）';
	@override String get kn_IN => 'カンナダ語（インド）';
	@override String get kk_KZ => 'カザフ語（カザフスタン）';
	@override String get km_KH => 'クメール語（カンボジア）';
	@override String get ko_KR => '韓国語（韓国）';
	@override String get lo_LA => 'ラオ語（ラオス）';
	@override String get lv_LV => 'ラトビア語（ラトビア）';
	@override String get lt_LT => 'リトアニア語（リトアニア）';
	@override String get mk_MK => 'マケドニア語（北マケドニア）';
	@override String get ms_MY => 'マレー語（マレーシア）';
	@override String get ml_IN => 'マラヤーラム語（インド）';
	@override String get mr_IN => 'マラーティー語（インド）';
	@override String get mn_MN => 'モンゴル語（モンゴル）';
	@override String get ne_NP => 'ネパール語（ネパール）';
	@override String get no_NO => 'ノルウェー語（ノルウェー）';
	@override String get fa_IR => 'ペルシャ語（イラン）';
	@override String get pl_PL => 'ポーランド語（ポーランド）';
	@override String get pt_BR => 'ポルトガル語（ブラジル）';
	@override String get pt_PT => 'ポルトガル語（ポルトガル）';
	@override String get pa_Guru_IN => 'パンジャブ語（グルムキー、インド）';
	@override String get ro_RO => 'ルーマニア語（ルーマニア）';
	@override String get ru_RU => 'ロシア語（ロシア）';
	@override String get sr_RS => 'セルビア語（セルビア）';
	@override String get si_LK => 'シンハラ語（スリランカ）';
	@override String get sk_SK => 'スロバキア語（スロバキア）';
	@override String get sl_SI => 'スロベニア語（スロベニア）';
	@override String get es_AR => 'スペイン語（アルゼンチン）';
	@override String get es_BO => 'スペイン語（ボリビア）';
	@override String get es_CL => 'スペイン語（チリ）';
	@override String get es_CO => 'スペイン語（コロンビア）';
	@override String get es_CR => 'スペイン語（コスタリカ）';
	@override String get es_DO => 'スペイン語（ドミニカ共和国）';
	@override String get es_EC => 'スペイン語（エクアドル）';
	@override String get es_SV => 'スペイン語（エルサルバドル）';
	@override String get es_GT => 'スペイン語（グアテマラ）';
	@override String get es_HN => 'スペイン語（ホンジュラス）';
	@override String get es_MX => 'スペイン語（メキシコ）';
	@override String get es_NI => 'スペイン語（ニカラグア）';
	@override String get es_PA => 'スペイン語（パナマ）';
	@override String get es_PY => 'スペイン語（パラグアイ）';
	@override String get es_PE => 'スペイン語（ペルー）';
	@override String get es_PR => 'スペイン語（プエルトリコ）';
	@override String get es_ES => 'スペイン語（スペイン）';
	@override String get es_US => 'スペイン語（米国）';
	@override String get es_UY => 'スペイン語（ウルグアイ）';
	@override String get es_VE => 'スペイン語（ベネズエラ）';
	@override String get su_ID => 'スンダ語（インドネシア）';
	@override String get sw_KE => 'スワヒリ語（ケニア）';
	@override String get sw_TZ => 'スワヒリ語（タンザニア）';
	@override String get sv_SE => 'スウェーデン語（スウェーデン）';
	@override String get ta_IN => 'タミル語（インド）';
	@override String get ta_MY => 'タミル語（マレーシア）';
	@override String get ta_SG => 'タミル語（シンガポール）';
	@override String get ta_LK => 'タミル語（スリランカ）';
	@override String get te_IN => 'テルグ語（インド）';
	@override String get th_TH => 'タイ語（タイ）';
	@override String get tr_TR => 'トルコ語（トルコ）';
	@override String get uk_UA => 'ウクライナ語（ウクライナ）';
	@override String get ur_IN => 'ウルドゥー語（インド）';
	@override String get ur_PK => 'ウルドゥー語（パキスタン）';
	@override String get uz_UZ => 'ウズベク語（ウズベキスタン）';
	@override String get vi_VN => 'ベトナム語（ベトナム）';
	@override String get zu_ZA => 'ズールー語（南アフリカ）';
}

// Path: calendars
class _TranslationsCalendarsJa implements _TranslationsCalendarsEn {
	_TranslationsCalendarsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get sunday => '日';
	@override String get monday => '月';
	@override String get tuesday => '火';
	@override String get wednesday => '水';
	@override String get thursday => '木';
	@override String get friday => '金';
	@override String get saturday => '土';
	@override String get prev => '前';
	@override String get next => '次';
	@override String get prevYear => '前年';
	@override String get nextYear => '翌年';
	@override String get today => '今日';
	@override String get month => '月';
	@override String get week => '週';
	@override String get day => '日';
	@override String answers({required Object count}) => '${count}問';
	@override String get reviewed => '復習了';
}

// Path: dictionaryMaps
class _TranslationsDictionaryMapsJa implements _TranslationsDictionaryMapsEn {
	_TranslationsDictionaryMapsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get set_dictionaries => 'My辞書を設定する';
	@override String get add_dictionaries => 'My辞書を追加する';
	@override String get remove_dictionaries => 'My辞書を削除する';
	@override String get select_dictionaries_to_use => '追加する辞書を選択してください';
	@override String get add => '追加する';
	@override String get select_dictionaries_to_remove => '削除する辞書を選択してください';
	@override String get remove => '削除する';
	@override String get set => '設定する';
	@override String get update_success => 'My辞書を設定しました。';
	@override String get update_failed => 'My辞書が設定できませんでした。';
}

// Path: words
class _TranslationsWordsJa implements _TranslationsWordsEn {
	_TranslationsWordsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get entry => '項目';
	@override String get meaning => '意味';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _TranslationsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'lang.language_setting': return 'Language';
			case 'lang.auto_configure': return 'Auto_configure';
			case 'lang.undefined': return 'Undefined';
			case 'lang.af': return 'Afrikaans';
			case 'lang.sq': return 'Albanian';
			case 'lang.am': return 'Amharic';
			case 'lang.ar': return 'Arabic';
			case 'lang.hy': return 'Armenian';
			case 'lang.az': return 'Azerbaijani';
			case 'lang.eu': return 'Basque';
			case 'lang.be': return 'Belarusian';
			case 'lang.bn': return 'Bengali';
			case 'lang.bs': return 'Bosnian';
			case 'lang.bg': return 'Bulgarian';
			case 'lang.ca': return 'Catalan';
			case 'lang.ceb': return 'Cebuano';
			case 'lang.zh_CN': return 'Chinese (Simplified)';
			case 'lang.zh': return 'Chinese';
			case 'lang.zh_TW': return 'Chinese (Traditional)';
			case 'lang.co': return 'Corsican';
			case 'lang.hr': return 'Croatian';
			case 'lang.cs': return 'Czech';
			case 'lang.da': return 'Danish';
			case 'lang.nl': return 'Dutch';
			case 'lang.en': return 'English';
			case 'lang.eo': return 'Esperanto';
			case 'lang.et': return 'Estonian';
			case 'lang.fi': return 'Finnish';
			case 'lang.fr': return 'French';
			case 'lang.fy': return 'Frisian';
			case 'lang.gl': return 'Galician';
			case 'lang.ka': return 'Georgian';
			case 'lang.de': return 'German';
			case 'lang.el': return 'Greek';
			case 'lang.gu': return 'Gujarati';
			case 'lang.ht': return 'Haitian Creole';
			case 'lang.ha': return 'Hausa';
			case 'lang.haw': return 'Hawaiian';
			case 'lang.he': return 'Hebrew';
			case 'lang.iw': return 'Hebrew';
			case 'lang.hi': return 'Hindi';
			case 'lang.hmn': return 'Hmong';
			case 'lang.hu': return 'Hungarian';
			case 'lang.Icelandic': return 'Icelandic';
			case 'lang.ig': return 'Igbo';
			case 'lang.id': return 'Indonesian';
			case 'lang.ga': return 'Irish';
			case 'lang.it': return 'Italian';
			case 'lang.ja': return 'Japanese';
			case 'lang.jv': return 'Javanese';
			case 'lang.kn': return 'Kannada';
			case 'lang.kk': return 'Kazakh';
			case 'lang.km': return 'Khmer';
			case 'lang.rw': return 'Kinyarwanda';
			case 'lang.ko': return 'Korean';
			case 'lang.ku': return 'Kurdish';
			case 'lang.ky': return 'Kyrgyz';
			case 'lang.lo': return 'Lao';
			case 'lang.la': return 'Latin';
			case 'lang.lv': return 'Latvian';
			case 'lang.lt': return 'Lithuanian';
			case 'lang.lb': return 'Luxembourgish';
			case 'lang.mk': return 'Macedonian';
			case 'lang.mg': return 'Malagasy';
			case 'lang.ms': return 'Malay';
			case 'lang.ml': return 'Malayalam';
			case 'lang.mt': return 'Maltese';
			case 'lang.mi': return 'Maori';
			case 'lang.mr': return 'Marathi';
			case 'lang.mn': return 'Mongolian';
			case 'lang.my': return 'Myanmar (Burmese)';
			case 'lang.ne': return 'Nepali';
			case 'lang.no': return 'Norwegian';
			case 'lang.ny': return 'Nyanja (Chichewa)';
			case 'lang.or': return 'Odia (Oriya)';
			case 'lang.ps': return 'Pashto';
			case 'lang.fa': return 'Persian';
			case 'lang.pl': return 'Polish';
			case 'lang.pt': return 'Portuguese (Portugal, Brazil)';
			case 'lang.pa': return 'Punjabi';
			case 'lang.ro': return 'Romanian';
			case 'lang.ru': return 'Russian';
			case 'lang.sm': return 'Samoan';
			case 'lang.gd': return 'Scots Gaelic';
			case 'lang.sr': return 'Serbian';
			case 'lang.st': return 'Sesotho';
			case 'lang.sn': return 'Shona';
			case 'lang.sd': return 'Sindhi';
			case 'lang.si': return 'Sinhala (Sinhalese)';
			case 'lang.sk': return 'Slovak';
			case 'lang.sl': return 'Slovenian';
			case 'lang.so': return 'Somali';
			case 'lang.es': return 'Spanish';
			case 'lang.su': return 'Sundanese';
			case 'lang.sw': return 'Swahili';
			case 'lang.sv': return 'Swedish';
			case 'lang.tl': return 'Tagalog (Filipino)';
			case 'lang.tg': return 'Tajik';
			case 'lang.ta': return 'Tamil';
			case 'lang.tt': return 'Tatar';
			case 'lang.te': return 'Telugu';
			case 'lang.th': return 'Thai';
			case 'lang.tr': return 'Turkish';
			case 'lang.tk': return 'Turkmen';
			case 'lang.uk': return 'Ukrainian';
			case 'lang.ur': return 'Urdu';
			case 'lang.ug': return 'Uyghur';
			case 'lang.uz': return 'Uzbek';
			case 'lang.vi': return 'Vietnamese';
			case 'lang.cy': return 'Welsh';
			case 'lang.xh': return 'Xhosa';
			case 'lang.yi': return 'Yiddish';
			case 'lang.yo': return 'Yoruba';
			case 'lang.zu': return 'Zulu';
			case 'lang.af_ZA': return 'Afrikaans (South Africa)';
			case 'lang.sq_AL': return 'Albanian (Albania)';
			case 'lang.am_ET': return 'Amharic (Ethiopia)';
			case 'lang.ar_DZ': return 'Arabic (Algeria)';
			case 'lang.ar_BH': return 'Arabic (Bahrain)';
			case 'lang.ar_EG': return 'Arabic (Egypt)';
			case 'lang.ar_IQ': return 'Arabic (Iraq)';
			case 'lang.ar_IL': return 'Arabic (Israel)';
			case 'lang.ar_JO': return 'Arabic (Jordan)';
			case 'lang.ar_KW': return 'Arabic (Kuwait)';
			case 'lang.ar_LB': return 'Arabic (Lebanon)';
			case 'lang.ar_MA': return 'Arabic (Morocco)';
			case 'lang.ar_OM': return 'Arabic (Oman)';
			case 'lang.ar_QA': return 'Arabic (Qatar)';
			case 'lang.ar_SA': return 'Arabic (Saudi Arabia)';
			case 'lang.ar_PS': return 'Arabic (State of Palestine)';
			case 'lang.ar_TN': return 'Arabic (Tunisia)';
			case 'lang.ar_AE': return 'Arabic (United Arab Emirates)';
			case 'lang.ar_YE': return 'Arabic (Yemen)';
			case 'lang.hy_AM': return 'Armenian (Armenia)';
			case 'lang.az_AZ': return 'Azerbaijani (Azerbaijan)';
			case 'lang.eu_ES': return 'Basque (Spain)';
			case 'lang.bn_BD': return 'Bengali (Bangladesh)';
			case 'lang.bn_IN': return 'Bengali (India)';
			case 'lang.bs_BA': return 'Bosnian (Bosnia and Herzegovina)';
			case 'lang.bg_BG': return 'Bulgarian (Bulgaria)';
			case 'lang.my_MM': return 'Burmese (Myanmar)';
			case 'lang.ca_ES': return 'Catalan (Spain)';
			case 'lang.yue_Hant_HK': return 'Chinese, Cantonese (Traditional Hong Kong)';
			case 'lang.cmn_Hans_CN': return 'Chinese, Mandarin (Simplified, China)';
			case 'lang.cmn_Hant_TW': return 'Chinese, Mandarin (Traditional, Taiwan)';
			case 'lang.hr_HR': return 'Croatian (Croatia)';
			case 'lang.cs_CZ': return 'Czech (Czech Republic)';
			case 'lang.da_DK': return 'Danish (Denmark)';
			case 'lang.nl_BE': return 'Dutch (Belgium)';
			case 'lang.nl_NL': return 'Dutch (Netherlands)';
			case 'lang.en_AU': return 'English (Australia)';
			case 'lang.en_CA': return 'English (Canada)';
			case 'lang.en_GH': return 'English (Ghana)';
			case 'lang.en_HK': return 'English (Hong Kong)';
			case 'lang.en_IN': return 'English (India)';
			case 'lang.en_IE': return 'English (Ireland)';
			case 'lang.en_KE': return 'English (Kenya)';
			case 'lang.en_NZ': return 'English (New Zealand)';
			case 'lang.en_NG': return 'English (Nigeria)';
			case 'lang.en_PK': return 'English (Pakistan)';
			case 'lang.en_PH': return 'English (Philippines)';
			case 'lang.en_SG': return 'English (Singapore)';
			case 'lang.en_ZA': return 'English (South Africa)';
			case 'lang.en_TZ': return 'English (Tanzania)';
			case 'lang.en_GB': return 'English (United Kingdom)';
			case 'lang.en_US': return 'English (United States)';
			case 'lang.et_EE': return 'Estonian (Estonia)';
			case 'lang.fil_PH': return 'Filipino (Philippines)';
			case 'lang.fi_FI': return 'Finnish (Finland)';
			case 'lang.fr_BE': return 'French (Belgium)';
			case 'lang.fr_CA': return 'French (Canada)';
			case 'lang.fr_FR': return 'French (France)';
			case 'lang.fr_CH': return 'French (Switzerland)';
			case 'lang.gl_ES': return 'Galician (Spain)';
			case 'lang.ka_GE': return 'Georgian (Georgia)';
			case 'lang.de_AT': return 'German (Austria)';
			case 'lang.de_DE': return 'German (Germany)';
			case 'lang.de_CH': return 'German (Switzerland)';
			case 'lang.el_GR': return 'Greek (Greece)';
			case 'lang.gu_IN': return 'Gujarati (India)';
			case 'lang.iw_IL': return 'Hebrew (Israel)';
			case 'lang.hi_IN': return 'Hindi (India)';
			case 'lang.hu_HU': return 'Hungarian (Hungary)';
			case 'lang.is_IS': return 'Icelandic (Iceland)';
			case 'lang.id_ID': return 'Indonesian (Indonesia)';
			case 'lang.it_IT': return 'Italian (Italy)';
			case 'lang.it_CH': return 'Italian (Switzerland)';
			case 'lang.ja_JP': return 'Japanese (Japan)';
			case 'lang.jv_ID': return 'Javanese (Indonesia)';
			case 'lang.kn_IN': return 'Kannada (India)';
			case 'lang.kk_KZ': return 'Kazakh (Kazakhstan)';
			case 'lang.km_KH': return 'Khmer (Cambodia)';
			case 'lang.ko_KR': return 'Korean (South Korea)';
			case 'lang.lo_LA': return 'Lao (Laos)';
			case 'lang.lv_LV': return 'Latvian (Latvia)';
			case 'lang.lt_LT': return 'Lithuanian (Lithuania)';
			case 'lang.mk_MK': return 'Macedonian (North Macedonia)';
			case 'lang.ms_MY': return 'Malay (Malaysia)';
			case 'lang.ml_IN': return 'Malayalam (India)';
			case 'lang.mr_IN': return 'Marathi (India)';
			case 'lang.mn_MN': return 'Mongolian (Mongolia)';
			case 'lang.ne_NP': return 'Nepali (Nepal)';
			case 'lang.no_NO': return 'Norwegian Bokmål (Norway)';
			case 'lang.fa_IR': return 'Persian (Iran)';
			case 'lang.pl_PL': return 'Polish (Poland)';
			case 'lang.pt_BR': return 'Portuguese (Brazil)';
			case 'lang.pt_PT': return 'Portuguese (Portugal)';
			case 'lang.pa_Guru_IN': return 'Punjabi (Gurmukhi India)';
			case 'lang.ro_RO': return 'Romanian (Romania)';
			case 'lang.ru_RU': return 'Russian (Russia)';
			case 'lang.sr_RS': return 'Serbian (Serbia)';
			case 'lang.si_LK': return 'Sinhala (Sri Lanka)';
			case 'lang.sk_SK': return 'Slovak (Slovakia)';
			case 'lang.sl_SI': return 'Slovenian (Slovenia)';
			case 'lang.es_AR': return 'Spanish (Argentina)';
			case 'lang.es_BO': return 'Spanish (Bolivia)';
			case 'lang.es_CL': return 'Spanish (Chile)';
			case 'lang.es_CO': return 'Spanish (Colombia)';
			case 'lang.es_CR': return 'Spanish (Costa Rica)';
			case 'lang.es_DO': return 'Spanish (Dominican Republic)';
			case 'lang.es_EC': return 'Spanish (Ecuador)';
			case 'lang.es_SV': return 'Spanish (El Salvador)';
			case 'lang.es_GT': return 'Spanish (Guatemala)';
			case 'lang.es_HN': return 'Spanish (Honduras)';
			case 'lang.es_MX': return 'Spanish (Mexico)';
			case 'lang.es_NI': return 'Spanish (Nicaragua)';
			case 'lang.es_PA': return 'Spanish (Panama)';
			case 'lang.es_PY': return 'Spanish (Paraguay)';
			case 'lang.es_PE': return 'Spanish (Peru)';
			case 'lang.es_PR': return 'Spanish (Puerto Rico)';
			case 'lang.es_ES': return 'Spanish (Spain)';
			case 'lang.es_US': return 'Spanish (United States)';
			case 'lang.es_UY': return 'Spanish (Uruguay)';
			case 'lang.es_VE': return 'Spanish (Venezuela)';
			case 'lang.su_ID': return 'Sundanese (Indonesia)';
			case 'lang.sw_KE': return 'Swahili (Kenya)';
			case 'lang.sw_TZ': return 'Swahili (Tanzania)';
			case 'lang.sv_SE': return 'Swedish (Sweden)';
			case 'lang.ta_IN': return 'Tamil (India)';
			case 'lang.ta_MY': return 'Tamil (Malaysia)';
			case 'lang.ta_SG': return 'Tamil (Singapore)';
			case 'lang.ta_LK': return 'Tamil (Sri Lanka)';
			case 'lang.te_IN': return 'Telugu (India)';
			case 'lang.th_TH': return 'Thai (Thailand)';
			case 'lang.tr_TR': return 'Turkish (Turkey)';
			case 'lang.uk_UA': return 'Ukrainian (Ukraine)';
			case 'lang.ur_IN': return 'Urdu (India)';
			case 'lang.ur_PK': return 'Urdu (Pakistan)';
			case 'lang.uz_UZ': return 'Uzbek (Uzbekistan)';
			case 'lang.vi_VN': return 'Vietnamese (Vietnam)';
			case 'lang.zu_ZA': return 'Zulu (South Africa)';
			case 'calendars.sunday': return 'Sun.';
			case 'calendars.monday': return 'Mon.';
			case 'calendars.tuesday': return 'Tue.';
			case 'calendars.wednesday': return 'Wed.';
			case 'calendars.thursday': return 'Th.';
			case 'calendars.friday': return 'Fri.';
			case 'calendars.saturday': return 'Sat.';
			case 'calendars.prev': return 'Prev';
			case 'calendars.next': return 'Next';
			case 'calendars.prevYear': return 'PrevYear';
			case 'calendars.nextYear': return 'NextYear';
			case 'calendars.today': return 'Today';
			case 'calendars.month': return 'Month';
			case 'calendars.week': return 'Week';
			case 'calendars.day': return 'Day';
			case 'calendars.answers': return ({required Object count}) => '${count}';
			case 'calendars.reviewed': return 'Review';
			case 'dictionaryMaps.set_dictionaries': return 'Set My dictionaries';
			case 'dictionaryMaps.add_dictionaries': return 'Add My dictionaries';
			case 'dictionaryMaps.remove_dictionaries': return 'Remove My dictionaries';
			case 'dictionaryMaps.select_dictionaries_to_use': return 'Select dictionaries to add';
			case 'dictionaryMaps.add': return 'Add';
			case 'dictionaryMaps.select_dictionaries_to_remove': return 'Select dictionaries to remove';
			case 'dictionaryMaps.remove': return 'Remove';
			case 'dictionaryMaps.set': return 'Set';
			case 'dictionaryMaps.update_success': return 'My Dictionaries Set';
			case 'dictionaryMaps.update_failed': return 'Setting My Dictionaries Failed';
			case 'words.entry': return 'Entry';
			case 'words.meaning': return 'Meaning';
			default: return null;
		}
	}
}

extension on _TranslationsJa {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'lang.language_setting': return '言語設定';
			case 'lang.auto_configure': return '自動で設定する';
			case 'lang.undefined': return '未定義';
			case 'lang.af': return 'アフリカーンス語';
			case 'lang.sq': return 'アルバニア語';
			case 'lang.am': return 'アムハラ語';
			case 'lang.ar': return 'アラビア文字';
			case 'lang.hy': return 'アルメニア語';
			case 'lang.az': return 'アゼルバイジャン語';
			case 'lang.eu': return 'バスク語';
			case 'lang.be': return 'ベラルーシ語';
			case 'lang.bn': return 'ベンガル文字';
			case 'lang.bs': return 'ボスニア語';
			case 'lang.bg': return 'ブルガリア語';
			case 'lang.ca': return 'カタロニア語';
			case 'lang.ceb': return 'セブ語';
			case 'lang.zh_CN': return '中国語（簡体）';
			case 'lang.zh': return '中国語';
			case 'lang.zh_TW': return '中国語（繁体）';
			case 'lang.co': return 'コルシカ語';
			case 'lang.hr': return 'クロアチア語';
			case 'lang.cs': return 'チェコ語';
			case 'lang.da': return 'デンマーク語';
			case 'lang.nl': return 'オランダ語';
			case 'lang.en': return '英語';
			case 'lang.eo': return 'エスペラント語';
			case 'lang.et': return 'エストニア語';
			case 'lang.fi': return 'フィンランド語';
			case 'lang.fr': return 'フランス語';
			case 'lang.fy': return 'フリジア語';
			case 'lang.gl': return 'ガリシア語';
			case 'lang.ka': return 'グルジア語';
			case 'lang.de': return 'ドイツ語';
			case 'lang.el': return 'ギリシャ語';
			case 'lang.gu': return 'グジャラト語';
			case 'lang.ht': return 'クレオール語（ハイチ）';
			case 'lang.ha': return 'ハウサ語';
			case 'lang.haw': return 'ハワイ語';
			case 'lang.he': return 'ヘブライ語';
			case 'lang.iw': return 'ヘブライ語';
			case 'lang.hi': return 'ヒンディー語';
			case 'lang.hmn': return 'モン語';
			case 'lang.hu': return 'ハンガリー語';
			case 'lang.Icelandic': return 'アイスランド語';
			case 'lang.ig': return 'イボ語';
			case 'lang.id': return 'インドネシア語';
			case 'lang.ga': return 'アイルランド語';
			case 'lang.it': return 'イタリア語';
			case 'lang.ja': return '日本語';
			case 'lang.jv': return 'ジャワ語';
			case 'lang.kn': return 'カンナダ語';
			case 'lang.kk': return 'カザフ語';
			case 'lang.km': return 'クメール語';
			case 'lang.rw': return 'キニヤルワンダ語';
			case 'lang.ko': return '韓国語';
			case 'lang.ku': return 'クルド語';
			case 'lang.ky': return 'キルギス語';
			case 'lang.lo': return 'ラオ語';
			case 'lang.la': return 'ラテン語';
			case 'lang.lv': return 'ラトビア語';
			case 'lang.lt': return 'リトアニア語';
			case 'lang.lb': return 'ルクセンブルク語';
			case 'lang.mk': return 'マケドニア語';
			case 'lang.mg': return 'マラガシ語';
			case 'lang.ms': return 'マレー語';
			case 'lang.ml': return 'マラヤーラム文字';
			case 'lang.mt': return 'マルタ語';
			case 'lang.mi': return 'マオリ語';
			case 'lang.mr': return 'マラーティー語';
			case 'lang.mn': return 'モンゴル語';
			case 'lang.my': return 'ミャンマー語（ビルマ語）';
			case 'lang.ne': return 'ネパール語';
			case 'lang.no': return 'ノルウェー語';
			case 'lang.ny': return 'ニャンジャ語（チェワ語）';
			case 'lang.or': return 'オリヤ語';
			case 'lang.ps': return 'パシュト語';
			case 'lang.fa': return 'ペルシャ語';
			case 'lang.pl': return 'ポーランド語';
			case 'lang.pt': return 'ポルトガル語（ポルトガル、ブラジル）';
			case 'lang.pa': return 'パンジャブ語';
			case 'lang.ro': return 'ルーマニア語';
			case 'lang.ru': return 'ロシア語';
			case 'lang.sm': return 'サモア語';
			case 'lang.gd': return 'スコットランド ゲール語';
			case 'lang.sr': return 'セルビア語';
			case 'lang.st': return 'セソト語';
			case 'lang.sn': return 'ショナ語';
			case 'lang.sd': return 'シンド語';
			case 'lang.si': return 'シンハラ語';
			case 'lang.sk': return 'スロバキア語';
			case 'lang.sl': return 'スロベニア語';
			case 'lang.so': return 'ソマリ語';
			case 'lang.es': return 'スペイン語';
			case 'lang.su': return 'スンダ語';
			case 'lang.sw': return 'スワヒリ語';
			case 'lang.sv': return 'スウェーデン語';
			case 'lang.tl': return 'タガログ語（フィリピン語）';
			case 'lang.tg': return 'タジク語';
			case 'lang.ta': return 'タミル語';
			case 'lang.tt': return 'タタール語';
			case 'lang.te': return 'テルグ語';
			case 'lang.th': return 'タイ語';
			case 'lang.tr': return 'トルコ語';
			case 'lang.tk': return 'トルクメン語';
			case 'lang.uk': return 'ウクライナ語';
			case 'lang.ur': return 'ウルドゥー語';
			case 'lang.ug': return 'ウイグル語';
			case 'lang.uz': return 'ウズベク語';
			case 'lang.vi': return 'ベトナム語';
			case 'lang.cy': return 'ウェールズ語';
			case 'lang.xh': return 'コーサ語';
			case 'lang.yi': return 'イディッシュ語';
			case 'lang.yo': return 'ヨルバ語';
			case 'lang.zu': return 'ズールー語';
			case 'lang.af_ZA': return 'アフリカーンス語（南アフリカ）';
			case 'lang.sq_AL': return 'アルバニア語（アルバニア）';
			case 'lang.am_ET': return 'アムハラ語（エチオピア）';
			case 'lang.ar_DZ': return 'アラビア語（アルジェリア）';
			case 'lang.ar_BH': return 'アラビア語（バーレーン）';
			case 'lang.ar_EG': return 'アラビア語（エジプト）';
			case 'lang.ar_IQ': return 'アラビア語（イラク）';
			case 'lang.ar_IL': return 'アラビア語（イスラエル）';
			case 'lang.ar_JO': return 'アラビア語（ヨルダン）';
			case 'lang.ar_KW': return 'アラビア語（クウェート）';
			case 'lang.ar_LB': return 'アラビア語（レバノン）';
			case 'lang.ar_MA': return 'アラビア語（モロッコ）';
			case 'lang.ar_OM': return 'アラビア語（オマーン）';
			case 'lang.ar_QA': return 'アラビア語（カタール）';
			case 'lang.ar_SA': return 'アラビア語（サウジアラビア）';
			case 'lang.ar_PS': return 'アラビア語（パレスチナ国）';
			case 'lang.ar_TN': return 'アラビア語（チュニジア）';
			case 'lang.ar_AE': return 'アラビア語（アラブ首長国連邦）';
			case 'lang.ar_YE': return 'アラビア語（イエメン）';
			case 'lang.hy_AM': return 'アルメニア語（アルメニア）';
			case 'lang.az_AZ': return 'アゼルバイジャン語（アゼルバイジャン）';
			case 'lang.eu_ES': return 'バスク語（スペイン）';
			case 'lang.bn_BD': return 'ベンガル語（バングラデシュ）';
			case 'lang.bn_IN': return 'ベンガル語（インド）';
			case 'lang.bs_BA': return 'ボスニア語（ボスニア ヘルツェゴビナ）';
			case 'lang.bg_BG': return 'ブルガリア語（ブルガリア）';
			case 'lang.my_MM': return 'ビルマ語（ミャンマー）';
			case 'lang.ca_ES': return 'カタルーニャ語（スペイン）';
			case 'lang.yue_Hant_HK': return '広東語（繁体字、香港）';
			case 'lang.cmn_Hans_CN': return '中国語（簡体字、中国本土）';
			case 'lang.cmn_Hant_TW': return '中国語（繁体字、台湾）';
			case 'lang.hr_HR': return 'クロアチア語（クロアチア）';
			case 'lang.cs_CZ': return 'チェコ語（チェコ共和国）';
			case 'lang.da_DK': return 'デンマーク語（デンマーク）';
			case 'lang.nl_BE': return 'オランダ語（ベルギー）';
			case 'lang.nl_NL': return 'オランダ語（オランダ）';
			case 'lang.en_AU': return '英語（オーストラリア）';
			case 'lang.en_CA': return '英語（カナダ）';
			case 'lang.en_GH': return '英語（ガーナ）';
			case 'lang.en_HK': return '英語（香港）';
			case 'lang.en_IN': return '英語（インド）';
			case 'lang.en_IE': return '英語（アイルランド）';
			case 'lang.en_KE': return '英語（ケニア）';
			case 'lang.en_NZ': return '英語（ニュージーランド）';
			case 'lang.en_NG': return '英語（ナイジェリア）';
			case 'lang.en_PK': return '英語（パキスタン）';
			case 'lang.en_PH': return '英語（フィリピン）';
			case 'lang.en_SG': return '英語（シンガポール）';
			case 'lang.en_ZA': return '英語（南アフリカ）';
			case 'lang.en_TZ': return '英語（タンザニア）';
			case 'lang.en_GB': return '英語（イギリス）';
			case 'lang.en_US': return '英語（米国）';
			case 'lang.et_EE': return 'エストニア語（エストニア）';
			case 'lang.fil_PH': return 'フィリピン語（フィリピン）';
			case 'lang.fi_FI': return 'フィンランド語（フィンランド）';
			case 'lang.fr_BE': return 'フランス語（ベルギー）';
			case 'lang.fr_CA': return 'フランス語（カナダ）';
			case 'lang.fr_FR': return 'フランス語（フランス）';
			case 'lang.fr_CH': return 'フランス語（スイス）';
			case 'lang.gl_ES': return 'ガリシア語（スペイン）';
			case 'lang.ka_GE': return 'ジョージア語（ジョージア）';
			case 'lang.de_AT': return 'ドイツ語（オーストリア）';
			case 'lang.de_DE': return 'ドイツ語（ドイツ）';
			case 'lang.de_CH': return 'ドイツ語（スイス）';
			case 'lang.el_GR': return 'ギリシャ語（ギリシャ）';
			case 'lang.gu_IN': return 'グジャラト語（インド）';
			case 'lang.iw_IL': return 'ヘブライ語（イスラエル）';
			case 'lang.hi_IN': return 'ヒンディー語（インド）';
			case 'lang.hu_HU': return 'ハンガリー語（ハンガリー）';
			case 'lang.is_IS': return 'アイスランド語（アイスランド）';
			case 'lang.id_ID': return 'インドネシア語（インドネシア）';
			case 'lang.it_IT': return 'イタリア語（イタリア）';
			case 'lang.it_CH': return 'イタリア語（スイス）';
			case 'lang.ja_JP': return '日本語（日本）';
			case 'lang.jv_ID': return 'ジャワ語（インドネシア）';
			case 'lang.kn_IN': return 'カンナダ語（インド）';
			case 'lang.kk_KZ': return 'カザフ語（カザフスタン）';
			case 'lang.km_KH': return 'クメール語（カンボジア）';
			case 'lang.ko_KR': return '韓国語（韓国）';
			case 'lang.lo_LA': return 'ラオ語（ラオス）';
			case 'lang.lv_LV': return 'ラトビア語（ラトビア）';
			case 'lang.lt_LT': return 'リトアニア語（リトアニア）';
			case 'lang.mk_MK': return 'マケドニア語（北マケドニア）';
			case 'lang.ms_MY': return 'マレー語（マレーシア）';
			case 'lang.ml_IN': return 'マラヤーラム語（インド）';
			case 'lang.mr_IN': return 'マラーティー語（インド）';
			case 'lang.mn_MN': return 'モンゴル語（モンゴル）';
			case 'lang.ne_NP': return 'ネパール語（ネパール）';
			case 'lang.no_NO': return 'ノルウェー語（ノルウェー）';
			case 'lang.fa_IR': return 'ペルシャ語（イラン）';
			case 'lang.pl_PL': return 'ポーランド語（ポーランド）';
			case 'lang.pt_BR': return 'ポルトガル語（ブラジル）';
			case 'lang.pt_PT': return 'ポルトガル語（ポルトガル）';
			case 'lang.pa_Guru_IN': return 'パンジャブ語（グルムキー、インド）';
			case 'lang.ro_RO': return 'ルーマニア語（ルーマニア）';
			case 'lang.ru_RU': return 'ロシア語（ロシア）';
			case 'lang.sr_RS': return 'セルビア語（セルビア）';
			case 'lang.si_LK': return 'シンハラ語（スリランカ）';
			case 'lang.sk_SK': return 'スロバキア語（スロバキア）';
			case 'lang.sl_SI': return 'スロベニア語（スロベニア）';
			case 'lang.es_AR': return 'スペイン語（アルゼンチン）';
			case 'lang.es_BO': return 'スペイン語（ボリビア）';
			case 'lang.es_CL': return 'スペイン語（チリ）';
			case 'lang.es_CO': return 'スペイン語（コロンビア）';
			case 'lang.es_CR': return 'スペイン語（コスタリカ）';
			case 'lang.es_DO': return 'スペイン語（ドミニカ共和国）';
			case 'lang.es_EC': return 'スペイン語（エクアドル）';
			case 'lang.es_SV': return 'スペイン語（エルサルバドル）';
			case 'lang.es_GT': return 'スペイン語（グアテマラ）';
			case 'lang.es_HN': return 'スペイン語（ホンジュラス）';
			case 'lang.es_MX': return 'スペイン語（メキシコ）';
			case 'lang.es_NI': return 'スペイン語（ニカラグア）';
			case 'lang.es_PA': return 'スペイン語（パナマ）';
			case 'lang.es_PY': return 'スペイン語（パラグアイ）';
			case 'lang.es_PE': return 'スペイン語（ペルー）';
			case 'lang.es_PR': return 'スペイン語（プエルトリコ）';
			case 'lang.es_ES': return 'スペイン語（スペイン）';
			case 'lang.es_US': return 'スペイン語（米国）';
			case 'lang.es_UY': return 'スペイン語（ウルグアイ）';
			case 'lang.es_VE': return 'スペイン語（ベネズエラ）';
			case 'lang.su_ID': return 'スンダ語（インドネシア）';
			case 'lang.sw_KE': return 'スワヒリ語（ケニア）';
			case 'lang.sw_TZ': return 'スワヒリ語（タンザニア）';
			case 'lang.sv_SE': return 'スウェーデン語（スウェーデン）';
			case 'lang.ta_IN': return 'タミル語（インド）';
			case 'lang.ta_MY': return 'タミル語（マレーシア）';
			case 'lang.ta_SG': return 'タミル語（シンガポール）';
			case 'lang.ta_LK': return 'タミル語（スリランカ）';
			case 'lang.te_IN': return 'テルグ語（インド）';
			case 'lang.th_TH': return 'タイ語（タイ）';
			case 'lang.tr_TR': return 'トルコ語（トルコ）';
			case 'lang.uk_UA': return 'ウクライナ語（ウクライナ）';
			case 'lang.ur_IN': return 'ウルドゥー語（インド）';
			case 'lang.ur_PK': return 'ウルドゥー語（パキスタン）';
			case 'lang.uz_UZ': return 'ウズベク語（ウズベキスタン）';
			case 'lang.vi_VN': return 'ベトナム語（ベトナム）';
			case 'lang.zu_ZA': return 'ズールー語（南アフリカ）';
			case 'calendars.sunday': return '日';
			case 'calendars.monday': return '月';
			case 'calendars.tuesday': return '火';
			case 'calendars.wednesday': return '水';
			case 'calendars.thursday': return '木';
			case 'calendars.friday': return '金';
			case 'calendars.saturday': return '土';
			case 'calendars.prev': return '前';
			case 'calendars.next': return '次';
			case 'calendars.prevYear': return '前年';
			case 'calendars.nextYear': return '翌年';
			case 'calendars.today': return '今日';
			case 'calendars.month': return '月';
			case 'calendars.week': return '週';
			case 'calendars.day': return '日';
			case 'calendars.answers': return ({required Object count}) => '${count}問';
			case 'calendars.reviewed': return '復習了';
			case 'dictionaryMaps.set_dictionaries': return 'My辞書を設定する';
			case 'dictionaryMaps.add_dictionaries': return 'My辞書を追加する';
			case 'dictionaryMaps.remove_dictionaries': return 'My辞書を削除する';
			case 'dictionaryMaps.select_dictionaries_to_use': return '追加する辞書を選択してください';
			case 'dictionaryMaps.add': return '追加する';
			case 'dictionaryMaps.select_dictionaries_to_remove': return '削除する辞書を選択してください';
			case 'dictionaryMaps.remove': return '削除する';
			case 'dictionaryMaps.set': return '設定する';
			case 'dictionaryMaps.update_success': return 'My辞書を設定しました。';
			case 'dictionaryMaps.update_failed': return 'My辞書が設定できませんでした。';
			case 'words.entry': return '項目';
			case 'words.meaning': return '意味';
			default: return null;
		}
	}
}
