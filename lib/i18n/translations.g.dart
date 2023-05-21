/// Generated file. Do not edit.
///
/// Locales: 2
/// Strings: 953 (476 per locale)
///
/// Built on 2023-05-21 at 06:27 UTC

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
	late final _TranslationsSessionsEn sessions = _TranslationsSessionsEn._(_root);
	late final _TranslationsDictionariesEn dictionaries = _TranslationsDictionariesEn._(_root);
	late final _TranslationsErrorsEn errors = _TranslationsErrorsEn._(_root);
	late final _TranslationsUsersEn users = _TranslationsUsersEn._(_root);
	late final _TranslationsSharedEn shared = _TranslationsSharedEn._(_root);
	late final _TranslationsLangEn lang = _TranslationsLangEn._(_root);
	late final _TranslationsSentencesEn sentences = _TranslationsSentencesEn._(_root);
	late final _TranslationsCalendarsEn calendars = _TranslationsCalendarsEn._(_root);
	late final _TranslationsLayoutsEn layouts = _TranslationsLayoutsEn._(_root);
	late final _TranslationsDictionaryMapsEn dictionaryMaps = _TranslationsDictionaryMapsEn._(_root);
	late final _TranslationsWordsEn words = _TranslationsWordsEn._(_root);
	late final _TranslationsHomeEn home = _TranslationsHomeEn._(_root);
}

// Path: sessions
class _TranslationsSessionsEn {
	_TranslationsSessionsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get log_in => 'Log in';
	String get sign_up => 'Sign up';
	String get register => 'Register';
	String get dont_have_account => 'Don\'t have an account?';
	String get forgot_password => 'Forgot password?';
	String get already_have_an_account => 'Already have an account?';
	String get user_name => 'Name';
	String get email => 'Email';
	String get password => 'Password';
	String get password_condition => 'at least 6 characters';
	String get sign_up_succeeded => 'Signed up. Welcome to DiQt!';
	String get sign_up_failed => 'Could not register. Either the user with the email address already exists or the password is too short.';
	String get login_succeeded => 'Logged in';
	String get login_failed => 'Could not log in.';
	String get cancelled => 'cancelled';
	String get or => 'or';
	String get continue_with_apple => 'Continue with Apple';
	String get continue_with_google => 'Continue with Google';
	String get continue_with_twitter => 'Continue with Twitter';
	String get log_out => 'Log out';
	String get log_out_succeeded => 'Logged out';
}

// Path: dictionaries
class _TranslationsDictionariesEn {
	_TranslationsDictionariesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get dictionaries => 'Dictionaries';
	String get dictionary => 'Dictionary';
	String get search => 'Search';
	String get input_keyword => 'Search keyword';
	String get image_alt => 'Image of Dictionary';
	String get accepted_requests => 'Accepted Requests';
	String get pending_requests => 'Pending Requests';
	String get accepted_word_requests => 'Accepted Word Requests';
	String get pending_word_requests => 'Pending Word Requests';
	String get rejected_word_requests => 'Rejected Word Requests';
	String get accepted => 'Accepted';
	String get pending => 'Pending';
	String get rejected => 'Rejected';
	String get words => 'Words';
	String get sentences => 'Sentences';
	String get accepted_sense_requests => 'Accepted Sense Requests';
	String get pending_sense_requests => 'Pending Sense Requests';
	String get rejected_sense_requests => 'Rejected Sense Requests';
	String get accepted_sentence_requests => 'Accepted Sentence Requests';
	String get pending_sentence_requests => 'Pending Sentence Requests';
	String get rejected_sentence_requests => 'Rejected Sentence Requests';
	String get accepted_quiz_requests => 'Accepted Quiz Requests';
	String get pending_quiz_requests => 'Pending Quiz Requests';
	String get rejected_quiz_requests => 'Rejected Quiz Requests';
	String get word_lists => 'Word Lists';
	String get word_drill => 'WordDrill';
	String get sentence_drill => 'SentenceDrill';
	String get speaking_sentence_drill => 'SentenceDrill for writing and speaking';
	String get sense_drill => 'SenseDrill';
	String get guideline => 'Editing Guideline';
	String get credit => 'Credit';
	String get pos_tags => 'Part of Speech';
	String get grammars => 'Grammars';
	String get no_applied_dictionary => 'DictionarySetting: None';
	String search_results_of({required Object query}) => 'Search results of "${query}"';
	String entry_not_found({required Object query}) => '"${query}" is not found.';
	String get search_by_web => 'Search by Web';
	String search_by_another({required Object name}) => 'Search by ${name}';
	String add_keyword_to_dictionary({required Object keyword}) => 'Add "${keyword}" to the dictionary';
	String get no_permission => 'You don\'t have permission.';
	String get no_addition_permission => 'You don\'t have create permission.';
	String get no_modification_permission => 'You don\'t have update permission.';
	String get no_elimination_permission => 'You don\'t have delete permission.';
}

// Path: errors
class _TranslationsErrorsEn {
	_TranslationsErrorsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get error_message_404 => 'Page Not Found...';
	String get error_message_505 => 'I\'m so sorry. This is internal server error.';
	String get cant_be_blank => 'This field can\'t be blank.';
	String get error_occured => 'Errors have occurred.';
}

// Path: users
class _TranslationsUsersEn {
	_TranslationsUsersEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get anonymous_user => 'Anonymous user';
	String get edit => 'Account Setting';
	String get withdraw => 'Withdraw from DiQt';
	String get name => 'Name';
	String get profile => 'Profile';
	String get profile_placeholder => 'Please enter a profile of no more than 500 characters.';
	String get lang_number => 'Language Setting(mother tongue)';
	String get learning_lang_number => 'Learning Language';
	String get authentication => 'Authentication';
	String get email => 'Email';
	String get new_password => 'Password';
	String get new_password_placeholder => 'At least 6 alphanumeric characters';
	String get new_password_confirmation => 'Password Confirmation';
	String get new_password_confirmation_placeholder => 'Please enter a new password again';
	String get notification_deliver => 'Receive email notifications';
}

// Path: shared
class _TranslationsSharedEn {
	_TranslationsSharedEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get create => 'Create';
	String get edit => 'Edit';
	String get update => 'Update';
	String get update_succeeded => 'Updated';
	String get update_failed => 'Update failed';
	String get destroy => 'Destroy';
	String get cancel => 'Cancel';
	String get reload => 'Reload';
	String get search => 'Search';
	String get generate => 'Generate';
	String get undefined => 'Undefined';
	String get details => 'Details';
	String please_enter({required Object name}) => 'Please enter "${name}"';
}

// Path: lang
class _TranslationsLangEn {
	_TranslationsLangEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get google_translation => 'Google Translation';
	String get deepl_translation => 'DeepL Translation';
	String get translating => 'Translating...';
	String get done => 'Done';
	String get translation_failed => 'Translation Failed';
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

// Path: sentences
class _TranslationsSentencesEn {
	_TranslationsSentencesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get sentence => 'Sentence';
	String get add => 'Add sentence';
	String get edit => 'Edit sentence';
	String get original => 'Original';
	String get translation => 'Translation';
	String original_placeholder({required Object language}) => 'Please enter an example sentence in ${language}.';
	String translation_placeholder({required Object language}) => 'Please enter a ${language} translation of the example sentence.';
	String get generate_sentence => 'Generate an example sentence with AI';
	String keyword_description({required Object limit}) => 'Enter the keywords you wish to include in the examples (max. ${limit} characters).';
	String get keyword_placeholder => 'Keywords to be included in the sentence';
	String get pos => 'Part of speech of keywords';
	String get meaning => 'Meaning of keywords (e.g. synonyms)';
	String get meaning_placeholder => 'The meaning of the keywords can be specified.';
	String get sentence_type => 'Sentence Type';
	String get declarative_sentence => 'Declarative sentence';
	String get interrogative_sentence => 'Interrogative sentence';
	String get imperative_sentence => 'Imperative sentence';
	String get exclamatory_sentence => 'Exclamatory sentence';
	String get temperature => 'Temperature';
	String get temperature_description => 'Set between 0~20. Higher values increase the randomness of the sentences; lower values generate more deterministic sentences. The default is 7.';
	String get details => 'Details';
	String get sentence_generated => 'Sentence generated';
	String get generating_sentence_failed => 'Generating sentence failed';
	String get created => 'Sentence Created';
	String get create_failed => 'Failed to create the sentence.';
	String get updated => 'Sentence Updated';
	String get update_failed => 'Failed to update the sentence.';
	String get destroyed => 'Sentence Destroyed';
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

// Path: layouts
class _TranslationsLayoutsEn {
	_TranslationsLayoutsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get my_page => 'MyPage';
	String get review => 'Reviews';
	String get notification => 'Notifications';
	String get word_list => 'WordLists';
	String get dictionary => 'Dictionaries';
	String get school => 'School';
	String get download => 'Download';
	String get premium_plan => 'Premium Plan';
	String get community => 'Community';
	String get update => 'Update';
	String get contact => 'Contact';
	String get related_services => 'Related Services';
	String get help => 'Help';
	String get company => 'Company';
	String get commercial_transaction_act => 'Specified Commercial Transaction Act';
	String get term_of_service => 'Terms of service';
	String get privacy_policy => 'Privacy policy';
}

// Path: dictionaryMaps
class _TranslationsDictionaryMapsEn {
	_TranslationsDictionaryMapsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get please_select => 'Please select a dictionary';
	String get not_selected => 'Dictionary not selected';
	String enter({required Object language}) => 'Please enter ${language}';
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
	String get add => 'Add Word';
	String get edit => 'Edit Word';
	String get created => 'Word Created';
	String get create_failed => 'Creating Word failed';
	String get updated => 'Word Updated';
	String get update_failed => 'Word Update Failed ';
	String get destroyed => 'Word Destroyed';
	String get entry => 'Headword';
	String get reading => 'Reading';
	String get meaning => 'Meaning';
	String get ipa => 'IPA(Pronunciation)';
	String get set_example_sentence => 'Search Example Sentences';
	String get etymologies => 'Etymologies';
	String get explanation => 'Explanation';
	String get sentence => 'Example Sentence';
	String get synonyms => 'Synonyms';
	String get antonyms => 'Antonyms';
	String get related => 'Related Words';
	String sense({required Object number}) => 'sense(${number})';
	String get detailed_settings => 'Detailed Settings';
	String get comment => 'Comment';
	String get update => 'Fix';
	String get diqt_markdown_support => 'DiQt Markdown Support';
	String get text_preview => 'Preview';
	String get there_is_no_text => 'There is no text.';
	String get undefined_lang_number => 'Language is not set.';
	String get diqt_notation => 'DiQt Notation';
	String get comment_placeholder => 'You can comment about this.';
	String get destroy => 'Destroy';
	String get confirmation => 'Confirmation';
	String get edit_btn => 'Edit this word';
	String get new_btn => 'Add a word';
	String get view_your_edit => 'View your edit';
	String get details => 'Details';
	String get not_found => 'Not Found';
}

// Path: home
class _TranslationsHomeEn {
	_TranslationsHomeEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get welcome => 'Welcome to DiQt!';
	String get welcome_description_1 => 'DiQt is a dictionary app to help you never forget vocabulary.';
	String get welcome_description_2 => 'Easy to use. Look up the word in the dictionary,';
	String get welcome_description_3 => 'set a review for the word you want to memorize,';
	String get welcome_description_4 => 'and you can review it automatically until you learn it.';
	String get contact => 'Contact';
	String get app_review => 'App Review';
	String get temrs_of_service => 'Terms of service';
	String get privacy_policy => 'Privacy policy';
	String get legal => 'Specified Commercial Transaction Act';
	String get company => 'Company';
	String get community => 'Community';
	String get community_description => 'DiQt Community is an online community for DiQt users.';
	String get join_community => 'Join the community';
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
	@override late final _TranslationsSessionsJa sessions = _TranslationsSessionsJa._(_root);
	@override late final _TranslationsDictionariesJa dictionaries = _TranslationsDictionariesJa._(_root);
	@override late final _TranslationsErrorsJa errors = _TranslationsErrorsJa._(_root);
	@override late final _TranslationsUsersJa users = _TranslationsUsersJa._(_root);
	@override late final _TranslationsSharedJa shared = _TranslationsSharedJa._(_root);
	@override late final _TranslationsLangJa lang = _TranslationsLangJa._(_root);
	@override late final _TranslationsSentencesJa sentences = _TranslationsSentencesJa._(_root);
	@override late final _TranslationsCalendarsJa calendars = _TranslationsCalendarsJa._(_root);
	@override late final _TranslationsLayoutsJa layouts = _TranslationsLayoutsJa._(_root);
	@override late final _TranslationsDictionaryMapsJa dictionaryMaps = _TranslationsDictionaryMapsJa._(_root);
	@override late final _TranslationsWordsJa words = _TranslationsWordsJa._(_root);
	@override late final _TranslationsHomeJa home = _TranslationsHomeJa._(_root);
}

// Path: sessions
class _TranslationsSessionsJa implements _TranslationsSessionsEn {
	_TranslationsSessionsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get log_in => 'ログインする';
	@override String get sign_up => '新規登録する';
	@override String get register => '登録する';
	@override String get dont_have_account => 'アカウントを持っていませんか？';
	@override String get forgot_password => 'パスワードを忘れましたか?';
	@override String get already_have_an_account => 'すでにアカウントをお持ちですか?';
	@override String get user_name => 'ユーザー名';
	@override String get email => 'メールアドレス';
	@override String get password => 'パスワード';
	@override String get password_condition => '6文字以上';
	@override String get sign_up_succeeded => '登録が完了しました。ようこそDiQtへ。';
	@override String get sign_up_failed => '登録できませんでした。そのメールアドレスのユーザーがすでに存在しているか、パスワードが短すぎます。';
	@override String get login_succeeded => 'ログインしました。';
	@override String get login_failed => 'ログインに失敗しました。';
	@override String get cancelled => 'キャンセルされました。';
	@override String get or => 'あるいは';
	@override String get continue_with_apple => 'Appleで続ける';
	@override String get continue_with_google => 'Googleで続ける';
	@override String get continue_with_twitter => 'Twitterで続ける';
	@override String get log_out => 'ログアウトする';
	@override String get log_out_succeeded => 'ログアウトしました。';
}

// Path: dictionaries
class _TranslationsDictionariesJa implements _TranslationsDictionariesEn {
	_TranslationsDictionariesJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get dictionaries => '辞書一覧';
	@override String get dictionary => '辞書';
	@override String get search => '検索する';
	@override String get input_keyword => '辞書で調べたい単語を入力';
	@override String get image_alt => '辞書の画像';
	@override String get accepted_requests => '編集履歴';
	@override String get pending_requests => '審査中の編集';
	@override String get accepted_word_requests => '項目の編集履歴';
	@override String get pending_word_requests => '項目の審査中の編集';
	@override String get rejected_word_requests => '項目の却下された編集';
	@override String get accepted => '採用';
	@override String get pending => '審査中';
	@override String get rejected => '却下';
	@override String get words => '項目一覧';
	@override String get sentences => '例文一覧';
	@override String get accepted_sense_requests => '意味の編集履歴';
	@override String get pending_sense_requests => '意味の審査中の編集';
	@override String get rejected_sense_requests => '意味の却下された編集';
	@override String get accepted_sentence_requests => '例文の編集履歴';
	@override String get pending_sentence_requests => '例文の審査中の編集';
	@override String get rejected_sentence_requests => '例文の却下された編集';
	@override String get accepted_quiz_requests => '問題の編集履歴';
	@override String get pending_quiz_requests => '問題の審査中の編集';
	@override String get rejected_quiz_requests => '問題の却下された編集';
	@override String get word_lists => '単語帳';
	@override String get word_drill => '辞書問題';
	@override String get sentence_drill => '例文問題';
	@override String get speaking_sentence_drill => 'スピーキングとライティングのための例文問題';
	@override String get sense_drill => '意味問題';
	@override String get guideline => '編集ガイドライン';
	@override String get credit => 'クレジット';
	@override String get pos_tags => '品詞';
	@override String get grammars => '文法';
	@override String get no_applied_dictionary => '辞書設定：なし';
	@override String search_results_of({required Object query}) => '『${query}』の検索結果';
	@override String entry_not_found({required Object query}) => '"${query}"は辞書に登録されていません。';
	@override String get search_by_web => 'Webで検索する';
	@override String search_by_another({required Object name}) => '${name}で検索する';
	@override String add_keyword_to_dictionary({required Object keyword}) => '"${keyword}"を辞書に追加する';
	@override String get no_permission => '権限がありません。';
	@override String get no_addition_permission => '追加する権限がありません。';
	@override String get no_modification_permission => '修正する権限がありません。';
	@override String get no_elimination_permission => '削除する権限がありません。';
}

// Path: errors
class _TranslationsErrorsJa implements _TranslationsErrorsEn {
	_TranslationsErrorsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get error_message_404 => 'ページが見つかりませんでした。';
	@override String get error_message_505 => '大変申し訳ございません。サーバーでエラーが発生しました。';
	@override String get cant_be_blank => 'この項目は空欄にできません。';
	@override String get error_occured => 'エラーが発生しました。';
}

// Path: users
class _TranslationsUsersJa implements _TranslationsUsersEn {
	_TranslationsUsersJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get anonymous_user => '匿名ユーザー';
	@override String get creating_account_succeeded => '会員登録が完了しました！ようこそDiQtへ！！';
	@override String get edit => 'アカウント設定';
	@override String get withdraw => 'DiQtから退会する';
	@override String get name => 'ユーザー名';
	@override String get profile => 'プロフィール';
	@override String get profile_placeholder => '500文字以内でプロフィールを入力してください。';
	@override String get lang_number => '言語設定(母語)';
	@override String get learning_lang_number => '学習言語';
	@override String get authentication => '認証設定';
	@override String get email => 'メールアドレス';
	@override String get new_password => 'パスワード';
	@override String get new_password_placeholder => '半角英数字６文字以上';
	@override String get new_password_confirmation => 'パスワード確認';
	@override String get new_password_confirmation_placeholder => 'もう一度パスワードを入力してください。';
	@override String get notification_deliver => 'メールによる通知を受け取る';
}

// Path: shared
class _TranslationsSharedJa implements _TranslationsSharedEn {
	_TranslationsSharedJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get create => '作成する';
	@override String get edit => '編集する';
	@override String get update => '更新する';
	@override String get update_succeeded => '更新されました。';
	@override String get update_failed => '更新に失敗しました。';
	@override String get destroy => '削除する';
	@override String get cancel => 'キャンセルする';
	@override String get reload => '再読み込みする';
	@override String get search => '検索する';
	@override String get generate => '生成する';
	@override String get undefined => '未定義';
	@override String get details => '詳細';
	@override String please_enter({required Object name}) => '"${name}"を入力してください。';
}

// Path: lang
class _TranslationsLangJa implements _TranslationsLangEn {
	_TranslationsLangJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get google_translation => 'Google翻訳';
	@override String get deepl_translation => 'DeepL翻訳';
	@override String get translating => '翻訳中...';
	@override String get done => '完了';
	@override String get translation_failed => '翻訳できませんでした。';
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

// Path: sentences
class _TranslationsSentencesJa implements _TranslationsSentencesEn {
	_TranslationsSentencesJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get sentence => '例文';
	@override String get add => '例文を追加する';
	@override String get edit => '例文を編集する';
	@override String get original => '原文';
	@override String get translation => '翻訳';
	@override String original_placeholder({required Object language}) => '【必須】${language}の例文を入力してください。';
	@override String translation_placeholder({required Object language}) => '【必須】例文の${language}の訳を入力してください。';
	@override String get generate_sentence => 'AIで例文を生成する';
	@override String keyword_description({required Object limit}) => '例文に含めたいキーワードを入力してください(${limit}文字以内)。';
	@override String get keyword_placeholder => '【必須】例文に含みたいキーワード';
	@override String get pos => 'キーワードの品詞';
	@override String get meaning => 'キーワードの意味（類義語など）';
	@override String get meaning_placeholder => 'キーワードの意味を指定できます。';
	@override String get sentence_type => '文の種類';
	@override String get declarative_sentence => '平叙文';
	@override String get interrogative_sentence => '疑問文';
	@override String get imperative_sentence => '命令文';
	@override String get exclamatory_sentence => '感嘆文';
	@override String get temperature => 'ランダム性（Temperature）';
	@override String get temperature_description => '0~20の間で設定します。数値が高いほど文章のランダム性が上がり、数値が低いほど確定的な文章を生成します。デフォルトは７です';
	@override String get details => '詳細';
	@override String get sentence_generated => '例文を生成しました。';
	@override String get generating_sentence_failed => '例文の生成に失敗しました。';
	@override String get created => '例文が作成されました。';
	@override String get create_failed => '例文の作成に失敗しました。';
	@override String get updated => '例文が更新されました。';
	@override String get update_failed => '例文の更新に失敗しました。';
	@override String get destroyed => '例文が削除されました。';
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

// Path: layouts
class _TranslationsLayoutsJa implements _TranslationsLayoutsEn {
	_TranslationsLayoutsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get my_page => 'マイページ';
	@override String get review => '復習';
	@override String get notification => '通知';
	@override String get dictionary => '辞書';
	@override String get school => '教室';
	@override String get word_list => '単語帳';
	@override String get download => 'ダウンロード';
	@override String get premium_plan => 'プレミアムプラン';
	@override String get community => 'コミュニティ';
	@override String get update => '更新情報';
	@override String get contact => 'お問い合わせ';
	@override String get related_services => '関連サービス';
	@override String get help => 'ヘルプ';
	@override String get company => '運営会社';
	@override String get commercial_transaction_act => '特定商取引法に基づく表記';
	@override String get term_of_service => '利用規約';
	@override String get privacy_policy => 'プライバシーポリシー';
}

// Path: dictionaryMaps
class _TranslationsDictionaryMapsJa implements _TranslationsDictionaryMapsEn {
	_TranslationsDictionaryMapsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get please_select => '辞書を選択してください';
	@override String get not_selected => '辞書が選択されていません';
	@override String enter({required Object language}) => '${language}を入力してください';
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
	@override String get add => '項目を追加する';
	@override String get edit => '項目を編集する';
	@override String get created => '項目を作成しました。';
	@override String get create_failed => '項目の作成に失敗しました。';
	@override String get updated => '項目を更新しました。';
	@override String get update_failed => '項目の更新に失敗しました。';
	@override String get destroyed => 'Word Destroyed';
	@override String get entry => '見出し語';
	@override String get reading => '読み（ひらがな）';
	@override String get meaning => '意味';
	@override String get ipa => 'IPA（発音記号）';
	@override String get set_example_sentence => '例文を検索する';
	@override String get etymologies => '語源';
	@override String get explanation => '解説';
	@override String get sentence => '例文';
	@override String get synonyms => '類義語';
	@override String get antonyms => '対義語';
	@override String get related => '関連語';
	@override String sense({required Object number}) => '意味(${number})';
	@override String get detailed_settings => '詳細設定';
	@override String get comment => 'コメント';
	@override String get update => '修正する';
	@override String get diqt_markdown_support => 'DiQt Markdown対応';
	@override String get text_preview => 'プレビュー';
	@override String get there_is_no_text => 'テキストがありません。';
	@override String get undefined_lang_number => '言語が設定されていません。';
	@override String get diqt_notation => 'DiQt記法';
	@override String get comment_placeholder => '【空欄可】コメントなどあればここに書いてください。';
	@override String get destroy => '削除する';
	@override String get confirmation => '削除確認';
	@override String get edit_btn => '項目を編集する';
	@override String get new_btn => '項目を追加する';
	@override String get view_your_edit => '編集内容を見る';
	@override String get details => '詳細';
	@override String get not_found => '該当する単語はありません。';
}

// Path: home
class _TranslationsHomeJa implements _TranslationsHomeEn {
	_TranslationsHomeJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'DiQtへようこそ！';
	@override String get welcome_description_1 => 'DiQt（ディクト）は、絶対に忘れない辞書アプリです。';
	@override String get welcome_description_2 => '使い方は簡単。辞書で調べて、';
	@override String get welcome_description_3 => '覚えたい単語に復習を設定すれば、';
	@override String get welcome_description_4 => '覚えるまで自動で復習できるようになります。';
	@override String get contact => 'お問い合わせ';
	@override String get app_review => 'レビュー';
	@override String get temrs_of_service => '利用規約';
	@override String get privacy_policy => 'プライバシーポリシー';
	@override String get legal => '特定商取引法に基づく表記';
	@override String get company => '運営会社';
	@override String get community => 'コミュニティ';
	@override String get community_description => 'DiQt Community（ディクト・コミュニティ）は、DiQtユーザーのためのオンラインコミュニティです。';
	@override String get join_community => 'コミュニティに参加する';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _TranslationsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'sessions.log_in': return 'Log in';
			case 'sessions.sign_up': return 'Sign up';
			case 'sessions.register': return 'Register';
			case 'sessions.dont_have_account': return 'Don\'t have an account?';
			case 'sessions.forgot_password': return 'Forgot password?';
			case 'sessions.already_have_an_account': return 'Already have an account?';
			case 'sessions.user_name': return 'Name';
			case 'sessions.email': return 'Email';
			case 'sessions.password': return 'Password';
			case 'sessions.password_condition': return 'at least 6 characters';
			case 'sessions.sign_up_succeeded': return 'Signed up. Welcome to DiQt!';
			case 'sessions.sign_up_failed': return 'Could not register. Either the user with the email address already exists or the password is too short.';
			case 'sessions.login_succeeded': return 'Logged in';
			case 'sessions.login_failed': return 'Could not log in.';
			case 'sessions.cancelled': return 'cancelled';
			case 'sessions.or': return 'or';
			case 'sessions.continue_with_apple': return 'Continue with Apple';
			case 'sessions.continue_with_google': return 'Continue with Google';
			case 'sessions.continue_with_twitter': return 'Continue with Twitter';
			case 'sessions.log_out': return 'Log out';
			case 'sessions.log_out_succeeded': return 'Logged out';
			case 'dictionaries.dictionaries': return 'Dictionaries';
			case 'dictionaries.dictionary': return 'Dictionary';
			case 'dictionaries.search': return 'Search';
			case 'dictionaries.input_keyword': return 'Search keyword';
			case 'dictionaries.image_alt': return 'Image of Dictionary';
			case 'dictionaries.accepted_requests': return 'Accepted Requests';
			case 'dictionaries.pending_requests': return 'Pending Requests';
			case 'dictionaries.accepted_word_requests': return 'Accepted Word Requests';
			case 'dictionaries.pending_word_requests': return 'Pending Word Requests';
			case 'dictionaries.rejected_word_requests': return 'Rejected Word Requests';
			case 'dictionaries.accepted': return 'Accepted';
			case 'dictionaries.pending': return 'Pending';
			case 'dictionaries.rejected': return 'Rejected';
			case 'dictionaries.words': return 'Words';
			case 'dictionaries.sentences': return 'Sentences';
			case 'dictionaries.accepted_sense_requests': return 'Accepted Sense Requests';
			case 'dictionaries.pending_sense_requests': return 'Pending Sense Requests';
			case 'dictionaries.rejected_sense_requests': return 'Rejected Sense Requests';
			case 'dictionaries.accepted_sentence_requests': return 'Accepted Sentence Requests';
			case 'dictionaries.pending_sentence_requests': return 'Pending Sentence Requests';
			case 'dictionaries.rejected_sentence_requests': return 'Rejected Sentence Requests';
			case 'dictionaries.accepted_quiz_requests': return 'Accepted Quiz Requests';
			case 'dictionaries.pending_quiz_requests': return 'Pending Quiz Requests';
			case 'dictionaries.rejected_quiz_requests': return 'Rejected Quiz Requests';
			case 'dictionaries.word_lists': return 'Word Lists';
			case 'dictionaries.word_drill': return 'WordDrill';
			case 'dictionaries.sentence_drill': return 'SentenceDrill';
			case 'dictionaries.speaking_sentence_drill': return 'SentenceDrill for writing and speaking';
			case 'dictionaries.sense_drill': return 'SenseDrill';
			case 'dictionaries.guideline': return 'Editing Guideline';
			case 'dictionaries.credit': return 'Credit';
			case 'dictionaries.pos_tags': return 'Part of Speech';
			case 'dictionaries.grammars': return 'Grammars';
			case 'dictionaries.no_applied_dictionary': return 'DictionarySetting: None';
			case 'dictionaries.search_results_of': return ({required Object query}) => 'Search results of "${query}"';
			case 'dictionaries.entry_not_found': return ({required Object query}) => '"${query}" is not found.';
			case 'dictionaries.search_by_web': return 'Search by Web';
			case 'dictionaries.search_by_another': return ({required Object name}) => 'Search by ${name}';
			case 'dictionaries.add_keyword_to_dictionary': return ({required Object keyword}) => 'Add "${keyword}" to the dictionary';
			case 'dictionaries.no_permission': return 'You don\'t have permission.';
			case 'dictionaries.no_addition_permission': return 'You don\'t have create permission.';
			case 'dictionaries.no_modification_permission': return 'You don\'t have update permission.';
			case 'dictionaries.no_elimination_permission': return 'You don\'t have delete permission.';
			case 'errors.error_message_404': return 'Page Not Found...';
			case 'errors.error_message_505': return 'I\'m so sorry. This is internal server error.';
			case 'errors.cant_be_blank': return 'This field can\'t be blank.';
			case 'errors.error_occured': return 'Errors have occurred.';
			case 'users.anonymous_user': return 'Anonymous user';
			case 'users.edit': return 'Account Setting';
			case 'users.withdraw': return 'Withdraw from DiQt';
			case 'users.name': return 'Name';
			case 'users.profile': return 'Profile';
			case 'users.profile_placeholder': return 'Please enter a profile of no more than 500 characters.';
			case 'users.lang_number': return 'Language Setting(mother tongue)';
			case 'users.learning_lang_number': return 'Learning Language';
			case 'users.authentication': return 'Authentication';
			case 'users.email': return 'Email';
			case 'users.new_password': return 'Password';
			case 'users.new_password_placeholder': return 'At least 6 alphanumeric characters';
			case 'users.new_password_confirmation': return 'Password Confirmation';
			case 'users.new_password_confirmation_placeholder': return 'Please enter a new password again';
			case 'users.notification_deliver': return 'Receive email notifications';
			case 'shared.create': return 'Create';
			case 'shared.edit': return 'Edit';
			case 'shared.update': return 'Update';
			case 'shared.update_succeeded': return 'Updated';
			case 'shared.update_failed': return 'Update failed';
			case 'shared.destroy': return 'Destroy';
			case 'shared.cancel': return 'Cancel';
			case 'shared.reload': return 'Reload';
			case 'shared.search': return 'Search';
			case 'shared.generate': return 'Generate';
			case 'shared.undefined': return 'Undefined';
			case 'shared.details': return 'Details';
			case 'shared.please_enter': return ({required Object name}) => 'Please enter "${name}"';
			case 'lang.google_translation': return 'Google Translation';
			case 'lang.deepl_translation': return 'DeepL Translation';
			case 'lang.translating': return 'Translating...';
			case 'lang.done': return 'Done';
			case 'lang.translation_failed': return 'Translation Failed';
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
			case 'sentences.sentence': return 'Sentence';
			case 'sentences.add': return 'Add sentence';
			case 'sentences.edit': return 'Edit sentence';
			case 'sentences.original': return 'Original';
			case 'sentences.translation': return 'Translation';
			case 'sentences.original_placeholder': return ({required Object language}) => 'Please enter an example sentence in ${language}.';
			case 'sentences.translation_placeholder': return ({required Object language}) => 'Please enter a ${language} translation of the example sentence.';
			case 'sentences.generate_sentence': return 'Generate an example sentence with AI';
			case 'sentences.keyword_description': return ({required Object limit}) => 'Enter the keywords you wish to include in the examples (max. ${limit} characters).';
			case 'sentences.keyword_placeholder': return 'Keywords to be included in the sentence';
			case 'sentences.pos': return 'Part of speech of keywords';
			case 'sentences.meaning': return 'Meaning of keywords (e.g. synonyms)';
			case 'sentences.meaning_placeholder': return 'The meaning of the keywords can be specified.';
			case 'sentences.sentence_type': return 'Sentence Type';
			case 'sentences.declarative_sentence': return 'Declarative sentence';
			case 'sentences.interrogative_sentence': return 'Interrogative sentence';
			case 'sentences.imperative_sentence': return 'Imperative sentence';
			case 'sentences.exclamatory_sentence': return 'Exclamatory sentence';
			case 'sentences.temperature': return 'Temperature';
			case 'sentences.temperature_description': return 'Set between 0~20. Higher values increase the randomness of the sentences; lower values generate more deterministic sentences. The default is 7.';
			case 'sentences.details': return 'Details';
			case 'sentences.sentence_generated': return 'Sentence generated';
			case 'sentences.generating_sentence_failed': return 'Generating sentence failed';
			case 'sentences.created': return 'Sentence Created';
			case 'sentences.create_failed': return 'Failed to create the sentence.';
			case 'sentences.updated': return 'Sentence Updated';
			case 'sentences.update_failed': return 'Failed to update the sentence.';
			case 'sentences.destroyed': return 'Sentence Destroyed';
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
			case 'layouts.my_page': return 'MyPage';
			case 'layouts.review': return 'Reviews';
			case 'layouts.notification': return 'Notifications';
			case 'layouts.word_list': return 'WordLists';
			case 'layouts.dictionary': return 'Dictionaries';
			case 'layouts.school': return 'School';
			case 'layouts.download': return 'Download';
			case 'layouts.premium_plan': return 'Premium Plan';
			case 'layouts.community': return 'Community';
			case 'layouts.update': return 'Update';
			case 'layouts.contact': return 'Contact';
			case 'layouts.related_services': return 'Related Services';
			case 'layouts.help': return 'Help';
			case 'layouts.company': return 'Company';
			case 'layouts.commercial_transaction_act': return 'Specified Commercial Transaction Act';
			case 'layouts.term_of_service': return 'Terms of service';
			case 'layouts.privacy_policy': return 'Privacy policy';
			case 'dictionaryMaps.please_select': return 'Please select a dictionary';
			case 'dictionaryMaps.not_selected': return 'Dictionary not selected';
			case 'dictionaryMaps.enter': return ({required Object language}) => 'Please enter ${language}';
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
			case 'words.add': return 'Add Word';
			case 'words.edit': return 'Edit Word';
			case 'words.created': return 'Word Created';
			case 'words.create_failed': return 'Creating Word failed';
			case 'words.updated': return 'Word Updated';
			case 'words.update_failed': return 'Word Update Failed ';
			case 'words.destroyed': return 'Word Destroyed';
			case 'words.entry': return 'Headword';
			case 'words.reading': return 'Reading';
			case 'words.meaning': return 'Meaning';
			case 'words.ipa': return 'IPA(Pronunciation)';
			case 'words.set_example_sentence': return 'Search Example Sentences';
			case 'words.etymologies': return 'Etymologies';
			case 'words.explanation': return 'Explanation';
			case 'words.sentence': return 'Example Sentence';
			case 'words.synonyms': return 'Synonyms';
			case 'words.antonyms': return 'Antonyms';
			case 'words.related': return 'Related Words';
			case 'words.sense': return ({required Object number}) => 'sense(${number})';
			case 'words.detailed_settings': return 'Detailed Settings';
			case 'words.comment': return 'Comment';
			case 'words.update': return 'Fix';
			case 'words.diqt_markdown_support': return 'DiQt Markdown Support';
			case 'words.text_preview': return 'Preview';
			case 'words.there_is_no_text': return 'There is no text.';
			case 'words.undefined_lang_number': return 'Language is not set.';
			case 'words.diqt_notation': return 'DiQt Notation';
			case 'words.comment_placeholder': return 'You can comment about this.';
			case 'words.destroy': return 'Destroy';
			case 'words.confirmation': return 'Confirmation';
			case 'words.edit_btn': return 'Edit this word';
			case 'words.new_btn': return 'Add a word';
			case 'words.view_your_edit': return 'View your edit';
			case 'words.details': return 'Details';
			case 'words.not_found': return 'Not Found';
			case 'home.welcome': return 'Welcome to DiQt!';
			case 'home.welcome_description_1': return 'DiQt is a dictionary app to help you never forget vocabulary.';
			case 'home.welcome_description_2': return 'Easy to use. Look up the word in the dictionary,';
			case 'home.welcome_description_3': return 'set a review for the word you want to memorize,';
			case 'home.welcome_description_4': return 'and you can review it automatically until you learn it.';
			case 'home.contact': return 'Contact';
			case 'home.app_review': return 'App Review';
			case 'home.temrs_of_service': return 'Terms of service';
			case 'home.privacy_policy': return 'Privacy policy';
			case 'home.legal': return 'Specified Commercial Transaction Act';
			case 'home.company': return 'Company';
			case 'home.community': return 'Community';
			case 'home.community_description': return 'DiQt Community is an online community for DiQt users.';
			case 'home.join_community': return 'Join the community';
			default: return null;
		}
	}
}

extension on _TranslationsJa {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'sessions.log_in': return 'ログインする';
			case 'sessions.sign_up': return '新規登録する';
			case 'sessions.register': return '登録する';
			case 'sessions.dont_have_account': return 'アカウントを持っていませんか？';
			case 'sessions.forgot_password': return 'パスワードを忘れましたか?';
			case 'sessions.already_have_an_account': return 'すでにアカウントをお持ちですか?';
			case 'sessions.user_name': return 'ユーザー名';
			case 'sessions.email': return 'メールアドレス';
			case 'sessions.password': return 'パスワード';
			case 'sessions.password_condition': return '6文字以上';
			case 'sessions.sign_up_succeeded': return '登録が完了しました。ようこそDiQtへ。';
			case 'sessions.sign_up_failed': return '登録できませんでした。そのメールアドレスのユーザーがすでに存在しているか、パスワードが短すぎます。';
			case 'sessions.login_succeeded': return 'ログインしました。';
			case 'sessions.login_failed': return 'ログインに失敗しました。';
			case 'sessions.cancelled': return 'キャンセルされました。';
			case 'sessions.or': return 'あるいは';
			case 'sessions.continue_with_apple': return 'Appleで続ける';
			case 'sessions.continue_with_google': return 'Googleで続ける';
			case 'sessions.continue_with_twitter': return 'Twitterで続ける';
			case 'sessions.log_out': return 'ログアウトする';
			case 'sessions.log_out_succeeded': return 'ログアウトしました。';
			case 'dictionaries.dictionaries': return '辞書一覧';
			case 'dictionaries.dictionary': return '辞書';
			case 'dictionaries.search': return '検索する';
			case 'dictionaries.input_keyword': return '辞書で調べたい単語を入力';
			case 'dictionaries.image_alt': return '辞書の画像';
			case 'dictionaries.accepted_requests': return '編集履歴';
			case 'dictionaries.pending_requests': return '審査中の編集';
			case 'dictionaries.accepted_word_requests': return '項目の編集履歴';
			case 'dictionaries.pending_word_requests': return '項目の審査中の編集';
			case 'dictionaries.rejected_word_requests': return '項目の却下された編集';
			case 'dictionaries.accepted': return '採用';
			case 'dictionaries.pending': return '審査中';
			case 'dictionaries.rejected': return '却下';
			case 'dictionaries.words': return '項目一覧';
			case 'dictionaries.sentences': return '例文一覧';
			case 'dictionaries.accepted_sense_requests': return '意味の編集履歴';
			case 'dictionaries.pending_sense_requests': return '意味の審査中の編集';
			case 'dictionaries.rejected_sense_requests': return '意味の却下された編集';
			case 'dictionaries.accepted_sentence_requests': return '例文の編集履歴';
			case 'dictionaries.pending_sentence_requests': return '例文の審査中の編集';
			case 'dictionaries.rejected_sentence_requests': return '例文の却下された編集';
			case 'dictionaries.accepted_quiz_requests': return '問題の編集履歴';
			case 'dictionaries.pending_quiz_requests': return '問題の審査中の編集';
			case 'dictionaries.rejected_quiz_requests': return '問題の却下された編集';
			case 'dictionaries.word_lists': return '単語帳';
			case 'dictionaries.word_drill': return '辞書問題';
			case 'dictionaries.sentence_drill': return '例文問題';
			case 'dictionaries.speaking_sentence_drill': return 'スピーキングとライティングのための例文問題';
			case 'dictionaries.sense_drill': return '意味問題';
			case 'dictionaries.guideline': return '編集ガイドライン';
			case 'dictionaries.credit': return 'クレジット';
			case 'dictionaries.pos_tags': return '品詞';
			case 'dictionaries.grammars': return '文法';
			case 'dictionaries.no_applied_dictionary': return '辞書設定：なし';
			case 'dictionaries.search_results_of': return ({required Object query}) => '『${query}』の検索結果';
			case 'dictionaries.entry_not_found': return ({required Object query}) => '"${query}"は辞書に登録されていません。';
			case 'dictionaries.search_by_web': return 'Webで検索する';
			case 'dictionaries.search_by_another': return ({required Object name}) => '${name}で検索する';
			case 'dictionaries.add_keyword_to_dictionary': return ({required Object keyword}) => '"${keyword}"を辞書に追加する';
			case 'dictionaries.no_permission': return '権限がありません。';
			case 'dictionaries.no_addition_permission': return '追加する権限がありません。';
			case 'dictionaries.no_modification_permission': return '修正する権限がありません。';
			case 'dictionaries.no_elimination_permission': return '削除する権限がありません。';
			case 'errors.error_message_404': return 'ページが見つかりませんでした。';
			case 'errors.error_message_505': return '大変申し訳ございません。サーバーでエラーが発生しました。';
			case 'errors.cant_be_blank': return 'この項目は空欄にできません。';
			case 'errors.error_occured': return 'エラーが発生しました。';
			case 'users.anonymous_user': return '匿名ユーザー';
			case 'users.creating_account_succeeded': return '会員登録が完了しました！ようこそDiQtへ！！';
			case 'users.edit': return 'アカウント設定';
			case 'users.withdraw': return 'DiQtから退会する';
			case 'users.name': return 'ユーザー名';
			case 'users.profile': return 'プロフィール';
			case 'users.profile_placeholder': return '500文字以内でプロフィールを入力してください。';
			case 'users.lang_number': return '言語設定(母語)';
			case 'users.learning_lang_number': return '学習言語';
			case 'users.authentication': return '認証設定';
			case 'users.email': return 'メールアドレス';
			case 'users.new_password': return 'パスワード';
			case 'users.new_password_placeholder': return '半角英数字６文字以上';
			case 'users.new_password_confirmation': return 'パスワード確認';
			case 'users.new_password_confirmation_placeholder': return 'もう一度パスワードを入力してください。';
			case 'users.notification_deliver': return 'メールによる通知を受け取る';
			case 'shared.create': return '作成する';
			case 'shared.edit': return '編集する';
			case 'shared.update': return '更新する';
			case 'shared.update_succeeded': return '更新されました。';
			case 'shared.update_failed': return '更新に失敗しました。';
			case 'shared.destroy': return '削除する';
			case 'shared.cancel': return 'キャンセルする';
			case 'shared.reload': return '再読み込みする';
			case 'shared.search': return '検索する';
			case 'shared.generate': return '生成する';
			case 'shared.undefined': return '未定義';
			case 'shared.details': return '詳細';
			case 'shared.please_enter': return ({required Object name}) => '"${name}"を入力してください。';
			case 'lang.google_translation': return 'Google翻訳';
			case 'lang.deepl_translation': return 'DeepL翻訳';
			case 'lang.translating': return '翻訳中...';
			case 'lang.done': return '完了';
			case 'lang.translation_failed': return '翻訳できませんでした。';
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
			case 'sentences.sentence': return '例文';
			case 'sentences.add': return '例文を追加する';
			case 'sentences.edit': return '例文を編集する';
			case 'sentences.original': return '原文';
			case 'sentences.translation': return '翻訳';
			case 'sentences.original_placeholder': return ({required Object language}) => '【必須】${language}の例文を入力してください。';
			case 'sentences.translation_placeholder': return ({required Object language}) => '【必須】例文の${language}の訳を入力してください。';
			case 'sentences.generate_sentence': return 'AIで例文を生成する';
			case 'sentences.keyword_description': return ({required Object limit}) => '例文に含めたいキーワードを入力してください(${limit}文字以内)。';
			case 'sentences.keyword_placeholder': return '【必須】例文に含みたいキーワード';
			case 'sentences.pos': return 'キーワードの品詞';
			case 'sentences.meaning': return 'キーワードの意味（類義語など）';
			case 'sentences.meaning_placeholder': return 'キーワードの意味を指定できます。';
			case 'sentences.sentence_type': return '文の種類';
			case 'sentences.declarative_sentence': return '平叙文';
			case 'sentences.interrogative_sentence': return '疑問文';
			case 'sentences.imperative_sentence': return '命令文';
			case 'sentences.exclamatory_sentence': return '感嘆文';
			case 'sentences.temperature': return 'ランダム性（Temperature）';
			case 'sentences.temperature_description': return '0~20の間で設定します。数値が高いほど文章のランダム性が上がり、数値が低いほど確定的な文章を生成します。デフォルトは７です';
			case 'sentences.details': return '詳細';
			case 'sentences.sentence_generated': return '例文を生成しました。';
			case 'sentences.generating_sentence_failed': return '例文の生成に失敗しました。';
			case 'sentences.created': return '例文が作成されました。';
			case 'sentences.create_failed': return '例文の作成に失敗しました。';
			case 'sentences.updated': return '例文が更新されました。';
			case 'sentences.update_failed': return '例文の更新に失敗しました。';
			case 'sentences.destroyed': return '例文が削除されました。';
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
			case 'layouts.my_page': return 'マイページ';
			case 'layouts.review': return '復習';
			case 'layouts.notification': return '通知';
			case 'layouts.dictionary': return '辞書';
			case 'layouts.school': return '教室';
			case 'layouts.word_list': return '単語帳';
			case 'layouts.download': return 'ダウンロード';
			case 'layouts.premium_plan': return 'プレミアムプラン';
			case 'layouts.community': return 'コミュニティ';
			case 'layouts.update': return '更新情報';
			case 'layouts.contact': return 'お問い合わせ';
			case 'layouts.related_services': return '関連サービス';
			case 'layouts.help': return 'ヘルプ';
			case 'layouts.company': return '運営会社';
			case 'layouts.commercial_transaction_act': return '特定商取引法に基づく表記';
			case 'layouts.term_of_service': return '利用規約';
			case 'layouts.privacy_policy': return 'プライバシーポリシー';
			case 'dictionaryMaps.please_select': return '辞書を選択してください';
			case 'dictionaryMaps.not_selected': return '辞書が選択されていません';
			case 'dictionaryMaps.enter': return ({required Object language}) => '${language}を入力してください';
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
			case 'words.add': return '項目を追加する';
			case 'words.edit': return '項目を編集する';
			case 'words.created': return '項目を作成しました。';
			case 'words.create_failed': return '項目の作成に失敗しました。';
			case 'words.updated': return '項目を更新しました。';
			case 'words.update_failed': return '項目の更新に失敗しました。';
			case 'words.destroyed': return 'Word Destroyed';
			case 'words.entry': return '見出し語';
			case 'words.reading': return '読み（ひらがな）';
			case 'words.meaning': return '意味';
			case 'words.ipa': return 'IPA（発音記号）';
			case 'words.set_example_sentence': return '例文を検索する';
			case 'words.etymologies': return '語源';
			case 'words.explanation': return '解説';
			case 'words.sentence': return '例文';
			case 'words.synonyms': return '類義語';
			case 'words.antonyms': return '対義語';
			case 'words.related': return '関連語';
			case 'words.sense': return ({required Object number}) => '意味(${number})';
			case 'words.detailed_settings': return '詳細設定';
			case 'words.comment': return 'コメント';
			case 'words.update': return '修正する';
			case 'words.diqt_markdown_support': return 'DiQt Markdown対応';
			case 'words.text_preview': return 'プレビュー';
			case 'words.there_is_no_text': return 'テキストがありません。';
			case 'words.undefined_lang_number': return '言語が設定されていません。';
			case 'words.diqt_notation': return 'DiQt記法';
			case 'words.comment_placeholder': return '【空欄可】コメントなどあればここに書いてください。';
			case 'words.destroy': return '削除する';
			case 'words.confirmation': return '削除確認';
			case 'words.edit_btn': return '項目を編集する';
			case 'words.new_btn': return '項目を追加する';
			case 'words.view_your_edit': return '編集内容を見る';
			case 'words.details': return '詳細';
			case 'words.not_found': return '該当する単語はありません。';
			case 'home.welcome': return 'DiQtへようこそ！';
			case 'home.welcome_description_1': return 'DiQt（ディクト）は、絶対に忘れない辞書アプリです。';
			case 'home.welcome_description_2': return '使い方は簡単。辞書で調べて、';
			case 'home.welcome_description_3': return '覚えたい単語に復習を設定すれば、';
			case 'home.welcome_description_4': return '覚えるまで自動で復習できるようになります。';
			case 'home.contact': return 'お問い合わせ';
			case 'home.app_review': return 'レビュー';
			case 'home.temrs_of_service': return '利用規約';
			case 'home.privacy_policy': return 'プライバシーポリシー';
			case 'home.legal': return '特定商取引法に基づく表記';
			case 'home.company': return '運営会社';
			case 'home.community': return 'コミュニティ';
			case 'home.community_description': return 'DiQt Community（ディクト・コミュニティ）は、DiQtユーザーのためのオンラインコミュニティです。';
			case 'home.join_community': return 'コミュニティに参加する';
			default: return null;
		}
	}
}
