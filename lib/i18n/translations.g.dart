/// Generated file. Do not edit.
///
/// Locales: 2
/// Strings: 2088 (1044 per locale)
///
/// Built on 2023-07-25 at 02:55 UTC

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
	late final _TranslationsReviewsEn reviews = _TranslationsReviewsEn._(_root);
	late final _TranslationsErrorsEn errors = _TranslationsErrorsEn._(_root);
	late final _TranslationsDrillsEn drills = _TranslationsDrillsEn._(_root);
	late final _TranslationsWeaknessesEn weaknesses = _TranslationsWeaknessesEn._(_root);
	late final _TranslationsUsersEn users = _TranslationsUsersEn._(_root);
	late final _TranslationsSchoolsEn schools = _TranslationsSchoolsEn._(_root);
	late final _TranslationsNoticesEn notices = _TranslationsNoticesEn._(_root);
	late final _TranslationsSharedEn shared = _TranslationsSharedEn._(_root);
	late final _TranslationsAnswerSettingsEn answerSettings = _TranslationsAnswerSettingsEn._(_root);
	late final _TranslationsAnswerAnalysesEn answerAnalyses = _TranslationsAnswerAnalysesEn._(_root);
	late final _TranslationsAchievementsEn achievements = _TranslationsAchievementsEn._(_root);
	late final _TranslationsLangEn lang = _TranslationsLangEn._(_root);
	late final _TranslationsChaptersEn chapters = _TranslationsChaptersEn._(_root);
	late final _TranslationsExperiencePointsEn experiencePoints = _TranslationsExperiencePointsEn._(_root);
	late final _TranslationsSentencesEn sentences = _TranslationsSentencesEn._(_root);
	late final _TranslationsNotesEn notes = _TranslationsNotesEn._(_root);
	late final _TranslationsRankingEn ranking = _TranslationsRankingEn._(_root);
	late final _TranslationsTimeZoneEn timeZone = _TranslationsTimeZoneEn._(_root);
	late final _TranslationsAnswerEn answer = _TranslationsAnswerEn._(_root);
	late final _TranslationsQuizzesEn quizzes = _TranslationsQuizzesEn._(_root);
	late final _TranslationsActivitiesEn activities = _TranslationsActivitiesEn._(_root);
	late final _TranslationsAnswerHistoriesEn answerHistories = _TranslationsAnswerHistoriesEn._(_root);
	late final _TranslationsWordRequestsEn wordRequests = _TranslationsWordRequestsEn._(_root);
	late final _TranslationsCalendarsEn calendars = _TranslationsCalendarsEn._(_root);
	late final _TranslationsLayoutsEn layouts = _TranslationsLayoutsEn._(_root);
	late final _TranslationsDictionaryMapsEn dictionaryMaps = _TranslationsDictionaryMapsEn._(_root);
	late final _TranslationsWordsEn words = _TranslationsWordsEn._(_root);
	late final _TranslationsPurchaseEn purchase = _TranslationsPurchaseEn._(_root);
	late final _TranslationsHomeEn home = _TranslationsHomeEn._(_root);
	late final _TranslationsDrillLapsEn drillLaps = _TranslationsDrillLapsEn._(_root);
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
	String get reversed_sentence_drill => 'SentenceDrill for writing and speaking';
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

// Path: reviews
class _TranslationsReviewsEn {
	_TranslationsReviewsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get reviews => 'Reviews';
	String get unreviewed => 'Unreviewed';
	String get scheduled => 'Scheduled';
	String get all => 'All';
	String get order => 'Order';
	String get random_random => 'Random';
	String get scheduled_date_desc => 'Latest scheduled';
	String get scheduled_date_asc => 'Oldest scheduled';
	String get empty => 'There are no review questions.';
	String get memorize => 'Reminder';
	String get set_review => 'Set Review';
	String get scheduled_date => 'Scheduled Date';
	String get interval => 'Review Interval';
	String get destroy => 'Cancel the review schedule';
	String get tomorrow => 'Tomorrow';
	String get after_3_days => '3 days later';
	String get after_a_week => 'A week later';
	String get after_2_week => '2 weeks later';
	String get after_3_week => '3 weeks later';
	String get after_a_month => 'A month later';
	String get after_2_month => '2 months later';
	String get after_3_month => '3 months later';
	String get after_6_month => '6 months later';
	String get after_a_year => 'A year later';
	String review_for({required Object interval}) => 'Review ${interval}';
	String has_been_set_for({required Object interval}) => 'The review has been set for ${interval}';
	String get schedule_canceled => 'Review schedule canceled.';
	String get cancel_all_schedules => 'Cancel All Review Schedules';
	String get all_schedules_canceled => 'All review schedules cancelled.';
	String get details_of_the_question => 'Details of the question to be reviewed';
	String get error_occurred => 'An error about this review occurred.';
	String get fix_error => 'Fix error';
	String get error_fixed => 'Error fixed.';
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
	String get http_status_400 => '400 Bad Request: Invalid request.';
	String get http_status_401 => '401 Unauthorized: No access rights or authentication failed.';
	String get http_status_402 => '402 Payment Required: Sorry, but the requested resource requires payment before it can be accessed. Please check your account status';
	String get http_status_403 => '403 Forbidden: Sorry, but you do not have permission to access this resource. Please contact the administrator if you think this is a mistake.';
	String get http_status_404 => '404 Not Found: Sorry, but the resource you requested could not be found on this server.';
	String get http_status_405 => '405 Method Not Allowed: Sorry, but the HTTP method used in the request is not allowed for the resource.';
	String get http_status_406 => '406 Not Acceptable: Sorry, but the server cannot provide a response that satisfies your Accept headers. Please modify your request and try again.';
	String get http_status_407 => '407 Proxy Authentication Required: Sorry, but you need to authenticate yourself with the proxy server first. Please login to continue.';
	String get http_status_408 => '408 Request Timeout: Sorry, your request timed out. Please check your network connection and try again.';
	String get http_status_409 => '409 Conflict: Sorry, but there was a conflict with the requested operation. Please check your input and try again.';
	String get http_status_410 => '410 Gone: Sorry, but the requested resource is no longer available on this server and no forwarding address is known.';
	String get http_status_411 => '411 Length Required: Sorry, but the server requires a valid Content-Length header field in the request. Please include it and try again.';
	String get http_status_412 => '412 Precondition Failed: Sorry, but one or more preconditions you gave in the request header fields evaluated to false.';
	String get http_status_413 => '413 Payload Too Large: Sorry, but the request entity is larger than the server is willing or able to process.';
	String get http_status_414 => '414 URI Too Long: Sorry, but the URI provided was too long for the server to process. Please shorten it and try again.';
	String get http_status_415 => '415 Unsupported Media Type: Sorry, but the server does not support the media type indicated in the request. Please check and try again.';
	String get http_status_416 => '416 Range Not Satisfiable: Sorry, but the client has asked for a portion of the file, but the server cannot supply that portion.';
	String get http_status_417 => '417 Expectation Failed: Sorry, but the expectation given in the Expect request-header field could not be met by the server.';
	String get http_status_418 => '418 I\'m a teapot: Sorry, I\'m a teapot. The requested entity body is short and stout, handle is here, spout is there.';
	String get http_status_421 => '421 Misdirected Request: Sorry, but the request was directed at a server that is not able to produce a response.';
	String get http_status_422 => '422 Unprocessable Entity: Sorry, but the server understands the content type of the request entity and the syntax of the request entity is correct but was unable to process the contained instructions.';
	String get http_status_423 => '423 Locked: Sorry, but the resource that you are trying to access is locked.';
	String get http_status_424 => '424 Failed Dependency: Sorry, but the method could not be performed on the resource because the requested action depended on another action and that action failed.';
	String get http_status_425 => '425 Too Early: Sorry, but the server is unwilling to risk processing a request that might be replayed.';
	String get http_status_426 => '426 Upgrade Required: Sorry, but the client should switch to a different protocol such as TLS/1.0, given in the Upgrade header field.';
	String get http_status_427 => '427 Unassigned: Sorry, but this error code is currently unassigned and cannot be used.';
	String get http_status_428 => '428 Precondition Required: Sorry, but the origin server requires the request to be conditional. Intended to prevent the "lost update" problem.';
	String get http_status_429 => '429 Too Many Requests: Sorry, but you have sent too many requests in a given amount of time. Please try again later.';
	String get http_status_431 => '431 Request Header Fields Too Large: Sorry, but the server is unwilling to process the request because either an individual header field, or all the header fields collectively, are too large.';
	String get http_status_500 => '500 Internal Server Error: Sorry, but something went wrong on our end. Please try again later.';
	String get http_status_501 => '501 Not Implemented: Sorry, but the request method is not implemented. Please check and try again.';
	String get http_status_502 => '502 Bad Gateway: Sorry, but the server received an invalid response from the upstream server. Please try again.';
	String get http_status_503 => '503 Service Unavailable: Sorry, but the server is currently unavailable. Please try again later.';
	String get http_status_504 => '504 Gateway Timeout: The server is currently unable to handle the request due to a temporary overloading or maintenance. Please try again later.';
	String get http_status_505 => '505 HTTP Version Not Supported: Sorry, but the HTTP version used in the request is not supported.';
	String get http_status_506 => '506 Variant Also Negotiates: The server has an internal configuration error. The chosen variant resource is configured to engage in transparent content negotiation itself, and is therefore not a proper end point in the negotiation process.';
	String get http_status_507 => '507 Insufficient Storage: Sorry, but the server is unable to store the representation needed to complete the request.';
	String get http_status_508 => '508 Loop Detected: The server detected an infinite loop while processing the request. This status indicates that the entire operation failed.';
	String get http_status_510 => '510 Not Extended: Further extensions to the request are required for the server to fulfill it.';
	String get http_status_511 => '511 Network Authentication Required: You need to authenticate to gain network access. Please connect to the network and try again.';
}

// Path: drills
class _TranslationsDrillsEn {
	_TranslationsDrillsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get drills => 'Drills';
	String get unsolved => 'Unsolved';
	String get solved => 'Solved';
	String get search => 'Search Quizzes';
	String get pending_requests => 'Pending Requests';
	String get accepted_requests => 'Accepted Requests';
	String get create_drill => 'Create drill';
	String get create_drill_with_csv => 'Create drill with CSV';
	String get edit_drill => 'Edit drill';
	String get edit_drill_with_csv => 'Edit drill with csv';
	String get csv_blank => 'Please attach a CSV file.';
	String get please_wait => 'Creating drill. Please wait for 10 seconds.';
	String get created_at_asc => 'From the beginning';
	String get created_at_desc => 'From the end';
	String get random_random => 'Random';
}

// Path: weaknesses
class _TranslationsWeaknessesEn {
	_TranslationsWeaknessesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get weaknesses => 'Weaknesses';
	String get premium_recommendation => 'To solve weak questions, you need to register for a premium plan.';
	String get correct_answer_rate_asc => 'Correct Rate, Low to High';
	String get correct_answer_rate_desc => 'Correct Rate, High to Low';
	String get incorrect_answers_count_desc => 'Incorrect, Most to Least';
	String get incorrect_answers_count_asc => 'Incorrect, Least to Most';
	String get created_at_desc => 'Added, Newest First';
	String get created_at_asc => 'Added, Oldest First';
	String get random_random => 'Random';
}

// Path: users
class _TranslationsUsersEn {
	_TranslationsUsersEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get anonymous_user => 'Anonymous user';
	String get creating_account_succeeded => 'Your account registration has been completed! Welcome to DiQt!';
	String get show => 'User Page';
	String get menu => 'Menu';
	String get find_users => 'Find users';
	String get contract_details => 'Contract details';
	String get edit => 'Account Setting';
	String get withdraw => 'Withdraw from DiQt';
	String get withdraw_confirmation => 'The account will be deleted. Deleted accounts cannot be restored again. Are you sure you still want to do this?';
	String get set_icon => 'Set the icon';
	String get name => 'Name';
	String get profile => 'Profile';
	String get profile_placeholder => 'Please enter a profile of no more than 500 characters.';
	String get lang_number => 'Language Setting(mother tongue)';
	String get learning_lang_number => 'Learning Language';
	String get time_zone_name => 'Time Zone';
	String get you_cant_change_time_zone => 'You can not change TimeZone if you have already answered a quiz today. Please try tomorrow.';
	String get authentication => 'Authentication';
	String get email => 'Email';
	String get new_password => 'New Password';
	String get new_password_placeholder => 'At least 6 alphanumeric characters';
	String get new_password_confirmation => 'Password Confirmation';
	String get new_password_confirmation_placeholder => 'Please enter a new password again';
	String get recommend_setting_password => 'Please set a password so that you can also log in via your email address. Unless you set a password, you will not be able to update your account information.';
	String get mail_delivered => 'Receive email notifications';
	String get updated => 'Account Updated.';
	String get failed_to_update => 'Account could not be updated.';
	String get destroyed => 'Your membership withdrawal has been completed. Thank you very much for using DiQt.';
	String get drills => 'Created Drills';
}

// Path: schools
class _TranslationsSchoolsEn {
	_TranslationsSchoolsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get schools => 'Schools';
	String get school => 'School';
	String get name => 'Name';
	String get name_placeholder => 'Enter school name';
	String get members => 'Members';
	String get create_member => 'Create member';
	String get edit_member => 'Edit member';
	String get invite_member => 'Invite member';
	String get invite => 'Invite';
	String get remove => 'Remove';
	String get invitation_limited => 'You need to increase the number of members to invite new members.';
	String get invitation_succeeded => 'Invitation succeeded.';
	String get removal_succeeded => 'Removal succeeded.';
	String get owner => 'Founder';
	String get admin => 'Admin';
	String get moderator => 'Moderator';
	String get member => 'Member';
}

// Path: notices
class _TranslationsNoticesEn {
	_TranslationsNoticesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get notifications => 'Notifications';
	String cheered_message({required Object name}) => '${name} has cheered you!';
	String followed_message({required Object name}) => '${name} has followed you!';
	String get word_request_accepted_message => 'Your dictionary edit has been adopted!';
}

// Path: shared
class _TranslationsSharedEn {
	_TranslationsSharedEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get create => 'Create';
	String get create_succeeded => 'Created';
	String get create_failed => 'Create failed';
	String get edit => 'Edit';
	String get update => 'Update';
	String get update_succeeded => 'Updated';
	String get update_failed => 'Update failed';
	String get destroy => 'Destroy';
	String get destroy_confirmation => 'Confirmation';
	String get destroy_confirmation_description => 'Are you sure you want to delete it?';
	String get destroy_succeeded => 'Destroyed';
	String get cancel => 'Cancel';
	String get reload => 'Reload';
	String get search => 'Search';
	String get generate => 'Generate';
	String get send => 'Send';
	String get set_up => 'Set Up';
	String get undefined => 'Undefined';
	String get details => 'Details';
	String get view_details => 'View Details';
	String get view_more => 'View More';
	String please_enter({required Object name}) => 'Please enter "${name}"';
	String no_more_items({required Object name}) => 'All ${name} loaded';
	String no_items_found({required Object name}) => 'No ${name} found';
	String get premium_recommendation => 'To use this function, you need to register for a premium plan.';
	String get login_recommendation => 'To use this function, you need to log in.';
	String get processing => 'Processing';
	String get done => 'Done';
	String get download => 'Download';
	String get dictionary_setting => 'Dictionary Setting';
	String get thumbnail => 'Thumbnail';
	String get remove_thumbnail => 'Remove Thumbnail';
	String image_alt({required Object name}) => 'Image of ${name}';
	String get error_occurred => 'An error occurred.';
	String get fix_error => 'Fix error';
	String get error_fixed => 'Error fixed.';
}

// Path: answerSettings
class _TranslationsAnswerSettingsEn {
	_TranslationsAnswerSettingsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Answer & Review Setting';
	String get answer_setting => 'Answer Setting';
	String get daily_goal => 'Daily target';
	String get daily_goal_description => 'Set a target number of answers per day.';
	String get daily_goal_cant_be_changed => 'The target cannot be changed as it has already been achieved today.';
	String get question_cover => 'Question Cover';
	String get question_cover_description => 'Questions where the question text is read out loud, and a sheet can be displayed to hide the question text. Mainly useful for strengthening listening skills.';
	String get choices_cover => 'Choices Cover';
	String get choices_cover_description => 'In choice questions, you can display a sheet that hides the choices.';
	String get strict_solving_mode => 'Strict Answer Mode';
	String get strict_solving_mode_description => 'Unanswered questions in the question booklet are only marked as answered if they are answered correctly, not just answered.';
	String get se_enabled => 'Sound Effects';
	String get se_enabled_description => 'If you find level-up and other sound effects too noisy, turn them off.';
	String get effect_enabled => 'Display rewards and feedbacks';
	String get effect_enabled_description => 'If the rewards and feedback for solving questions seem intrusive, turn it off.';
	String get review_setting => 'Review Setting';
	String get strict_reviewing_mode => 'Strict Review Mode';
	String get strict_reviewing_mode_description => 'The condition for removing a question from the unreviewed is only if it is answered correctly, not just answered.';
	String get initial_interval => 'Initial Interval';
	String get initial_interval_description => 'You can decide the interval between review sessions, which are set automatically when you press the \'Remember\' button or make a mistake on a question.';
	String get interval_step_up_condition => 'Conditions for extending intervals';
	String get interval_step_up_condition_description => 'Determine the conditions for extending the intervals between reviews.';
	String get interval_step_up_condition_1 => 'If you answer correctly';
	String get interval_step_up_condition_2 => 'Two correct answers in a row';
	String get interval_step_up_condition_3 => 'Three correct answers in a row';
	String get interval_step_up_condition_4 => 'Four correct answers in a row';
	String get interval_step_up_condition_5 => 'Five correct answers in a row';
	String get review_delete_condition => 'Review release conditions';
	String get review_delete_condition_description => 'You can determine the conditions under which the review is removed.';
	String get review_delete_condition_0 => 'Correct in the next day\'s review';
	String get review_delete_condition_1 => 'Correct in three days\' review';
	String get review_delete_condition_2 => 'Correct in a week\'s review';
	String get review_delete_condition_3 => 'Correct in two weeks\' review';
	String get review_delete_condition_4 => 'Correct in three weeks\' review';
	String get review_delete_condition_5 => 'Correct in a month\'s review';
	String get review_delete_condition_6 => 'Correct in two months\' review';
	String get review_delete_condition_7 => 'Correct in three months\' review';
	String get review_delete_condition_8 => 'Correct in six months\' review';
	String get review_delete_condition_9 => 'Correct in a year\'s review';
	String get weakness_setting => 'Weakness Setting';
	String get weakness_condition => 'Conditions for making it vulnerable';
	String get weakness_condition_description => 'You can decide which conditions to add questions to your difficulties.';
	String get weakness_condition_0 => 'Not set up automatically';
	String get weakness_condition_1 => 'More than one mistake';
	String get weakness_condition_2 => 'More than two mistakes';
	String get weakness_condition_3 => 'More than three mistakes';
	String get weakness_condition_4 => 'More than four mistakes';
	String get weakness_condition_5 => 'More than five mistakes';
	String get overcoming_condition => 'Conditions to overcome';
	String get overcoming_condition_description => 'You can determine the conditions to be removed from the weakness.';
	String get overcoming_condition_0 => 'If you answer it';
	String get overcoming_condition_1 => 'If you answer it correctly';
	String get overcoming_condition_120 => 'Not automatically overcome';
	String overcoming_condition_i({required Object percentage}) => 'Above ${percentage}% correct answer rate';
	String get change_settings => 'Change Settings';
	String get update_succeeded => 'Settings Updated';
	String get update_failed => 'Failed to update configuration.';
	String se_switched({required Object state}) => 'Sound effects turned ${state}.';
	String get review_notification_enabled => 'Review Reminder';
	String get review_notification_enabled_description => 'Notification is sent at a specified time when there are questions to be reviewed that day.';
	String get set_review_notification => 'Set review time';
	String get set_review_notification_description => 'To help you learn more efficiently, we send you reminders when there are questions to review. Set a time when you are available to study.';
	String review_notification_set({required Object hours}) => 'Review reminder set for ${hours}:00.';
}

// Path: answerAnalyses
class _TranslationsAnswerAnalysesEn {
	_TranslationsAnswerAnalysesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get answer_analyses => 'Answer Analyses';
	String get answer_histories => 'Answer Histories';
	String get premium_recommendation => 'To access these features, you need to register for a premium plan.';
	String get correct_answer_rate_asc => 'Correct Rate, Low to High';
	String get correct_answer_rate_desc => 'Correct Rate, High to Low';
	String get incorrect_answer_histories_count_desc => 'Mistakes, Most to Least';
	String get incorrect_answer_histories_count_asc => 'Mistakes, Least to Most';
	String get last_answered_at_desc => 'Answered History, New to Old';
	String get last_answered_at_asc => 'Answered History, Old to New';
}

// Path: achievements
class _TranslationsAchievementsEn {
	_TranslationsAchievementsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get medals_won => 'Medals won';
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
	String translation_restricted({required Object number}) => 'Free users are limited to ${number} translations per day.';
	String deepl_not_supported({required Object language}) => '${language} is not supported by DeepL.';
	String google_not_supported({required Object language}) => '${language} is not supported by Google.';
	String get need_to_login => 'You need to log in to use the translation.';
	String get language => 'Language';
	String get language_setting => 'Language Setting';
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

// Path: chapters
class _TranslationsChaptersEn {
	_TranslationsChaptersEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get lang_number => 'Language Setting';
	String get lang_number_error => '：Auto-configuration failed. Please select language type manually. ';
	String get chapters => 'Chapters';
	String get answers => 'answers';
	String get view_details => 'View Details';
	String get administrators => 'Administrators';
	String get moderators => 'Moderators';
	String get admin_functions => 'Admin Functions';
	String get subscribers_list => 'Subscribers List';
	String get manage_moderators => 'Manage Moderators';
	String get setting => 'Chapter Setting';
	String get setting_updated => 'Chapter setting updated.';
	String get new_section => 'Create Section';
	String get edit_section => 'Edit Section';
	String get drills => 'Drills';
	String get post => 'Create Drill';
	String get view_more => 'View More';
	String get create_drill => 'Create Drill';
	String get subscribe => 'Subscribe';
	String get subscribed => 'Subscribed';
	String get create_chapter => 'Create Chapter';
	String get title_placeholder => 'Please input the name of the chapter.';
	String get introduction => 'Introduction';
	String get introduction_placeholder => 'Please input an explanation about the chapter.';
	String get create => 'Create';
	String get creating_succeeded => 'Creating chapter succeeded';
	String get creating_failed => 'Creating chapter failed.';
	String get drill => 'Drill';
	String get activities => 'Activities';
}

// Path: experiencePoints
class _TranslationsExperiencePointsEn {
	_TranslationsExperiencePointsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String to_the_next_level({required Object points}) => '${points} EXP to the next level.';
}

// Path: sentences
class _TranslationsSentencesEn {
	_TranslationsSentencesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get sentences => 'Sentences';
	String get sentence => 'Sentence';
	String get add => 'Add sentence';
	String get edit => 'Edit sentence';
	String get remove => 'Remove sentence';
	String get destroy => 'Delete sentence';
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
	String get difficulty => 'Difficulty';
	String get easy => 'Easy';
	String get normal => 'Normal';
	String get difficult => 'Difficult';
	String get keeping_form => 'Do not alter keywords';
	String get model => 'AI Type';
	String get gpt_3_5 => 'GPT-3.5（Fast）';
	String get gpt_4 => 'GPT-4（Slow but Clever）';
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
	String no_item_found({required Object keyword}) => 'No example sentences containing "${keyword}" were found.';
	String get review_label => 'Be able to read';
	String get review_label_listening => 'Be able to listen';
	String get reversed_review_label => 'be able to speak';
}

// Path: notes
class _TranslationsNotesEn {
	_TranslationsNotesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get notes => 'Notes';
	String get note => 'Note';
	String get note_placeholder => 'A notebook that only you can view. It can also be used as a hint for the question.';
	String get edit => 'Edit';
	String get update => 'Update';
	String get paywall_message => 'Premium membership gives you access to the Notes function.';
	String get destroy => 'Delete';
	String get confirmation => 'Confirmation';
	String get confirmation_text => 'Are you sure you want to delete this note?';
	String get updated_at_desc => 'Updated, New to Old';
	String get updated_at_asc => 'Updated, Old to New';
	String get created_at_desc => 'Created, New to Old';
	String get created_at_asc => 'Created, Old to New';
}

// Path: ranking
class _TranslationsRankingEn {
	_TranslationsRankingEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get ranking => 'Ranking';
	String get daily => 'Daily';
	String get weekly => 'Weekly';
	String get monthly => 'Monthly';
	String get daily_answerer => 'Daily Answerers Ranking';
	String get weekly_answerer => 'Weekly Answerers Ranking';
	String get monthly_answerer => 'Monthly Answerers Ranking';
	String rank({required Object number}) => 'No.${number}';
}

// Path: timeZone
class _TranslationsTimeZoneEn {
	_TranslationsTimeZoneEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get international_date_line_west => 'International Date Line West';
	String get american_samoa => 'American Samoa';
	String get midway_island => 'Midway Island';
	String get hawaii => 'Hawaii';
	String get alaska => 'Alaska';
	String get pacific_time_us_canada => 'Pacific Time (US & Canada)';
	String get tijuana => 'Tijuana';
	String get arizona => 'Arizona';
	String get mazatlan => 'Mazatlan';
	String get mountain_time_us_canada => 'Mountain Time (US & Canada)';
	String get central_america => 'Central America';
	String get central_time_us_canada => 'Central Time (US & Canada)';
	String get chihuahua => 'Chihuahua';
	String get guadalajara => 'Guadalajara';
	String get mexico_city => 'Mexico City';
	String get monterrey => 'Monterrey';
	String get saskatchewan => 'Saskatchewan';
	String get bogota => 'Bogota';
	String get eastern_time_us_canada => 'Eastern Time (US & Canada)';
	String get indiana_east => 'Indiana (East)';
	String get lima => 'Lima';
	String get quito => 'Quito';
	String get atlantic_time_canada => 'Atlantic Time (Canada)';
	String get caracas => 'Caracas';
	String get georgetown => 'Georgetown';
	String get la_paz => 'La Paz';
	String get puerto_rico => 'Puerto Rico';
	String get santiago => 'Santiago';
	String get newfoundland => 'Newfoundland';
	String get brasilia => 'Brasilia';
	String get buenos_aires => 'Buenos Aires';
	String get greenland => 'Greenland';
	String get montevideo => 'Montevideo';
	String get mid_atlantic => 'Mid-Atlantic';
	String get azores => 'Azores';
	String get cape_verde_is => 'Cape Verde Is.';
	String get casablanca => 'Casablanca';
	String get dublin => 'Dublin';
	String get edinburgh => 'Edinburgh';
	String get lisbon => 'Lisbon';
	String get london => 'London';
	String get monrovia => 'Monrovia';
	String get utc => 'UTC';
	String get amsterdam => 'Amsterdam';
	String get belgrade => 'Belgrade';
	String get berlin => 'Berlin';
	String get bern => 'Bern';
	String get bratislava => 'Bratislava';
	String get brussels => 'Brussels';
	String get budapest => 'Budapest';
	String get copenhagen => 'Copenhagen';
	String get ljubljana => 'Ljubljana';
	String get madrid => 'Madrid';
	String get paris => 'Paris';
	String get prague => 'Prague';
	String get rome => 'Rome';
	String get sarajevo => 'Sarajevo';
	String get skopje => 'Skopje';
	String get stockholm => 'Stockholm';
	String get vienna => 'Vienna';
	String get warsaw => 'Warsaw';
	String get west_central_africa => 'West Central Africa';
	String get zagreb => 'Zagreb';
	String get zurich => 'Zurich';
	String get athens => 'Athens';
	String get bucharest => 'Bucharest';
	String get cairo => 'Cairo';
	String get harare => 'Harare';
	String get helsinki => 'Helsinki';
	String get jerusalem => 'Jerusalem';
	String get kaliningrad => 'Kaliningrad';
	String get kyiv => 'Kyiv';
	String get pretoria => 'Pretoria';
	String get riga => 'Riga';
	String get sofia => 'Sofia';
	String get tallinn => 'Tallinn';
	String get vilnius => 'Vilnius';
	String get baghdad => 'Baghdad';
	String get istanbul => 'Istanbul';
	String get kuwait => 'Kuwait';
	String get minsk => 'Minsk';
	String get moscow => 'Moscow';
	String get nairobi => 'Nairobi';
	String get riyadh => 'Riyadh';
	String get st_petersburg => 'St. Petersburg';
	String get volgograd => 'Volgograd';
	String get tehran => 'Tehran';
	String get abu_dhabi => 'Abu Dhabi';
	String get baku => 'Baku';
	String get muscat => 'Muscat';
	String get samara => 'Samara';
	String get tbilisi => 'Tbilisi';
	String get yerevan => 'Yerevan';
	String get kabul => 'Kabul';
	String get ekaterinburg => 'Ekaterinburg';
	String get islamabad => 'Islamabad';
	String get karachi => 'Karachi';
	String get tashkent => 'Tashkent';
	String get chennai => 'Chennai';
	String get kolkata => 'Kolkata';
	String get mumbai => 'Mumbai';
	String get new_delhi => 'New Delhi';
	String get sri_jayawardenepura => 'Sri Jayawardenepura';
	String get kathmandu => 'Kathmandu';
	String get almaty => 'Almaty';
	String get astana => 'Astana';
	String get dhaka => 'Dhaka';
	String get urumqi => 'Urumqi';
	String get rangoon => 'Rangoon';
	String get bangkok => 'Bangkok';
	String get hanoi => 'Hanoi';
	String get jakarta => 'Jakarta';
	String get krasnoyarsk => 'Krasnoyarsk';
	String get novosibirsk => 'Novosibirsk';
	String get beijing => 'Beijing';
	String get chongqing => 'Chongqing';
	String get hong_kong => 'Hong Kong';
	String get irkutsk => 'Irkutsk';
	String get kuala_lumpur => 'Kuala Lumpur';
	String get perth => 'Perth';
	String get singapore => 'Singapore';
	String get taipei => 'Taipei';
	String get ulaanbaatar => 'Ulaanbaatar';
	String get osaka => 'Osaka';
	String get sapporo => 'Sapporo';
	String get seoul => 'Seoul';
	String get tokyo => 'Tokyo';
	String get yakutsk => 'Yakutsk';
	String get adelaide => 'Adelaide';
	String get darwin => 'Darwin';
	String get brisbane => 'Brisbane';
	String get canberra => 'Canberra';
	String get guam => 'Guam';
	String get hobart => 'Hobart';
	String get melbourne => 'Melbourne';
	String get port_moresby => 'Port Moresby';
	String get sydney => 'Sydney';
	String get vladivostok => 'Vladivostok';
	String get magadan => 'Magadan';
	String get new_caledonia => 'New Caledonia';
	String get solomon_is => 'Solomon Is.';
	String get srednekolymsk => 'Srednekolymsk';
	String get auckland => 'Auckland';
	String get fiji => 'Fiji';
	String get kamchatka => 'Kamchatka';
	String get marshall_is => 'Marshall Is.';
	String get wellington => 'Wellington';
	String get chatham_is => 'Chatham Is.';
	String get nuku_alofa => 'Nuku\'alofa';
	String get samoa => 'Samoa';
	String get tokelau_is => 'Tokelau Is.';
}

// Path: answer
class _TranslationsAnswerEn {
	_TranslationsAnswerEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String answers_count({required Object count}) => '${count} answers';
	String get limit_reached => 'Limit Reached';
	String limit_reached_description({required Object number}) => 'Free users can anwer up to ${number} questions per day. Become a premium member and answer unlimited questions!';
}

// Path: quizzes
class _TranslationsQuizzesEn {
	_TranslationsQuizzesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get quiz => 'Quiz';
	String get edit => 'Edit';
	String get answer => 'Answer';
	String get see_correct_answer => 'See correct answer';
	String get correct => 'Correct';
	String get wrong => 'Wrong';
	String get got_a_correct => 'Got a correct';
	String get made_a_mistake => 'Made a mistake';
	String get question => 'Question';
	String get question_placeholder => '【Required】Please input a question.';
	String get correct_answer => 'Correct Answer';
	String get correct_answer_placeholder => '【Required】Please input a correct answer.';
	String get distractors => 'Distractors';
	String get distractors_placeholder => 'You can input a distractor.';
	String get explanation => 'Explanation';
	String get explanation_placeholder => 'You can input a explanation.';
	String get hint => 'Hint';
	String get hint_placeholder => 'You can input a hint for the question.';
	String get corrected_time_ago => 'Corrected %{time} ago';
	String get incorrect_time_ago => 'Incorrect %{time} ago';
	String get correct_answer_rate => '%{percent}% of correct answers';
}

// Path: activities
class _TranslationsActivitiesEn {
	_TranslationsActivitiesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get activities => 'Activities';
	String get cheer => 'Cheer!';
	String get cheered => 'Cheered!';
}

// Path: answerHistories
class _TranslationsAnswerHistoriesEn {
	_TranslationsAnswerHistoriesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get answer_histories => 'Answer Histories';
	String get todays_mistakes => 'Today\'s Mistakes';
}

// Path: wordRequests
class _TranslationsWordRequestsEn {
	_TranslationsWordRequestsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get word_requests => 'Edit histories of dictionaries';
	String get edit_histories => 'Edit Histories';
	String get pending_edits => 'Pending Edits';
	String get rejected_edits => 'Rejected Edits';
	String get edit_applied => 'Your edit applied.';
	String get addition_request_submitted => 'Your addition request submitted.';
	String get modification_request_submitted => 'Your modification request submitted.';
	String get elimination_request_submitted => 'Your elimination request submitted.';
	String get already_submitted => 'You have already submitted a request.';
	String get addition => 'Addition of item';
	String get modification => 'Modification of item';
	String get elimination => 'Deletion of item';
	String get acceptance => 'Adopted';
	String get rejection => 'Rejected';
	String get pending => 'Pending';
	String get accept => 'Adopt';
	String get reject => 'Reject';
	String get editor_comment => 'Editor\'s comment';
	String get comments => 'Comments';
	String get cancel => 'Withdraw an request';
	String get canceled => 'The request has been withdrawn.';
	String get target => 'Edit Target';
	String get target_already_deleted => 'The edit target has already been deleted.';
	String get target_not_found => 'The edit target was not found.';
	String get show_heading => 'Request details';
	String get accepted => 'The request has been adopted.';
	String get rejected => 'The request has been rejected.';
	String edited_at({required Object time}) => 'Edited ${time} ago';
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
	String get pos_tag_id => 'Part of speech';
	String get meaning => 'Meaning';
	String get ipa => 'IPA(Pronunciation)';
	String get search_sentence => 'Search Example Sentences';
	String get search_sentence_placeholder => 'Please enter keywords.';
	String get no_sentence => 'No example sentence is set.';
	String get set_sentence_with_ai => 'Set an example sentence with AI';
	String get generate_meaning_with_ai => 'Generate meanings with AI';
	String get meaning_generation_keyword_placeholder => 'keywords to generate the meaning.';
	String get success_to_generate_meanings => 'Successful generation of meanings.';
	String get failed_to_generate_meanings => 'Generation of meanings failed.';
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

// Path: purchase
class _TranslationsPurchaseEn {
	_TranslationsPurchaseEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get premium_plan => 'Premium Plan';
	String get premium_plan_description => 'This plan allows unlimited use of all DiQt features.';
	String get trial_period_description => 'Now with a 2-week free trial period!';
	String get free_plan => 'Free';
	String get yen => 'Yen';
	String get answers_limit => 'Number of answers per day';
	String get unlimited => 'Unlimited';
	String get translations_limit => 'Number of translations per day';
	String get ad_free => 'Ad-free';
	String get weakness => 'The Weakness Questions';
	String get note => 'Notes';
	String get answer_analysis => 'Answer Analyses';
	String get answer_history => 'Answer histories';
	String get questions_you_got_wrong => 'Questions you got wrong today';
	String get deletion_of_all_reviews => 'Deletion of all reviews';
	String get monthly_plan => 'Monthly';
	String get month => 'Month';
	String get annual_plan => 'Annual';
	String get year => 'Year';
	String get two_months_free => '2 months\' savings!';
	String get start_free_trial => 'Start Free Trial';
	String get get_started => 'Get Started';
	String get registered => 'Registered';
	String get bank_transfer => 'If you wish to make a bank transfer, please click here';
	String get stripe_explanation => 'We use Stripe for payments - Stripe is a secure payment system widely used around the world and we do not store your card details on our servers.';
	String get auto_renew_explanation => 'Plans are auto-renewing. If you cancel via payment settings at least 24 hours before the expiry date, your plan will not be auto-renewed.';
	String get this_is_premium_plan_feature => 'This is a feature for premium members.';
	String get all_features_will_be_available => 'All features will be available.';
	String get notice => 'Seven days\' notice before the charge is made.';
	String get cancel_at_any_time => 'You can cancel at any time.';
	String get monthly_plan_price => '¥500／Month';
	String get annual_plan_price => '¥5,000／Year';
	String get purchase_succeded => 'You are now a premium member!';
	String get view_premium_plan_benefits => 'View Premium Plan benefits';
	String get view_premium_plan => 'View Premium Plan';
	String get premium_plan_benefits => 'Premium Plan Benefits';
	String get unlimited_answers => 'Unlimited Answers';
	String unlimited_answers_description({required Object number}) => 'Free users can only answer ${number} questions daily, but as a premium member, you can answer as many questions as you like in a day.';
	String get unlimited_translations => 'Unlimited Translations';
	String unlimited_translations_description({required Object number}) => 'Free users can only translate ${number} times a day, but premium members can translate as many times a day as they like.';
	String get weakness_description => 'Premium members can focus on questions with low percentage of correct answers.';
	String get note_description => 'Premium members will be able to leave notes on answered questions.';
	String get answer_analysis_description => 'Premium members can analyze the questions they have answered by the percentage of correct answers and the number of mistakes.';
	String get answer_history_description => 'If you are a premium member, you can view the history of questions you have answered.';
	String get questions_you_got_wrong_description => 'If you are a premium member, you can review the questions you got wrong that day.';
	String get deletion_of_all_reviews_description => 'If you are a premium member, you can cancel all the reviews you have set up.';
	String get ad_free_description => 'If you are a premium member, you will no longer see all adverts in the app.';
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
	String get inquiry => 'Inquiry';
	String get maintenance_mode => 'Under maintenance';
	String get maintenance_description => 'We are very sorry. DiQt is currently undergoing maintenance. We hope you will be able to access it again in a while.';
	String get maintenance_latest_information => 'Click here for the latest information.';
}

// Path: drillLaps
class _TranslationsDrillLapsEn {
	_TranslationsDrillLapsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get resume => 'Resume';
	String get view_more => 'View More';
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
	@override late final _TranslationsReviewsJa reviews = _TranslationsReviewsJa._(_root);
	@override late final _TranslationsErrorsJa errors = _TranslationsErrorsJa._(_root);
	@override late final _TranslationsDrillsJa drills = _TranslationsDrillsJa._(_root);
	@override late final _TranslationsWeaknessesJa weaknesses = _TranslationsWeaknessesJa._(_root);
	@override late final _TranslationsUsersJa users = _TranslationsUsersJa._(_root);
	@override late final _TranslationsSchoolsJa schools = _TranslationsSchoolsJa._(_root);
	@override late final _TranslationsNoticesJa notices = _TranslationsNoticesJa._(_root);
	@override late final _TranslationsSharedJa shared = _TranslationsSharedJa._(_root);
	@override late final _TranslationsAnswerSettingsJa answerSettings = _TranslationsAnswerSettingsJa._(_root);
	@override late final _TranslationsAnswerAnalysesJa answerAnalyses = _TranslationsAnswerAnalysesJa._(_root);
	@override late final _TranslationsAchievementsJa achievements = _TranslationsAchievementsJa._(_root);
	@override late final _TranslationsLangJa lang = _TranslationsLangJa._(_root);
	@override late final _TranslationsChaptersJa chapters = _TranslationsChaptersJa._(_root);
	@override late final _TranslationsExperiencePointsJa experiencePoints = _TranslationsExperiencePointsJa._(_root);
	@override late final _TranslationsSentencesJa sentences = _TranslationsSentencesJa._(_root);
	@override late final _TranslationsNotesJa notes = _TranslationsNotesJa._(_root);
	@override late final _TranslationsRankingJa ranking = _TranslationsRankingJa._(_root);
	@override late final _TranslationsTimeZoneJa timeZone = _TranslationsTimeZoneJa._(_root);
	@override late final _TranslationsAnswerJa answer = _TranslationsAnswerJa._(_root);
	@override late final _TranslationsQuizzesJa quizzes = _TranslationsQuizzesJa._(_root);
	@override late final _TranslationsActivitiesJa activities = _TranslationsActivitiesJa._(_root);
	@override late final _TranslationsAnswerHistoriesJa answerHistories = _TranslationsAnswerHistoriesJa._(_root);
	@override late final _TranslationsWordRequestsJa wordRequests = _TranslationsWordRequestsJa._(_root);
	@override late final _TranslationsCalendarsJa calendars = _TranslationsCalendarsJa._(_root);
	@override late final _TranslationsLayoutsJa layouts = _TranslationsLayoutsJa._(_root);
	@override late final _TranslationsDictionaryMapsJa dictionaryMaps = _TranslationsDictionaryMapsJa._(_root);
	@override late final _TranslationsWordsJa words = _TranslationsWordsJa._(_root);
	@override late final _TranslationsPurchaseJa purchase = _TranslationsPurchaseJa._(_root);
	@override late final _TranslationsHomeJa home = _TranslationsHomeJa._(_root);
	@override late final _TranslationsDrillLapsJa drillLaps = _TranslationsDrillLapsJa._(_root);
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
	@override String get reversed_sentence_drill => 'スピーキングとライティングのための例文問題';
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

// Path: reviews
class _TranslationsReviewsJa implements _TranslationsReviewsEn {
	_TranslationsReviewsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get reviews => '復習';
	@override String get unreviewed => '未復習';
	@override String get scheduled => '予定';
	@override String get all => 'すべて';
	@override String get order => '順番';
	@override String get random_random => 'ランダム';
	@override String get scheduled_date_desc => '予定日が新しい順';
	@override String get scheduled_date_asc => '予定日が古い順';
	@override String get empty => '復習問題はありません。';
	@override String get memorize => '覚える';
	@override String get set_review => '復習を設定する';
	@override String get scheduled_date => '復習予定日';
	@override String get interval => '復習の間隔';
	@override String get destroy => '復習予定を取り消す';
	@override String get tomorrow => '翌日';
	@override String get after_3_days => '3日後';
	@override String get after_a_week => '1週間後';
	@override String get after_2_week => '2週間後';
	@override String get after_3_week => '3週間後';
	@override String get after_a_month => '1ヶ月後';
	@override String get after_2_month => '2ヶ月後';
	@override String get after_3_month => '3ヶ月後';
	@override String get after_6_month => '6ヶ月後';
	@override String get after_a_year => '1年後';
	@override String review_for({required Object interval}) => '${interval}に復習する';
	@override String has_been_set_for({required Object interval}) => '${interval}に復習を設定しました。';
	@override String get schedule_canceled => '復習予定を取り消しました。';
	@override String get cancel_all_schedules => 'すべての復習予定を取り消す';
	@override String get all_schedules_canceled => 'すべての復習予定を取り消しました。';
	@override String get details_of_the_question => '復習する問題の詳細';
	@override String get error_occurred => '復習にエラーが発生しました。';
	@override String get fix_error => 'エラーを修正する';
	@override String get error_fixed => 'エラーを修正しました。';
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
	@override String get http_status_400 => '400 Bad Request: 無効なリクエストです';
	@override String get http_status_401 => '401 Unauthorized: アクセス権が無いか、あるいは認証に失敗しました。';
	@override String get http_status_402 => '402 Payment Required: 申し訳ありませんが、要求されたリソースにアクセスする前に支払いが必要です。アカウントの状態を確認してください。';
	@override String get http_status_403 => '403 Forbidden: 申し訳ありませんが、このリソースにアクセスする権限がありません。これが間違いだと思う場合は、管理者に連絡してください。';
	@override String get http_status_404 => '404 Not Found: 申し訳ありませんが、要求されたリソースはこのサーバー上に見つかりませんでした。';
	@override String get http_status_405 => '405 Method Not Allowed: 申し訳ありませんが、リクエストで使用されたHTTPメソッドは、リソースに対して許可されていません。';
	@override String get http_status_406 => '406 Not Acceptable: 申し訳ありませんが、サーバーはあなたのAcceptヘッダーを満足させるレスポンスを提供できません。リクエストを修正して再試行してください。';
	@override String get http_status_407 => '407 Proxy Authentication Required: 申し訳ありませんが、まずプロキシサーバーで自分を認証する必要があります。続行するにはログインしてください。';
	@override String get http_status_408 => '408 Request Timeout: 申し訳ありません、リクエストがタイムアウトしました。ネットワーク接続を確認して、もう一度試してください。';
	@override String get http_status_409 => '409 Conflict: 申し訳ありませんが、要求された操作との間に競合がありました。入力を確認して再試行してください。';
	@override String get http_status_410 => '410 Gone: 申し訳ありませんが、要求されたリソースはこのサーバー上で利用できなくなり、転送先のアドレスは不明です。';
	@override String get http_status_411 => '411 Length Required: 申し訳ありませんが、サーバーはリクエストに有効なContent-Lengthヘッダーフィールドを必要とします。それを含めて再試行してください。';
	@override String get http_status_412 => '412 Precondition Failed: 申し訳ありませんが、リクエストヘッダーフィールドで指定した1つ以上の前提条件が偽と評価されました。';
	@override String get http_status_413 => '413 Payload Too Large: 申し訳ありませんが、リクエストエンティティがサーバーが処理する能力を超えています。';
	@override String get http_status_414 => '414 URI Too Long: 申し訳ありませんが、提供されたURIはサーバーが処理するには長すぎます。短くしてから再試行してください。';
	@override String get http_status_415 => '415 Unsupported Media Type: 申し訳ありませんが、サーバーはリクエストで示されたメディアタイプをサポートしていません。確認してから再試行してください。';
	@override String get http_status_416 => '416 Range Not Satisfiable: 申し訳ありませんが、クライアントがファイルの一部を求めていますが、サーバーはその部分を提供できません。';
	@override String get http_status_417 => '417 Expectation Failed: 申し訳ありませんが、Expectリクエストヘッダーフィールドで指定した期待値はサーバーでは満たすことができませんでした。';
	@override String get http_status_418 => '418 I\'m a teapot: Sorry, 申し訳ありません、私はティーポットです。要求されたエンティティボディは短くてずんぐりむっくりしていて、取っ手はここ、注ぎ口はそこです。';
	@override String get http_status_421 => '421 Misdirected Request: 申し訳ありませんが、リクエストはレスポンスを生成できないサーバーに向けられました。';
	@override String get http_status_422 => '422 Unprocessable Entity: 申し訳ありませんが、サーバーはリクエストエンティティのコンテンツタイプを理解し、リクエストエンティティの構文も正しいのですが、含まれている指示を処理することができませんでした。';
	@override String get http_status_423 => '423 Locked: 申し訳ありませんが、アクセスしようとしているリソースはロックされています。';
	@override String get http_status_424 => '424 Failed Dependency: 申し訳ありませんが、要求されたアクションが別のアクションに依存していてそのアクションが失敗したため、リソースに対してメソッドを実行することができませんでした。';
	@override String get http_status_425 => '425 Too Early: 申し訳ありませんが、サーバーはリプレイされる可能性のあるリクエストを処理するリスクを冒したくありません。';
	@override String get http_status_426 => '426 Upgrade Required: 申し訳ありませんが、クライアントはUpgradeヘッダーフィールドで指定されているTLS/1.0などの別のプロトコルに切り替える必要があります。';
	@override String get http_status_427 => '427 Unassigned: 申し訳ありませんが、このエラーコードは現在割り当てられておらず、使用することはできません。';
	@override String get http_status_428 => '428 Precondition Required: 申し訳ありませんが、オリジンサーバーはリクエストが条件付きであることを要求しています。これは「ロストアップデート」問題を防ぐためのものです。';
	@override String get http_status_429 => '429 Too Many Requests: 申し訳ありませんが、指定された時間内に送信されるリクエストが多すぎます。後でもう一度お試しください。';
	@override String get http_status_431 => '431 Request Header Fields Too Large: 申し訳ありませんが、個々のヘッダーフィールドやすべてのヘッダーフィールドがまとめて大きすぎるため、サーバーはリクエストを処理することを拒否しています。';
	@override String get http_status_500 => '500 Internal Server Error: 申し訳ありません、サーバー側に何か問題が発生しました。後ほどもう一度お試しください。';
	@override String get http_status_501 => '501 Not Implemented: 申し訳ありませんが、リクエストメソッドは実装されていません。確認して再試行してください。';
	@override String get http_status_502 => '502 Bad Gateway: 申し訳ありませんが、サーバーは上流のサーバーから無効な応答を受け取りました。再試行してください。';
	@override String get http_status_503 => '503 Service Unavailable: 申し訳ありませんが、現在サーバーは利用できません。後ほど再試行してください。';
	@override String get http_status_504 => '504 Gateway Timeout: 一時的な過負荷またはメンテナンスのため、現在サーバーはリクエストを処理できません。後ほど再試行してください。';
	@override String get http_status_505 => '505 HTTP Version Not Supported: 申し訳ありませんが、リクエストで使用されるHTTPのバージョンはサポートされていません。';
	@override String get http_status_506 => '506 Variant Also Negotiates: サーバーに内部構成エラーがあります。選択されたバリアントリソースが透過的コンテンツネゴシエーション自体を行うよう設定されているため、ネゴシエーションプロセスの適切な終点ではありません。';
	@override String get http_status_507 => '507 Insufficient Storage: 申し訳ありませんが、サーバーはリクエストを完了するために必要な表現を保存できません。';
	@override String get http_status_508 => '508 Loop Detected: サーバーは、リクエストを処理中に無限ループを検出しました。このステータスは、操作全体が失敗したことを示しています。';
	@override String get http_status_510 => '510 Not Extended: サーバーがリクエストを満たすためには、リクエストにさらなる拡張が必要です。';
	@override String get http_status_511 => '511 Network Authentication Required: ネットワークにアクセスするためには認証が必要です。ネットワークに接続して再試行してください。';
}

// Path: drills
class _TranslationsDrillsJa implements _TranslationsDrillsEn {
	_TranslationsDrillsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get drills => 'ドリル';
	@override String get unsolved => '未解答';
	@override String get solved => '解答済';
	@override String get search => '問題を検索する';
	@override String get pending_requests => '審査中のリクエスト';
	@override String get accepted_requests => '承認済のリクエスト';
	@override String get create_drill => 'ドリルを作成する';
	@override String get create_drill_with_csv => 'ドリルをCSVで作成する';
	@override String get edit_drill => 'ドリルを編集する';
	@override String get edit_drill_with_csv => 'CSVでドリルを編集する';
	@override String get csv_blank => 'CSVファイルを添付してください。';
	@override String get please_wait => '作成を開始しました。10秒ほどで出来上がります。';
	@override String get created_at_asc => '最初から';
	@override String get created_at_desc => '最後から';
	@override String get random_random => 'ランダム';
}

// Path: weaknesses
class _TranslationsWeaknessesJa implements _TranslationsWeaknessesEn {
	_TranslationsWeaknessesJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get weaknesses => '弱点問題';
	@override String get premium_recommendation => '弱点問題を解くには、プレミアムプランへの登録が必要です。';
	@override String get correct_answer_rate_asc => '正答率が低い順';
	@override String get correct_answer_rate_desc => '正答率が高い順';
	@override String get incorrect_answers_count_desc => '不正解が多い順';
	@override String get incorrect_answers_count_asc => '不正解が少ない順';
	@override String get created_at_desc => '追加日が新しい順';
	@override String get created_at_asc => '追加日が古い順';
	@override String get random_random => 'ランダム';
}

// Path: users
class _TranslationsUsersJa implements _TranslationsUsersEn {
	_TranslationsUsersJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get anonymous_user => '匿名ユーザー';
	@override String get creating_account_succeeded => '会員登録が完了しました！ようこそDiQtへ！！';
	@override String get show => 'ユーザーページ';
	@override String get menu => 'メニュー';
	@override String get find_users => 'ユーザーを探す';
	@override String get contract_details => 'ご契約内容';
	@override String get edit => 'アカウント設定';
	@override String get withdraw => 'DiQtから退会する';
	@override String get withdraw_confirmation => 'アカウントを削除いたします。削除したアカウントは二度と復元できません。それでもよろしいですか？';
	@override String get set_icon => 'アイコンを設定する';
	@override String get name => 'ユーザー名';
	@override String get profile => 'プロフィール';
	@override String get profile_placeholder => '500文字以内でプロフィールを入力してください。';
	@override String get lang_number => '言語設定(母語)';
	@override String get learning_lang_number => '学習言語';
	@override String get time_zone_name => 'タイムゾーン';
	@override String get you_cant_change_time_zone => '今日すでに問題に解答してしまっている場合、 タイムゾーンを変更することはできません。明日以降にお試しください。';
	@override String get authentication => '認証設定';
	@override String get email => 'メールアドレス';
	@override String get new_password => '新しいパスワード';
	@override String get new_password_placeholder => '半角英数字６文字以上';
	@override String get new_password_confirmation => 'パスワード確認';
	@override String get new_password_confirmation_placeholder => 'もう一度パスワードを入力してください。';
	@override String get recommend_setting_password => 'メールアドレスからもログインできるように、パスワードを設定してください。パスワードを設定しない限り、アカウントの情報を更新することはできません。';
	@override String get mail_delivered => 'メールによる通知を受け取る';
	@override String get updated => 'アカウントを更新しました。';
	@override String get failed_to_update => 'アカウントを更新できませんでした。';
	@override String get destroyed => '退会が完了しました。ご利用いただき、誠にありがとうございました。';
	@override String get drills => '作成したドリル';
}

// Path: schools
class _TranslationsSchoolsJa implements _TranslationsSchoolsEn {
	_TranslationsSchoolsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get schools => '教室';
	@override String get school => '教室';
	@override String get name => '名前';
	@override String get name_placeholder => '教室名を入力してください';
	@override String get members => 'メンバー';
	@override String get create_member => 'メンバーを作成する';
	@override String get edit_member => 'メンバーを編集する';
	@override String get invite_member => 'メンバーを招待する';
	@override String get invite => '招待する';
	@override String get remove => '除名する';
	@override String get invitation_limited => '新たにメンバーを招待するには、メンバーの上限数を増やしてください。';
	@override String get invitation_succeeded => '招待に成功しました。';
	@override String get removal_succeeded => '除名に成功しました。';
	@override String get owner => '創設者';
	@override String get admin => '管理者';
	@override String get moderator => 'モデレーター';
	@override String get member => 'メンバー';
}

// Path: notices
class _TranslationsNoticesJa implements _TranslationsNoticesEn {
	_TranslationsNoticesJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get notifications => '通知';
	@override String cheered_message({required Object name}) => '${name}があなたを応援しました！';
	@override String followed_message({required Object name}) => '${name}があなたをフォローしました！';
	@override String get word_request_accepted_message => 'あなたの辞書の編集が採用されました！';
}

// Path: shared
class _TranslationsSharedJa implements _TranslationsSharedEn {
	_TranslationsSharedJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get create => '作成する';
	@override String get create_succeeded => '作成されました。';
	@override String get create_failed => '作成に失敗しました。';
	@override String get edit => '編集する';
	@override String get update => '更新する';
	@override String get update_succeeded => '更新されました。';
	@override String get update_failed => '更新に失敗しました。';
	@override String get destroy => '削除する';
	@override String get destroy_confirmation => '確認';
	@override String get destroy_confirmation_description => '本当に削除してもよろしいですか？';
	@override String get destroy_succeeded => '削除しました。';
	@override String get cancel => 'キャンセルする';
	@override String get reload => '再読み込みする';
	@override String get search => '検索する';
	@override String get generate => '生成する';
	@override String get send => '送信する';
	@override String get set_up => '設定する';
	@override String get undefined => '未定義';
	@override String get details => '詳細';
	@override String get view_details => '詳細を見る';
	@override String get view_more => 'もっと見る';
	@override String please_enter({required Object name}) => '"${name}"を入力してください。';
	@override String no_more_items({required Object name}) => 'すべての${name}を読み込みました';
	@override String no_items_found({required Object name}) => '${name}がありません';
	@override String get premium_recommendation => 'この機能を利用するには、プレミアムプランへの登録が必要です。';
	@override String get login_recommendation => 'この機能を利用するためには、ログインが必要です。';
	@override String get processing => '処理中...';
	@override String get done => '完了';
	@override String get download => 'ダウンロード';
	@override String get dictionary_setting => '辞書設定';
	@override String get thumbnail => 'サムネイル';
	@override String get remove_thumbnail => 'サムネイルを削除する';
	@override String image_alt({required Object name}) => '${name}の画像';
	@override String get error_occurred => 'エラーが発生しました。';
	@override String get fix_error => 'エラーを修正する';
	@override String get error_fixed => 'エラーを修正しました。';
}

// Path: answerSettings
class _TranslationsAnswerSettingsJa implements _TranslationsAnswerSettingsEn {
	_TranslationsAnswerSettingsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '解答・復習設定';
	@override String get answer_setting => '解答設定';
	@override String get daily_goal => '1日の目標';
	@override String get daily_goal_description => '1日の目標解答数の目標を定めてください。';
	@override String get daily_goal_cant_be_changed => '本日すでに目標を達成してしまったので、目標を変更できません。';
	@override String get question_cover => '問題文カバー';
	@override String get question_cover_description => '問題文が読み上げられる問題で、問題文を隠すシートを表示できます。主にリスニング力の強化に役立ちます。';
	@override String get choices_cover => '選択肢カバー';
	@override String get choices_cover_description => '選択問題で、選択肢を隠すシートを表示できます。';
	@override String get strict_solving_mode => '厳格解答モード';
	@override String get strict_solving_mode_description => '問題集の未解答の問題を、単なる解答ではなく、正解した場合でのみ解答済にします。';
	@override String get se_enabled => '効果音を鳴らす';
	@override String get se_enabled_description => 'レベルアップなどの効果音がうるさいと感じたらOFFにしてください。';
	@override String get effect_enabled => '報酬やフィードバックを表示する';
	@override String get effect_enabled_description => '問題解答時の報酬やフィードバックが邪魔に感じたらOFFにしてください。';
	@override String get review_setting => '復習設定';
	@override String get strict_reviewing_mode => '厳格復習モード';
	@override String get strict_reviewing_mode_description => '復習の未解答から問題を取り除く条件を、単なる解答ではなく、正解した場合のみにします。';
	@override String get initial_interval => '初期間隔';
	@override String get initial_interval_description => '「覚える」ボタンを押したり、問題に間違えたときに、自動で設定される復習の間隔を決められます。';
	@override String get interval_step_up_condition => '間隔を伸ばす条件';
	@override String get interval_step_up_condition_description => '復習の間隔を伸ばすための条件を決めます。';
	@override String get interval_step_up_condition_1 => '正解した場合';
	@override String get interval_step_up_condition_2 => '２回連続で正解した場合';
	@override String get interval_step_up_condition_3 => '３回連続で正解した場合';
	@override String get interval_step_up_condition_4 => '４回連続で正解した場合';
	@override String get interval_step_up_condition_5 => '５回連続で正解した場合';
	@override String get review_delete_condition => '復習の解除条件';
	@override String get review_delete_condition_description => '復習を取り除く条件を決められます。';
	@override String get review_delete_condition_0 => '翌日の復習で正解した場合';
	@override String get review_delete_condition_1 => '３日後の復習で正解した場合';
	@override String get review_delete_condition_2 => '１週間後の復習で正解した場合';
	@override String get review_delete_condition_3 => '２週間後の復習で正解した場合';
	@override String get review_delete_condition_4 => '３週間後の復習で正解した場合';
	@override String get review_delete_condition_5 => '１ヶ月後の復習で正解した場合';
	@override String get review_delete_condition_6 => '２ヶ月後の復習で正解した場合';
	@override String get review_delete_condition_7 => '３ヶ月後の復習で正解した場合';
	@override String get review_delete_condition_8 => '６ヶ月後の復習で正解した場合';
	@override String get review_delete_condition_9 => '１年後の復習で正解した場合';
	@override String get weakness_setting => '弱点設定';
	@override String get weakness_condition => '弱点にする条件';
	@override String get weakness_condition_description => '苦手な問題に追加する条件を決められます。';
	@override String get weakness_condition_0 => '自動で設定しない';
	@override String get weakness_condition_1 => '１回以上間違えた場合';
	@override String get weakness_condition_2 => '２回以上間違えた場合';
	@override String get weakness_condition_3 => '３回以上間違えた場合';
	@override String get weakness_condition_4 => '４回以上間違えた場合';
	@override String get weakness_condition_5 => '５回以上間違えた場合';
	@override String get overcoming_condition => '克服する条件';
	@override String get overcoming_condition_description => '弱点から取り除く条件を決められます。';
	@override String get overcoming_condition_0 => '解答時に克服する';
	@override String get overcoming_condition_1 => '正解時に克服する';
	@override String get overcoming_condition_120 => '自動で克服しない';
	@override String overcoming_condition_i({required Object percentage}) => '正答率${percentage}%以上';
	@override String get change_settings => '設定を変更する';
	@override String get update_succeeded => '設定を更新しました。';
	@override String get update_failed => '設定の更新に失敗しました。';
	@override String se_switched({required Object state}) => '効果音を${state}にしました。';
	@override String get review_notification_enabled => '復習リマインダー';
	@override String get review_notification_enabled_description => 'その日に復習すべき問題がある場合に、指定した時刻に通知を送ります。';
	@override String get set_review_notification => '復習時刻を設定する';
	@override String get set_review_notification_description => 'あなたが効率的に学習できるように、復習すべき問題があるときにリマインダーを送ります。あなたが学習できる時刻を設定してください。';
	@override String review_notification_set({required Object hours}) => '${hours}時に復習リマインダーを設定しました。';
}

// Path: answerAnalyses
class _TranslationsAnswerAnalysesJa implements _TranslationsAnswerAnalysesEn {
	_TranslationsAnswerAnalysesJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get answer_analyses => '解答分析';
	@override String get answer_histories => '解答履歴';
	@override String get premium_recommendation => 'これらの機能を利用するには、プレミアムプランへの登録が必要です。';
	@override String get correct_answer_rate_asc => '正答率が低い順';
	@override String get correct_answer_rate_desc => '正答率が高い順';
	@override String get incorrect_answer_histories_count_desc => '間違いが多い順';
	@override String get incorrect_answer_histories_count_asc => '間違いが少ない順';
	@override String get last_answered_at_desc => '解答履歴：新しい順';
	@override String get last_answered_at_asc => '解答履歴：古い順';
}

// Path: achievements
class _TranslationsAchievementsJa implements _TranslationsAchievementsEn {
	_TranslationsAchievementsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get medals_won => '獲得メダル';
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
	@override String translation_restricted({required Object number}) => '無料ユーザーが1日に翻訳できる回数は、${number}件までです。';
	@override String deepl_not_supported({required Object language}) => '${language}はDeepLが対応していない言語です。';
	@override String google_not_supported({required Object language}) => '${language}はGoogleが対応していない言語です。';
	@override String get need_to_login => '翻訳機能を利用するにはログインが必要です。';
	@override String get language => '言語';
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

// Path: chapters
class _TranslationsChaptersJa implements _TranslationsChaptersEn {
	_TranslationsChaptersJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get lang_number => '言語設定';
	@override String get lang_number_error => '：言語を自動で検出できませんでした。言語の種類を手動で設定してください。';
	@override String get chapters => 'チャプター';
	@override String get answers => '解答';
	@override String get view_details => '詳細を見る';
	@override String get administrators => '管理者';
	@override String get moderators => '管理者';
	@override String get admin_functions => '管理機能';
	@override String get subscribers_list => '購読者一覧';
	@override String get manage_moderators => 'モデレータを管理する';
	@override String get setting => 'チャプター設定';
	@override String get setting_updated => 'チャプター設定を更新しました。';
	@override String get new_section => 'セクションを作成する';
	@override String get edit_section => 'セクションを編集する';
	@override String get drills => 'ドリル';
	@override String get post => 'ドリルを作成する';
	@override String get view_more => 'もっと見る';
	@override String get create_drill => '問題を作成する';
	@override String get subscribe => '購読する';
	@override String get subscribed => '購読中';
	@override String get create_chapter => 'チャプターを作成する';
	@override String get title_placeholder => 'チャプターの名前を入力してください。';
	@override String get introduction => '説明';
	@override String get introduction_placeholder => 'チャプターの説明を入力してください。';
	@override String get create => '作成する';
	@override String get creating_succeeded => 'チャプターを作成しました。';
	@override String get creating_failed => 'チャプターを作成できませんでした。';
	@override String get drill => '問題集';
	@override String get activities => '活動';
}

// Path: experiencePoints
class _TranslationsExperiencePointsJa implements _TranslationsExperiencePointsEn {
	_TranslationsExperiencePointsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String to_the_next_level({required Object points}) => '次のレベルまであと${points}EXP';
}

// Path: sentences
class _TranslationsSentencesJa implements _TranslationsSentencesEn {
	_TranslationsSentencesJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get sentences => '例文';
	@override String get sentence => '例文';
	@override String get add => '例文を追加する';
	@override String get edit => '例文を編集する';
	@override String get remove => '例文を取り除く';
	@override String get destroy => '例文を削除する';
	@override String get original => '原文';
	@override String get translation => '翻訳';
	@override String original_placeholder({required Object language}) => '【必須】${language}の例文を入力してください。';
	@override String translation_placeholder({required Object language}) => '【必須】例文の${language}の訳を入力してください。';
	@override String get generate_sentence => 'AIで例文を生成する';
	@override String keyword_description({required Object limit}) => '例文に含めたいキーワードを入力してください(${limit}文字以内)。';
	@override String get keyword_placeholder => '例文に含むキーワード';
	@override String get pos => 'キーワードの品詞';
	@override String get meaning => 'キーワードの意味（類義語など）';
	@override String get meaning_placeholder => 'キーワードの意味を指定できます。';
	@override String get difficulty => '難易度';
	@override String get easy => '易しい';
	@override String get normal => '普通';
	@override String get difficult => '難しい';
	@override String get model => 'AIの種類';
	@override String get keeping_form => 'キーワードを変化させない';
	@override String get gpt_3_5 => 'GPT-3.5（速い）';
	@override String get gpt_4 => 'GPT-4（遅いが賢い）';
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
	@override String no_item_found({required Object keyword}) => '"${keyword}"が含まれる例文は見つかりませんでした。';
	@override String get review_label => '読めるようになる';
	@override String get review_label_listening => '聞き取れるようになる';
	@override String get reversed_review_label => '話せるようになる';
}

// Path: notes
class _TranslationsNotesJa implements _TranslationsNotesEn {
	_TranslationsNotesJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get notes => 'ノート';
	@override String get note => 'ノート';
	@override String get note_placeholder => 'あなただけが閲覧できるノートです。問題のヒントとしてもご利用いただけます。';
	@override String get edit => '編集する';
	@override String get update => '更新する';
	@override String get paywall_message => 'プレミアム会員になることで、ノート機能をご利用いただけるようになります。';
	@override String get destroy => '削除する';
	@override String get confirmation => '確認';
	@override String get confirmation_text => '本当にこのノートを削除してもよろしいですか？';
	@override String get updated_at_desc => '更新日が新しい順';
	@override String get updated_at_asc => '更新日が古い順';
	@override String get created_at_desc => '作成日が新しい順';
	@override String get created_at_asc => '作成日が古い順';
}

// Path: ranking
class _TranslationsRankingJa implements _TranslationsRankingEn {
	_TranslationsRankingJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get ranking => 'ランキング';
	@override String get daily => '日間';
	@override String get weekly => '週間';
	@override String get monthly => '月間';
	@override String get daily_answerer => '日間解答者ランキング';
	@override String get weekly_answerer => '週間解答者ランキング';
	@override String get monthly_answerer => '月間解答者ランキング';
	@override String rank({required Object number}) => '第${number}位';
}

// Path: timeZone
class _TranslationsTimeZoneJa implements _TranslationsTimeZoneEn {
	_TranslationsTimeZoneJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get international_date_line_west => '国際日付変更線西';
	@override String get american_samoa => 'アメリカ領サモア';
	@override String get midway_island => 'ミッドウェー島';
	@override String get hawaii => 'ハワイ';
	@override String get alaska => 'アラスカ';
	@override String get pacific_time_us_canada => 'アメリカ・カナダ太平洋時間';
	@override String get tijuana => 'ティフアナ';
	@override String get arizona => 'アリゾナ';
	@override String get mazatlan => 'マサトラン';
	@override String get mountain_time_us_canada => 'アメリカ・カナダ山岳部時間';
	@override String get central_america => '中央アメリカ';
	@override String get central_time_us_canada => 'アメリカ・カナダ中部時間';
	@override String get chihuahua => 'チワワ';
	@override String get guadalajara => 'グアダラハラ';
	@override String get mexico_city => 'メキシコシティ';
	@override String get monterrey => 'モンテレイ';
	@override String get saskatchewan => 'サスカチュワン';
	@override String get bogota => 'ボゴタ';
	@override String get eastern_time_us_canada => 'アメリカ・カナダ東部時間';
	@override String get indiana_east => 'インディアナ州東部';
	@override String get lima => 'リマ';
	@override String get quito => 'キト';
	@override String get atlantic_time_canada => 'カナダ大西洋時間';
	@override String get caracas => 'カラカス';
	@override String get georgetown => 'ジョージタウン';
	@override String get la_paz => 'ラパス';
	@override String get puerto_rico => 'プエルトリコ';
	@override String get santiago => 'サンチアゴ';
	@override String get newfoundland => 'ニューファンドランド';
	@override String get brasilia => 'ブラジリア';
	@override String get buenos_aires => 'ブエノスアイレス';
	@override String get greenland => 'グリーンランド';
	@override String get montevideo => 'モンテビデオ';
	@override String get mid_atlantic => '中大西洋';
	@override String get azores => 'アゾレス';
	@override String get cape_verde_is => 'カーボヴェルデ';
	@override String get casablanca => 'カサブランカ';
	@override String get dublin => 'ダブリン';
	@override String get edinburgh => 'エディンバラ';
	@override String get lisbon => 'リスボン';
	@override String get london => 'ロンドン';
	@override String get monrovia => 'モンロビア';
	@override String get utc => '協定世界時';
	@override String get amsterdam => 'アムステルダム';
	@override String get belgrade => 'ベオグラード';
	@override String get berlin => 'ベルリン';
	@override String get bern => 'ベルン';
	@override String get bratislava => 'ブラチスラヴァ';
	@override String get brussels => 'ブリュッセル';
	@override String get budapest => 'ブダペスト';
	@override String get copenhagen => 'コペンハーゲン';
	@override String get ljubljana => 'リュブリャナ';
	@override String get madrid => 'マドリード';
	@override String get paris => 'パリ';
	@override String get prague => 'プラハ';
	@override String get rome => 'ローマ';
	@override String get sarajevo => 'サラエボ';
	@override String get skopje => 'スコピエ';
	@override String get stockholm => 'ストックホルム';
	@override String get vienna => 'ビーン';
	@override String get warsaw => 'ワルシャワ';
	@override String get west_central_africa => '西中部アフリカ';
	@override String get zagreb => 'ザグレブ';
	@override String get zurich => 'チューリッヒ';
	@override String get athens => 'アテネ';
	@override String get bucharest => 'ブカレスト';
	@override String get cairo => 'カイロ';
	@override String get harare => 'ハラレ';
	@override String get helsinki => 'ヘルシンキ';
	@override String get jerusalem => 'エルサレム';
	@override String get kaliningrad => 'カリーニングラード';
	@override String get kyiv => 'キエフ';
	@override String get pretoria => 'プレトリア';
	@override String get riga => 'リガ';
	@override String get sofia => 'ソフィア';
	@override String get tallinn => 'タリン';
	@override String get vilnius => 'ヴィリニュス';
	@override String get baghdad => 'バグダッド';
	@override String get istanbul => 'イスタンブール';
	@override String get kuwait => 'クウェート';
	@override String get minsk => 'ミンスク';
	@override String get moscow => 'モスクワ';
	@override String get nairobi => 'ナイロビ';
	@override String get riyadh => 'リヤド';
	@override String get st_petersburg => 'サンクトペテルブルク';
	@override String get volgograd => 'ヴォルゴグラード';
	@override String get tehran => 'テヘラン';
	@override String get abu_dhabi => 'アブダビ';
	@override String get baku => 'バクー';
	@override String get muscat => 'マスカット';
	@override String get samara => 'サマラ';
	@override String get tbilisi => 'トビリシ';
	@override String get yerevan => 'エレバン';
	@override String get kabul => 'カブール';
	@override String get ekaterinburg => 'エカテリンブルク';
	@override String get islamabad => 'イスラマバード';
	@override String get karachi => 'カラチ';
	@override String get tashkent => 'タシュケント';
	@override String get chennai => 'チェンナイ';
	@override String get kolkata => 'コルカタ';
	@override String get mumbai => 'ムンバイ';
	@override String get new_delhi => 'ニューデリー';
	@override String get sri_jayawardenepura => 'スリジャヤワルダネプラコッテ';
	@override String get kathmandu => 'カトマンズ';
	@override String get almaty => 'アルマトイ';
	@override String get astana => 'アスタナ';
	@override String get dhaka => 'ダッカ';
	@override String get urumqi => 'ウルムチ';
	@override String get rangoon => 'ラングーン';
	@override String get bangkok => 'バンコク';
	@override String get hanoi => 'ハノイ';
	@override String get jakarta => 'ジャカルタ';
	@override String get krasnoyarsk => 'クラスノヤルスク';
	@override String get novosibirsk => 'ノヴォシビルスク';
	@override String get beijing => '北京';
	@override String get chongqing => '重慶';
	@override String get hong_kong => '香港';
	@override String get irkutsk => 'イルクーツク';
	@override String get kuala_lumpur => 'クアラルンプール';
	@override String get perth => 'パース';
	@override String get singapore => 'シンガポール';
	@override String get taipei => '台北';
	@override String get ulaanbaatar => 'ウランバートル';
	@override String get osaka => '大阪';
	@override String get sapporo => '札幌';
	@override String get seoul => 'ソウル';
	@override String get tokyo => '東京';
	@override String get yakutsk => 'ヤクーツク';
	@override String get adelaide => 'アデレード';
	@override String get darwin => 'ダーウィン';
	@override String get brisbane => 'ブリスベン';
	@override String get canberra => 'キャンベラ';
	@override String get guam => 'グアム';
	@override String get hobart => 'ホバート';
	@override String get melbourne => 'メルボルン';
	@override String get port_moresby => 'ポートモレスビー';
	@override String get sydney => 'シドニー';
	@override String get vladivostok => 'ウラジオストク';
	@override String get magadan => 'マガダン';
	@override String get new_caledonia => 'ニューカレドニア';
	@override String get solomon_is => 'ソロモン諸島';
	@override String get srednekolymsk => 'スレドネコリムスク';
	@override String get auckland => 'オークランド';
	@override String get fiji => 'フィジー';
	@override String get kamchatka => 'カムチャツカ';
	@override String get marshall_is => 'マーシャル諸島';
	@override String get wellington => 'ウェリントン';
	@override String get chatham_is => 'チャタム諸島';
	@override String get nuku_alofa => 'ヌクアロファ';
	@override String get samoa => 'サモア';
	@override String get tokelau_is => 'トケラウ諸島';
}

// Path: answer
class _TranslationsAnswerJa implements _TranslationsAnswerEn {
	_TranslationsAnswerJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String answers_count({required Object count}) => '${count}問解答';
	@override String get limit_reached => '制限に達しました';
	@override String limit_reached_description({required Object number}) => '無料ユーザーが解けるのは、１日に${number}問までです。プレミアム会員になって、無制限に問題を解きましょう！';
}

// Path: quizzes
class _TranslationsQuizzesJa implements _TranslationsQuizzesEn {
	_TranslationsQuizzesJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get quiz => '問題';
	@override String get edit => '編集する';
	@override String get answer => '解答する';
	@override String get see_correct_answer => '正解を見る';
	@override String get correct => '正解した';
	@override String get wrong => '間違えた';
	@override String get got_a_correct => '正解した';
	@override String get made_a_mistake => '間違えた';
	@override String get question => '問題文';
	@override String get question_placeholder => '【必須】問題文を入力してください。';
	@override String get correct_answer => '正解';
	@override String get correct_answer_placeholder => '【必須】正解を入力してください。';
	@override String get distractors => '誤りの選択肢';
	@override String get distractors_placeholder => '【空欄可】誤りの選択肢を設定できます。';
	@override String get explanation => '解説';
	@override String get explanation_placeholder => '【空欄可】解説を設定できます。';
	@override String get hint => 'ヒント';
	@override String get hint_placeholder => '【空欄可】ヒントを設定できます。';
	@override String get corrected_time_ago => '%{time}前に正解';
	@override String get incorrect_time_ago => '%{time}前に不正解';
	@override String get correct_answer_rate => '正答率%{percent}%';
}

// Path: activities
class _TranslationsActivitiesJa implements _TranslationsActivitiesEn {
	_TranslationsActivitiesJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get activities => '活動';
	@override String get cheer => '応援する!';
	@override String get cheered => '応援しました！';
}

// Path: answerHistories
class _TranslationsAnswerHistoriesJa implements _TranslationsAnswerHistoriesEn {
	_TranslationsAnswerHistoriesJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get answer_histories => '解答履歴';
	@override String get todays_mistakes => '今日間違えた問題';
}

// Path: wordRequests
class _TranslationsWordRequestsJa implements _TranslationsWordRequestsEn {
	_TranslationsWordRequestsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get word_requests => '辞書の編集履歴';
	@override String get edit_histories => '編集履歴';
	@override String get pending_edits => '審査中の編集';
	@override String get rejected_edits => '却下された編集';
	@override String get edit_applied => '編集が適応されました。';
	@override String get addition_request_submitted => '追加リクエストが申請されました。';
	@override String get modification_request_submitted => '修正リクエストが申請されました。';
	@override String get elimination_request_submitted => '削除リクエストが申請されました。';
	@override String get already_submitted => '編集リクエストをすでに申請済みです。';
	@override String get addition => '項目の追加';
	@override String get modification => '項目の修正';
	@override String get elimination => '項目の削除';
	@override String get acceptance => '採用済';
	@override String get rejection => '却下済';
	@override String get pending => '審査中';
	@override String get accept => '採用';
	@override String get reject => '却下';
	@override String get editor_comment => '編集者のコメント';
	@override String get comments => 'コメント';
	@override String get cancel => 'リクエストを取り下げる';
	@override String get canceled => 'リクエストを取り下げました。';
	@override String get target => '編集先';
	@override String get target_already_deleted => '編集先がすでに削除されています。';
	@override String get target_not_found => '編集先が見つかりませんでした。';
	@override String get show_heading => '編集内容';
	@override String get accepted => 'リクエストが採用されました。';
	@override String get rejected => 'リクエストが却下されました。';
	@override String edited_at({required Object time}) => '${time}前に編集';
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
	@override String get pos_tag_id => '品詞';
	@override String get meaning => '意味';
	@override String get ipa => 'IPA（発音記号）';
	@override String get search_sentence => '例文を検索する';
	@override String get search_sentence_placeholder => 'キーワードを入力してください';
	@override String get no_sentence => '例文が設定されていません。';
	@override String get set_sentence_with_ai => 'AIで例文を設定する';
	@override String get generate_meaning_with_ai => 'AIで意味を生成する';
	@override String get meaning_generation_keyword_placeholder => '意味を生成するキーワード';
	@override String get success_to_generate_meanings => '意味を生成しました。';
	@override String get failed_to_generate_meanings => '意味の生成に失敗しました。';
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

// Path: purchase
class _TranslationsPurchaseJa implements _TranslationsPurchaseEn {
	_TranslationsPurchaseJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get premium_plan => 'プレミアムプラン';
	@override String get premium_plan_description => 'DiQtのすべての機能が使い放題になるプランです。';
	@override String get trial_period_description => '今なら２週間の無料体験期間つき！';
	@override String get free_plan => '無料プラン';
	@override String get yen => '円';
	@override String get answers_limit => '1日の解答数';
	@override String get unlimited => '無制限';
	@override String get translations_limit => '1日の翻訳できる回数';
	@override String get ad_free => '広告非表示';
	@override String get weakness => '弱点問題';
	@override String get note => 'ノート機能';
	@override String get answer_analysis => '解答分析';
	@override String get answer_history => '解答履歴';
	@override String get questions_you_got_wrong => '今日間違えた問題';
	@override String get deletion_of_all_reviews => '復習一括削除';
	@override String get monthly_plan => '月額プラン';
	@override String get month => '月';
	@override String get annual_plan => '年額プラン';
	@override String get year => '年';
	@override String get two_months_free => '２ヶ月分お得！';
	@override String get start_free_trial => '無料で試す';
	@override String get get_started => '登録する';
	@override String get registered => '登録済み';
	@override String get bank_transfer => '銀行口座のお振込をご希望の方はこちらから';
	@override String get stripe_explanation => '決済には、Stripeを利用しております。Stripeは世界中で幅広く利用されている安全な決済システムであり、当社のサーバーでお客様のカード情報を保存することはありません。';
	@override String get auto_renew_explanation => 'プランは自動更新です。有効期間が終了する２４時間前までにお支払い設定よりご解約いただければ、自動更新はされません。';
	@override String get this_is_premium_plan_feature => 'プレミアム会員用の機能です';
	@override String get all_features_will_be_available => 'すべての機能が利用できるようになります。';
	@override String get notice => '有料化の7日前にお知らせします。';
	@override String get cancel_at_any_time => 'いつでもキャンセルできます。';
	@override String get monthly_plan_price => '500円／月';
	@override String get annual_plan_price => '5,000円／年';
	@override String get purchase_succeded => 'プレミアム会員になりました！';
	@override String get view_premium_plan_benefits => 'プレミアムプランの特典を見る';
	@override String get view_premium_plan => 'プレミアムプランを見る';
	@override String get premium_plan_benefits => 'プレミアムプランの特典';
	@override String get unlimited_answers => '無制限の解答';
	@override String unlimited_answers_description({required Object number}) => '無料ユーザーが1日に解答できる問題の数は${number}問ですが、プレミアム会員なら、1日に何問でも解答できるようになります。';
	@override String get unlimited_translations => '無制限の翻訳';
	@override String unlimited_translations_description({required Object number}) => '無料ユーザーが1日に翻訳できる回数は${number}回ですが、プレミアム会員になら、1日に何回でも翻訳できるようになります。';
	@override String get weakness_description => 'プレミアム会員なら、正答率が低い問題を重点的に学習できるようになります。';
	@override String get note_description => 'プレミアム会員なら、解いた問題にメモを残すことができるようになります。';
	@override String get answer_analysis_description => 'プレミアム会員なら、正答率や間違えた回数で解いた問題を分析できるようになります。';
	@override String get answer_history_description => 'プレミアム会員なら、解答した問題の履歴を閲覧できるようになります。';
	@override String get questions_you_got_wrong_description => 'プレミアム会員なら、その日に間違えた問題を確認できるようになります。';
	@override String get deletion_of_all_reviews_description => 'プレミアム会員なら、今までに設定した復習をすべて取り消すことができるようになります。';
	@override String get ad_free_description => 'プレミアム会員なら、アプリ内のすべての広告が表示されなくなります。';
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
	@override String get inquiry => 'お問い合わせ';
	@override String get maintenance_mode => 'メンテナンス中';
	@override String get maintenance_description => '大変申し訳ございません。ただ今DiQtはメンテナンスを行なっております。しばらくしてから、再びアクセスいただければ幸いです。';
	@override String get maintenance_latest_information => '最新情報はこちら';
}

// Path: drillLaps
class _TranslationsDrillLapsJa implements _TranslationsDrillLapsEn {
	_TranslationsDrillLapsJa._(this._root);

	@override final _TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get resume => '続きから';
	@override String get view_more => 'もっと見る';
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
			case 'dictionaries.reversed_sentence_drill': return 'SentenceDrill for writing and speaking';
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
			case 'reviews.reviews': return 'Reviews';
			case 'reviews.unreviewed': return 'Unreviewed';
			case 'reviews.scheduled': return 'Scheduled';
			case 'reviews.all': return 'All';
			case 'reviews.order': return 'Order';
			case 'reviews.random_random': return 'Random';
			case 'reviews.scheduled_date_desc': return 'Latest scheduled';
			case 'reviews.scheduled_date_asc': return 'Oldest scheduled';
			case 'reviews.empty': return 'There are no review questions.';
			case 'reviews.memorize': return 'Reminder';
			case 'reviews.set_review': return 'Set Review';
			case 'reviews.scheduled_date': return 'Scheduled Date';
			case 'reviews.interval': return 'Review Interval';
			case 'reviews.destroy': return 'Cancel the review schedule';
			case 'reviews.tomorrow': return 'Tomorrow';
			case 'reviews.after_3_days': return '3 days later';
			case 'reviews.after_a_week': return 'A week later';
			case 'reviews.after_2_week': return '2 weeks later';
			case 'reviews.after_3_week': return '3 weeks later';
			case 'reviews.after_a_month': return 'A month later';
			case 'reviews.after_2_month': return '2 months later';
			case 'reviews.after_3_month': return '3 months later';
			case 'reviews.after_6_month': return '6 months later';
			case 'reviews.after_a_year': return 'A year later';
			case 'reviews.review_for': return ({required Object interval}) => 'Review ${interval}';
			case 'reviews.has_been_set_for': return ({required Object interval}) => 'The review has been set for ${interval}';
			case 'reviews.schedule_canceled': return 'Review schedule canceled.';
			case 'reviews.cancel_all_schedules': return 'Cancel All Review Schedules';
			case 'reviews.all_schedules_canceled': return 'All review schedules cancelled.';
			case 'reviews.details_of_the_question': return 'Details of the question to be reviewed';
			case 'reviews.error_occurred': return 'An error about this review occurred.';
			case 'reviews.fix_error': return 'Fix error';
			case 'reviews.error_fixed': return 'Error fixed.';
			case 'errors.error_message_404': return 'Page Not Found...';
			case 'errors.error_message_505': return 'I\'m so sorry. This is internal server error.';
			case 'errors.cant_be_blank': return 'This field can\'t be blank.';
			case 'errors.error_occured': return 'Errors have occurred.';
			case 'errors.http_status_400': return '400 Bad Request: Invalid request.';
			case 'errors.http_status_401': return '401 Unauthorized: No access rights or authentication failed.';
			case 'errors.http_status_402': return '402 Payment Required: Sorry, but the requested resource requires payment before it can be accessed. Please check your account status';
			case 'errors.http_status_403': return '403 Forbidden: Sorry, but you do not have permission to access this resource. Please contact the administrator if you think this is a mistake.';
			case 'errors.http_status_404': return '404 Not Found: Sorry, but the resource you requested could not be found on this server.';
			case 'errors.http_status_405': return '405 Method Not Allowed: Sorry, but the HTTP method used in the request is not allowed for the resource.';
			case 'errors.http_status_406': return '406 Not Acceptable: Sorry, but the server cannot provide a response that satisfies your Accept headers. Please modify your request and try again.';
			case 'errors.http_status_407': return '407 Proxy Authentication Required: Sorry, but you need to authenticate yourself with the proxy server first. Please login to continue.';
			case 'errors.http_status_408': return '408 Request Timeout: Sorry, your request timed out. Please check your network connection and try again.';
			case 'errors.http_status_409': return '409 Conflict: Sorry, but there was a conflict with the requested operation. Please check your input and try again.';
			case 'errors.http_status_410': return '410 Gone: Sorry, but the requested resource is no longer available on this server and no forwarding address is known.';
			case 'errors.http_status_411': return '411 Length Required: Sorry, but the server requires a valid Content-Length header field in the request. Please include it and try again.';
			case 'errors.http_status_412': return '412 Precondition Failed: Sorry, but one or more preconditions you gave in the request header fields evaluated to false.';
			case 'errors.http_status_413': return '413 Payload Too Large: Sorry, but the request entity is larger than the server is willing or able to process.';
			case 'errors.http_status_414': return '414 URI Too Long: Sorry, but the URI provided was too long for the server to process. Please shorten it and try again.';
			case 'errors.http_status_415': return '415 Unsupported Media Type: Sorry, but the server does not support the media type indicated in the request. Please check and try again.';
			case 'errors.http_status_416': return '416 Range Not Satisfiable: Sorry, but the client has asked for a portion of the file, but the server cannot supply that portion.';
			case 'errors.http_status_417': return '417 Expectation Failed: Sorry, but the expectation given in the Expect request-header field could not be met by the server.';
			case 'errors.http_status_418': return '418 I\'m a teapot: Sorry, I\'m a teapot. The requested entity body is short and stout, handle is here, spout is there.';
			case 'errors.http_status_421': return '421 Misdirected Request: Sorry, but the request was directed at a server that is not able to produce a response.';
			case 'errors.http_status_422': return '422 Unprocessable Entity: Sorry, but the server understands the content type of the request entity and the syntax of the request entity is correct but was unable to process the contained instructions.';
			case 'errors.http_status_423': return '423 Locked: Sorry, but the resource that you are trying to access is locked.';
			case 'errors.http_status_424': return '424 Failed Dependency: Sorry, but the method could not be performed on the resource because the requested action depended on another action and that action failed.';
			case 'errors.http_status_425': return '425 Too Early: Sorry, but the server is unwilling to risk processing a request that might be replayed.';
			case 'errors.http_status_426': return '426 Upgrade Required: Sorry, but the client should switch to a different protocol such as TLS/1.0, given in the Upgrade header field.';
			case 'errors.http_status_427': return '427 Unassigned: Sorry, but this error code is currently unassigned and cannot be used.';
			case 'errors.http_status_428': return '428 Precondition Required: Sorry, but the origin server requires the request to be conditional. Intended to prevent the "lost update" problem.';
			case 'errors.http_status_429': return '429 Too Many Requests: Sorry, but you have sent too many requests in a given amount of time. Please try again later.';
			case 'errors.http_status_431': return '431 Request Header Fields Too Large: Sorry, but the server is unwilling to process the request because either an individual header field, or all the header fields collectively, are too large.';
			case 'errors.http_status_500': return '500 Internal Server Error: Sorry, but something went wrong on our end. Please try again later.';
			case 'errors.http_status_501': return '501 Not Implemented: Sorry, but the request method is not implemented. Please check and try again.';
			case 'errors.http_status_502': return '502 Bad Gateway: Sorry, but the server received an invalid response from the upstream server. Please try again.';
			case 'errors.http_status_503': return '503 Service Unavailable: Sorry, but the server is currently unavailable. Please try again later.';
			case 'errors.http_status_504': return '504 Gateway Timeout: The server is currently unable to handle the request due to a temporary overloading or maintenance. Please try again later.';
			case 'errors.http_status_505': return '505 HTTP Version Not Supported: Sorry, but the HTTP version used in the request is not supported.';
			case 'errors.http_status_506': return '506 Variant Also Negotiates: The server has an internal configuration error. The chosen variant resource is configured to engage in transparent content negotiation itself, and is therefore not a proper end point in the negotiation process.';
			case 'errors.http_status_507': return '507 Insufficient Storage: Sorry, but the server is unable to store the representation needed to complete the request.';
			case 'errors.http_status_508': return '508 Loop Detected: The server detected an infinite loop while processing the request. This status indicates that the entire operation failed.';
			case 'errors.http_status_510': return '510 Not Extended: Further extensions to the request are required for the server to fulfill it.';
			case 'errors.http_status_511': return '511 Network Authentication Required: You need to authenticate to gain network access. Please connect to the network and try again.';
			case 'drills.drills': return 'Drills';
			case 'drills.unsolved': return 'Unsolved';
			case 'drills.solved': return 'Solved';
			case 'drills.search': return 'Search Quizzes';
			case 'drills.pending_requests': return 'Pending Requests';
			case 'drills.accepted_requests': return 'Accepted Requests';
			case 'drills.create_drill': return 'Create drill';
			case 'drills.create_drill_with_csv': return 'Create drill with CSV';
			case 'drills.edit_drill': return 'Edit drill';
			case 'drills.edit_drill_with_csv': return 'Edit drill with csv';
			case 'drills.csv_blank': return 'Please attach a CSV file.';
			case 'drills.please_wait': return 'Creating drill. Please wait for 10 seconds.';
			case 'drills.created_at_asc': return 'From the beginning';
			case 'drills.created_at_desc': return 'From the end';
			case 'drills.random_random': return 'Random';
			case 'weaknesses.weaknesses': return 'Weaknesses';
			case 'weaknesses.premium_recommendation': return 'To solve weak questions, you need to register for a premium plan.';
			case 'weaknesses.correct_answer_rate_asc': return 'Correct Rate, Low to High';
			case 'weaknesses.correct_answer_rate_desc': return 'Correct Rate, High to Low';
			case 'weaknesses.incorrect_answers_count_desc': return 'Incorrect, Most to Least';
			case 'weaknesses.incorrect_answers_count_asc': return 'Incorrect, Least to Most';
			case 'weaknesses.created_at_desc': return 'Added, Newest First';
			case 'weaknesses.created_at_asc': return 'Added, Oldest First';
			case 'weaknesses.random_random': return 'Random';
			case 'users.anonymous_user': return 'Anonymous user';
			case 'users.creating_account_succeeded': return 'Your account registration has been completed! Welcome to DiQt!';
			case 'users.show': return 'User Page';
			case 'users.menu': return 'Menu';
			case 'users.find_users': return 'Find users';
			case 'users.contract_details': return 'Contract details';
			case 'users.edit': return 'Account Setting';
			case 'users.withdraw': return 'Withdraw from DiQt';
			case 'users.withdraw_confirmation': return 'The account will be deleted. Deleted accounts cannot be restored again. Are you sure you still want to do this?';
			case 'users.set_icon': return 'Set the icon';
			case 'users.name': return 'Name';
			case 'users.profile': return 'Profile';
			case 'users.profile_placeholder': return 'Please enter a profile of no more than 500 characters.';
			case 'users.lang_number': return 'Language Setting(mother tongue)';
			case 'users.learning_lang_number': return 'Learning Language';
			case 'users.time_zone_name': return 'Time Zone';
			case 'users.you_cant_change_time_zone': return 'You can not change TimeZone if you have already answered a quiz today. Please try tomorrow.';
			case 'users.authentication': return 'Authentication';
			case 'users.email': return 'Email';
			case 'users.new_password': return 'New Password';
			case 'users.new_password_placeholder': return 'At least 6 alphanumeric characters';
			case 'users.new_password_confirmation': return 'Password Confirmation';
			case 'users.new_password_confirmation_placeholder': return 'Please enter a new password again';
			case 'users.recommend_setting_password': return 'Please set a password so that you can also log in via your email address. Unless you set a password, you will not be able to update your account information.';
			case 'users.mail_delivered': return 'Receive email notifications';
			case 'users.updated': return 'Account Updated.';
			case 'users.failed_to_update': return 'Account could not be updated.';
			case 'users.destroyed': return 'Your membership withdrawal has been completed. Thank you very much for using DiQt.';
			case 'users.drills': return 'Created Drills';
			case 'schools.schools': return 'Schools';
			case 'schools.school': return 'School';
			case 'schools.name': return 'Name';
			case 'schools.name_placeholder': return 'Enter school name';
			case 'schools.members': return 'Members';
			case 'schools.create_member': return 'Create member';
			case 'schools.edit_member': return 'Edit member';
			case 'schools.invite_member': return 'Invite member';
			case 'schools.invite': return 'Invite';
			case 'schools.remove': return 'Remove';
			case 'schools.invitation_limited': return 'You need to increase the number of members to invite new members.';
			case 'schools.invitation_succeeded': return 'Invitation succeeded.';
			case 'schools.removal_succeeded': return 'Removal succeeded.';
			case 'schools.owner': return 'Founder';
			case 'schools.admin': return 'Admin';
			case 'schools.moderator': return 'Moderator';
			case 'schools.member': return 'Member';
			case 'notices.notifications': return 'Notifications';
			case 'notices.cheered_message': return ({required Object name}) => '${name} has cheered you!';
			case 'notices.followed_message': return ({required Object name}) => '${name} has followed you!';
			case 'notices.word_request_accepted_message': return 'Your dictionary edit has been adopted!';
			case 'shared.create': return 'Create';
			case 'shared.create_succeeded': return 'Created';
			case 'shared.create_failed': return 'Create failed';
			case 'shared.edit': return 'Edit';
			case 'shared.update': return 'Update';
			case 'shared.update_succeeded': return 'Updated';
			case 'shared.update_failed': return 'Update failed';
			case 'shared.destroy': return 'Destroy';
			case 'shared.destroy_confirmation': return 'Confirmation';
			case 'shared.destroy_confirmation_description': return 'Are you sure you want to delete it?';
			case 'shared.destroy_succeeded': return 'Destroyed';
			case 'shared.cancel': return 'Cancel';
			case 'shared.reload': return 'Reload';
			case 'shared.search': return 'Search';
			case 'shared.generate': return 'Generate';
			case 'shared.send': return 'Send';
			case 'shared.set_up': return 'Set Up';
			case 'shared.undefined': return 'Undefined';
			case 'shared.details': return 'Details';
			case 'shared.view_details': return 'View Details';
			case 'shared.view_more': return 'View More';
			case 'shared.please_enter': return ({required Object name}) => 'Please enter "${name}"';
			case 'shared.no_more_items': return ({required Object name}) => 'All ${name} loaded';
			case 'shared.no_items_found': return ({required Object name}) => 'No ${name} found';
			case 'shared.premium_recommendation': return 'To use this function, you need to register for a premium plan.';
			case 'shared.login_recommendation': return 'To use this function, you need to log in.';
			case 'shared.processing': return 'Processing';
			case 'shared.done': return 'Done';
			case 'shared.download': return 'Download';
			case 'shared.dictionary_setting': return 'Dictionary Setting';
			case 'shared.thumbnail': return 'Thumbnail';
			case 'shared.remove_thumbnail': return 'Remove Thumbnail';
			case 'shared.image_alt': return ({required Object name}) => 'Image of ${name}';
			case 'shared.error_occurred': return 'An error occurred.';
			case 'shared.fix_error': return 'Fix error';
			case 'shared.error_fixed': return 'Error fixed.';
			case 'answerSettings.title': return 'Answer & Review Setting';
			case 'answerSettings.answer_setting': return 'Answer Setting';
			case 'answerSettings.daily_goal': return 'Daily target';
			case 'answerSettings.daily_goal_description': return 'Set a target number of answers per day.';
			case 'answerSettings.daily_goal_cant_be_changed': return 'The target cannot be changed as it has already been achieved today.';
			case 'answerSettings.question_cover': return 'Question Cover';
			case 'answerSettings.question_cover_description': return 'Questions where the question text is read out loud, and a sheet can be displayed to hide the question text. Mainly useful for strengthening listening skills.';
			case 'answerSettings.choices_cover': return 'Choices Cover';
			case 'answerSettings.choices_cover_description': return 'In choice questions, you can display a sheet that hides the choices.';
			case 'answerSettings.strict_solving_mode': return 'Strict Answer Mode';
			case 'answerSettings.strict_solving_mode_description': return 'Unanswered questions in the question booklet are only marked as answered if they are answered correctly, not just answered.';
			case 'answerSettings.se_enabled': return 'Sound Effects';
			case 'answerSettings.se_enabled_description': return 'If you find level-up and other sound effects too noisy, turn them off.';
			case 'answerSettings.effect_enabled': return 'Display rewards and feedbacks';
			case 'answerSettings.effect_enabled_description': return 'If the rewards and feedback for solving questions seem intrusive, turn it off.';
			case 'answerSettings.review_setting': return 'Review Setting';
			case 'answerSettings.strict_reviewing_mode': return 'Strict Review Mode';
			case 'answerSettings.strict_reviewing_mode_description': return 'The condition for removing a question from the unreviewed is only if it is answered correctly, not just answered.';
			case 'answerSettings.initial_interval': return 'Initial Interval';
			case 'answerSettings.initial_interval_description': return 'You can decide the interval between review sessions, which are set automatically when you press the \'Remember\' button or make a mistake on a question.';
			case 'answerSettings.interval_step_up_condition': return 'Conditions for extending intervals';
			case 'answerSettings.interval_step_up_condition_description': return 'Determine the conditions for extending the intervals between reviews.';
			case 'answerSettings.interval_step_up_condition_1': return 'If you answer correctly';
			case 'answerSettings.interval_step_up_condition_2': return 'Two correct answers in a row';
			case 'answerSettings.interval_step_up_condition_3': return 'Three correct answers in a row';
			case 'answerSettings.interval_step_up_condition_4': return 'Four correct answers in a row';
			case 'answerSettings.interval_step_up_condition_5': return 'Five correct answers in a row';
			case 'answerSettings.review_delete_condition': return 'Review release conditions';
			case 'answerSettings.review_delete_condition_description': return 'You can determine the conditions under which the review is removed.';
			case 'answerSettings.review_delete_condition_0': return 'Correct in the next day\'s review';
			case 'answerSettings.review_delete_condition_1': return 'Correct in three days\' review';
			case 'answerSettings.review_delete_condition_2': return 'Correct in a week\'s review';
			case 'answerSettings.review_delete_condition_3': return 'Correct in two weeks\' review';
			case 'answerSettings.review_delete_condition_4': return 'Correct in three weeks\' review';
			case 'answerSettings.review_delete_condition_5': return 'Correct in a month\'s review';
			case 'answerSettings.review_delete_condition_6': return 'Correct in two months\' review';
			case 'answerSettings.review_delete_condition_7': return 'Correct in three months\' review';
			case 'answerSettings.review_delete_condition_8': return 'Correct in six months\' review';
			case 'answerSettings.review_delete_condition_9': return 'Correct in a year\'s review';
			case 'answerSettings.weakness_setting': return 'Weakness Setting';
			case 'answerSettings.weakness_condition': return 'Conditions for making it vulnerable';
			case 'answerSettings.weakness_condition_description': return 'You can decide which conditions to add questions to your difficulties.';
			case 'answerSettings.weakness_condition_0': return 'Not set up automatically';
			case 'answerSettings.weakness_condition_1': return 'More than one mistake';
			case 'answerSettings.weakness_condition_2': return 'More than two mistakes';
			case 'answerSettings.weakness_condition_3': return 'More than three mistakes';
			case 'answerSettings.weakness_condition_4': return 'More than four mistakes';
			case 'answerSettings.weakness_condition_5': return 'More than five mistakes';
			case 'answerSettings.overcoming_condition': return 'Conditions to overcome';
			case 'answerSettings.overcoming_condition_description': return 'You can determine the conditions to be removed from the weakness.';
			case 'answerSettings.overcoming_condition_0': return 'If you answer it';
			case 'answerSettings.overcoming_condition_1': return 'If you answer it correctly';
			case 'answerSettings.overcoming_condition_120': return 'Not automatically overcome';
			case 'answerSettings.overcoming_condition_i': return ({required Object percentage}) => 'Above ${percentage}% correct answer rate';
			case 'answerSettings.change_settings': return 'Change Settings';
			case 'answerSettings.update_succeeded': return 'Settings Updated';
			case 'answerSettings.update_failed': return 'Failed to update configuration.';
			case 'answerSettings.se_switched': return ({required Object state}) => 'Sound effects turned ${state}.';
			case 'answerSettings.review_notification_enabled': return 'Review Reminder';
			case 'answerSettings.review_notification_enabled_description': return 'Notification is sent at a specified time when there are questions to be reviewed that day.';
			case 'answerSettings.set_review_notification': return 'Set review time';
			case 'answerSettings.set_review_notification_description': return 'To help you learn more efficiently, we send you reminders when there are questions to review. Set a time when you are available to study.';
			case 'answerSettings.review_notification_set': return ({required Object hours}) => 'Review reminder set for ${hours}:00.';
			case 'answerAnalyses.answer_analyses': return 'Answer Analyses';
			case 'answerAnalyses.answer_histories': return 'Answer Histories';
			case 'answerAnalyses.premium_recommendation': return 'To access these features, you need to register for a premium plan.';
			case 'answerAnalyses.correct_answer_rate_asc': return 'Correct Rate, Low to High';
			case 'answerAnalyses.correct_answer_rate_desc': return 'Correct Rate, High to Low';
			case 'answerAnalyses.incorrect_answer_histories_count_desc': return 'Mistakes, Most to Least';
			case 'answerAnalyses.incorrect_answer_histories_count_asc': return 'Mistakes, Least to Most';
			case 'answerAnalyses.last_answered_at_desc': return 'Answered History, New to Old';
			case 'answerAnalyses.last_answered_at_asc': return 'Answered History, Old to New';
			case 'achievements.medals_won': return 'Medals won';
			case 'lang.google_translation': return 'Google Translation';
			case 'lang.deepl_translation': return 'DeepL Translation';
			case 'lang.translating': return 'Translating...';
			case 'lang.done': return 'Done';
			case 'lang.translation_failed': return 'Translation Failed';
			case 'lang.translation_restricted': return ({required Object number}) => 'Free users are limited to ${number} translations per day.';
			case 'lang.deepl_not_supported': return ({required Object language}) => '${language} is not supported by DeepL.';
			case 'lang.google_not_supported': return ({required Object language}) => '${language} is not supported by Google.';
			case 'lang.need_to_login': return 'You need to log in to use the translation.';
			case 'lang.language': return 'Language';
			case 'lang.language_setting': return 'Language Setting';
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
			case 'chapters.lang_number': return 'Language Setting';
			case 'chapters.lang_number_error': return '：Auto-configuration failed. Please select language type manually. ';
			case 'chapters.chapters': return 'Chapters';
			case 'chapters.answers': return 'answers';
			case 'chapters.view_details': return 'View Details';
			case 'chapters.administrators': return 'Administrators';
			case 'chapters.moderators': return 'Moderators';
			case 'chapters.admin_functions': return 'Admin Functions';
			case 'chapters.subscribers_list': return 'Subscribers List';
			case 'chapters.manage_moderators': return 'Manage Moderators';
			case 'chapters.setting': return 'Chapter Setting';
			case 'chapters.setting_updated': return 'Chapter setting updated.';
			case 'chapters.new_section': return 'Create Section';
			case 'chapters.edit_section': return 'Edit Section';
			case 'chapters.drills': return 'Drills';
			case 'chapters.post': return 'Create Drill';
			case 'chapters.view_more': return 'View More';
			case 'chapters.create_drill': return 'Create Drill';
			case 'chapters.subscribe': return 'Subscribe';
			case 'chapters.subscribed': return 'Subscribed';
			case 'chapters.create_chapter': return 'Create Chapter';
			case 'chapters.title_placeholder': return 'Please input the name of the chapter.';
			case 'chapters.introduction': return 'Introduction';
			case 'chapters.introduction_placeholder': return 'Please input an explanation about the chapter.';
			case 'chapters.create': return 'Create';
			case 'chapters.creating_succeeded': return 'Creating chapter succeeded';
			case 'chapters.creating_failed': return 'Creating chapter failed.';
			case 'chapters.drill': return 'Drill';
			case 'chapters.activities': return 'Activities';
			case 'experiencePoints.to_the_next_level': return ({required Object points}) => '${points} EXP to the next level.';
			case 'sentences.sentences': return 'Sentences';
			case 'sentences.sentence': return 'Sentence';
			case 'sentences.add': return 'Add sentence';
			case 'sentences.edit': return 'Edit sentence';
			case 'sentences.remove': return 'Remove sentence';
			case 'sentences.destroy': return 'Delete sentence';
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
			case 'sentences.difficulty': return 'Difficulty';
			case 'sentences.easy': return 'Easy';
			case 'sentences.normal': return 'Normal';
			case 'sentences.difficult': return 'Difficult';
			case 'sentences.keeping_form': return 'Do not alter keywords';
			case 'sentences.model': return 'AI Type';
			case 'sentences.gpt_3_5': return 'GPT-3.5（Fast）';
			case 'sentences.gpt_4': return 'GPT-4（Slow but Clever）';
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
			case 'sentences.no_item_found': return ({required Object keyword}) => 'No example sentences containing "${keyword}" were found.';
			case 'sentences.review_label': return 'Be able to read';
			case 'sentences.review_label_listening': return 'Be able to listen';
			case 'sentences.reversed_review_label': return 'be able to speak';
			case 'notes.notes': return 'Notes';
			case 'notes.note': return 'Note';
			case 'notes.note_placeholder': return 'A notebook that only you can view. It can also be used as a hint for the question.';
			case 'notes.edit': return 'Edit';
			case 'notes.update': return 'Update';
			case 'notes.paywall_message': return 'Premium membership gives you access to the Notes function.';
			case 'notes.destroy': return 'Delete';
			case 'notes.confirmation': return 'Confirmation';
			case 'notes.confirmation_text': return 'Are you sure you want to delete this note?';
			case 'notes.updated_at_desc': return 'Updated, New to Old';
			case 'notes.updated_at_asc': return 'Updated, Old to New';
			case 'notes.created_at_desc': return 'Created, New to Old';
			case 'notes.created_at_asc': return 'Created, Old to New';
			case 'ranking.ranking': return 'Ranking';
			case 'ranking.daily': return 'Daily';
			case 'ranking.weekly': return 'Weekly';
			case 'ranking.monthly': return 'Monthly';
			case 'ranking.daily_answerer': return 'Daily Answerers Ranking';
			case 'ranking.weekly_answerer': return 'Weekly Answerers Ranking';
			case 'ranking.monthly_answerer': return 'Monthly Answerers Ranking';
			case 'ranking.rank': return ({required Object number}) => 'No.${number}';
			case 'timeZone.international_date_line_west': return 'International Date Line West';
			case 'timeZone.american_samoa': return 'American Samoa';
			case 'timeZone.midway_island': return 'Midway Island';
			case 'timeZone.hawaii': return 'Hawaii';
			case 'timeZone.alaska': return 'Alaska';
			case 'timeZone.pacific_time_us_canada': return 'Pacific Time (US & Canada)';
			case 'timeZone.tijuana': return 'Tijuana';
			case 'timeZone.arizona': return 'Arizona';
			case 'timeZone.mazatlan': return 'Mazatlan';
			case 'timeZone.mountain_time_us_canada': return 'Mountain Time (US & Canada)';
			case 'timeZone.central_america': return 'Central America';
			case 'timeZone.central_time_us_canada': return 'Central Time (US & Canada)';
			case 'timeZone.chihuahua': return 'Chihuahua';
			case 'timeZone.guadalajara': return 'Guadalajara';
			case 'timeZone.mexico_city': return 'Mexico City';
			case 'timeZone.monterrey': return 'Monterrey';
			case 'timeZone.saskatchewan': return 'Saskatchewan';
			case 'timeZone.bogota': return 'Bogota';
			case 'timeZone.eastern_time_us_canada': return 'Eastern Time (US & Canada)';
			case 'timeZone.indiana_east': return 'Indiana (East)';
			case 'timeZone.lima': return 'Lima';
			case 'timeZone.quito': return 'Quito';
			case 'timeZone.atlantic_time_canada': return 'Atlantic Time (Canada)';
			case 'timeZone.caracas': return 'Caracas';
			case 'timeZone.georgetown': return 'Georgetown';
			case 'timeZone.la_paz': return 'La Paz';
			case 'timeZone.puerto_rico': return 'Puerto Rico';
			case 'timeZone.santiago': return 'Santiago';
			case 'timeZone.newfoundland': return 'Newfoundland';
			case 'timeZone.brasilia': return 'Brasilia';
			case 'timeZone.buenos_aires': return 'Buenos Aires';
			case 'timeZone.greenland': return 'Greenland';
			case 'timeZone.montevideo': return 'Montevideo';
			case 'timeZone.mid_atlantic': return 'Mid-Atlantic';
			case 'timeZone.azores': return 'Azores';
			case 'timeZone.cape_verde_is': return 'Cape Verde Is.';
			case 'timeZone.casablanca': return 'Casablanca';
			case 'timeZone.dublin': return 'Dublin';
			case 'timeZone.edinburgh': return 'Edinburgh';
			case 'timeZone.lisbon': return 'Lisbon';
			case 'timeZone.london': return 'London';
			case 'timeZone.monrovia': return 'Monrovia';
			case 'timeZone.utc': return 'UTC';
			case 'timeZone.amsterdam': return 'Amsterdam';
			case 'timeZone.belgrade': return 'Belgrade';
			case 'timeZone.berlin': return 'Berlin';
			case 'timeZone.bern': return 'Bern';
			case 'timeZone.bratislava': return 'Bratislava';
			case 'timeZone.brussels': return 'Brussels';
			case 'timeZone.budapest': return 'Budapest';
			case 'timeZone.copenhagen': return 'Copenhagen';
			case 'timeZone.ljubljana': return 'Ljubljana';
			case 'timeZone.madrid': return 'Madrid';
			case 'timeZone.paris': return 'Paris';
			case 'timeZone.prague': return 'Prague';
			case 'timeZone.rome': return 'Rome';
			case 'timeZone.sarajevo': return 'Sarajevo';
			case 'timeZone.skopje': return 'Skopje';
			case 'timeZone.stockholm': return 'Stockholm';
			case 'timeZone.vienna': return 'Vienna';
			case 'timeZone.warsaw': return 'Warsaw';
			case 'timeZone.west_central_africa': return 'West Central Africa';
			case 'timeZone.zagreb': return 'Zagreb';
			case 'timeZone.zurich': return 'Zurich';
			case 'timeZone.athens': return 'Athens';
			case 'timeZone.bucharest': return 'Bucharest';
			case 'timeZone.cairo': return 'Cairo';
			case 'timeZone.harare': return 'Harare';
			case 'timeZone.helsinki': return 'Helsinki';
			case 'timeZone.jerusalem': return 'Jerusalem';
			case 'timeZone.kaliningrad': return 'Kaliningrad';
			case 'timeZone.kyiv': return 'Kyiv';
			case 'timeZone.pretoria': return 'Pretoria';
			case 'timeZone.riga': return 'Riga';
			case 'timeZone.sofia': return 'Sofia';
			case 'timeZone.tallinn': return 'Tallinn';
			case 'timeZone.vilnius': return 'Vilnius';
			case 'timeZone.baghdad': return 'Baghdad';
			case 'timeZone.istanbul': return 'Istanbul';
			case 'timeZone.kuwait': return 'Kuwait';
			case 'timeZone.minsk': return 'Minsk';
			case 'timeZone.moscow': return 'Moscow';
			case 'timeZone.nairobi': return 'Nairobi';
			case 'timeZone.riyadh': return 'Riyadh';
			case 'timeZone.st_petersburg': return 'St. Petersburg';
			case 'timeZone.volgograd': return 'Volgograd';
			case 'timeZone.tehran': return 'Tehran';
			case 'timeZone.abu_dhabi': return 'Abu Dhabi';
			case 'timeZone.baku': return 'Baku';
			case 'timeZone.muscat': return 'Muscat';
			case 'timeZone.samara': return 'Samara';
			case 'timeZone.tbilisi': return 'Tbilisi';
			case 'timeZone.yerevan': return 'Yerevan';
			case 'timeZone.kabul': return 'Kabul';
			case 'timeZone.ekaterinburg': return 'Ekaterinburg';
			case 'timeZone.islamabad': return 'Islamabad';
			case 'timeZone.karachi': return 'Karachi';
			case 'timeZone.tashkent': return 'Tashkent';
			case 'timeZone.chennai': return 'Chennai';
			case 'timeZone.kolkata': return 'Kolkata';
			case 'timeZone.mumbai': return 'Mumbai';
			case 'timeZone.new_delhi': return 'New Delhi';
			case 'timeZone.sri_jayawardenepura': return 'Sri Jayawardenepura';
			case 'timeZone.kathmandu': return 'Kathmandu';
			case 'timeZone.almaty': return 'Almaty';
			case 'timeZone.astana': return 'Astana';
			case 'timeZone.dhaka': return 'Dhaka';
			case 'timeZone.urumqi': return 'Urumqi';
			case 'timeZone.rangoon': return 'Rangoon';
			case 'timeZone.bangkok': return 'Bangkok';
			case 'timeZone.hanoi': return 'Hanoi';
			case 'timeZone.jakarta': return 'Jakarta';
			case 'timeZone.krasnoyarsk': return 'Krasnoyarsk';
			case 'timeZone.novosibirsk': return 'Novosibirsk';
			case 'timeZone.beijing': return 'Beijing';
			case 'timeZone.chongqing': return 'Chongqing';
			case 'timeZone.hong_kong': return 'Hong Kong';
			case 'timeZone.irkutsk': return 'Irkutsk';
			case 'timeZone.kuala_lumpur': return 'Kuala Lumpur';
			case 'timeZone.perth': return 'Perth';
			case 'timeZone.singapore': return 'Singapore';
			case 'timeZone.taipei': return 'Taipei';
			case 'timeZone.ulaanbaatar': return 'Ulaanbaatar';
			case 'timeZone.osaka': return 'Osaka';
			case 'timeZone.sapporo': return 'Sapporo';
			case 'timeZone.seoul': return 'Seoul';
			case 'timeZone.tokyo': return 'Tokyo';
			case 'timeZone.yakutsk': return 'Yakutsk';
			case 'timeZone.adelaide': return 'Adelaide';
			case 'timeZone.darwin': return 'Darwin';
			case 'timeZone.brisbane': return 'Brisbane';
			case 'timeZone.canberra': return 'Canberra';
			case 'timeZone.guam': return 'Guam';
			case 'timeZone.hobart': return 'Hobart';
			case 'timeZone.melbourne': return 'Melbourne';
			case 'timeZone.port_moresby': return 'Port Moresby';
			case 'timeZone.sydney': return 'Sydney';
			case 'timeZone.vladivostok': return 'Vladivostok';
			case 'timeZone.magadan': return 'Magadan';
			case 'timeZone.new_caledonia': return 'New Caledonia';
			case 'timeZone.solomon_is': return 'Solomon Is.';
			case 'timeZone.srednekolymsk': return 'Srednekolymsk';
			case 'timeZone.auckland': return 'Auckland';
			case 'timeZone.fiji': return 'Fiji';
			case 'timeZone.kamchatka': return 'Kamchatka';
			case 'timeZone.marshall_is': return 'Marshall Is.';
			case 'timeZone.wellington': return 'Wellington';
			case 'timeZone.chatham_is': return 'Chatham Is.';
			case 'timeZone.nuku_alofa': return 'Nuku\'alofa';
			case 'timeZone.samoa': return 'Samoa';
			case 'timeZone.tokelau_is': return 'Tokelau Is.';
			case 'answer.answers_count': return ({required Object count}) => '${count} answers';
			case 'answer.limit_reached': return 'Limit Reached';
			case 'answer.limit_reached_description': return ({required Object number}) => 'Free users can anwer up to ${number} questions per day. Become a premium member and answer unlimited questions!';
			case 'quizzes.quiz': return 'Quiz';
			case 'quizzes.edit': return 'Edit';
			case 'quizzes.answer': return 'Answer';
			case 'quizzes.see_correct_answer': return 'See correct answer';
			case 'quizzes.correct': return 'Correct';
			case 'quizzes.wrong': return 'Wrong';
			case 'quizzes.got_a_correct': return 'Got a correct';
			case 'quizzes.made_a_mistake': return 'Made a mistake';
			case 'quizzes.question': return 'Question';
			case 'quizzes.question_placeholder': return '【Required】Please input a question.';
			case 'quizzes.correct_answer': return 'Correct Answer';
			case 'quizzes.correct_answer_placeholder': return '【Required】Please input a correct answer.';
			case 'quizzes.distractors': return 'Distractors';
			case 'quizzes.distractors_placeholder': return 'You can input a distractor.';
			case 'quizzes.explanation': return 'Explanation';
			case 'quizzes.explanation_placeholder': return 'You can input a explanation.';
			case 'quizzes.hint': return 'Hint';
			case 'quizzes.hint_placeholder': return 'You can input a hint for the question.';
			case 'quizzes.corrected_time_ago': return 'Corrected %{time} ago';
			case 'quizzes.incorrect_time_ago': return 'Incorrect %{time} ago';
			case 'quizzes.correct_answer_rate': return '%{percent}% of correct answers';
			case 'activities.activities': return 'Activities';
			case 'activities.cheer': return 'Cheer!';
			case 'activities.cheered': return 'Cheered!';
			case 'answerHistories.answer_histories': return 'Answer Histories';
			case 'answerHistories.todays_mistakes': return 'Today\'s Mistakes';
			case 'wordRequests.word_requests': return 'Edit histories of dictionaries';
			case 'wordRequests.edit_histories': return 'Edit Histories';
			case 'wordRequests.pending_edits': return 'Pending Edits';
			case 'wordRequests.rejected_edits': return 'Rejected Edits';
			case 'wordRequests.edit_applied': return 'Your edit applied.';
			case 'wordRequests.addition_request_submitted': return 'Your addition request submitted.';
			case 'wordRequests.modification_request_submitted': return 'Your modification request submitted.';
			case 'wordRequests.elimination_request_submitted': return 'Your elimination request submitted.';
			case 'wordRequests.already_submitted': return 'You have already submitted a request.';
			case 'wordRequests.addition': return 'Addition of item';
			case 'wordRequests.modification': return 'Modification of item';
			case 'wordRequests.elimination': return 'Deletion of item';
			case 'wordRequests.acceptance': return 'Adopted';
			case 'wordRequests.rejection': return 'Rejected';
			case 'wordRequests.pending': return 'Pending';
			case 'wordRequests.accept': return 'Adopt';
			case 'wordRequests.reject': return 'Reject';
			case 'wordRequests.editor_comment': return 'Editor\'s comment';
			case 'wordRequests.comments': return 'Comments';
			case 'wordRequests.cancel': return 'Withdraw an request';
			case 'wordRequests.canceled': return 'The request has been withdrawn.';
			case 'wordRequests.target': return 'Edit Target';
			case 'wordRequests.target_already_deleted': return 'The edit target has already been deleted.';
			case 'wordRequests.target_not_found': return 'The edit target was not found.';
			case 'wordRequests.show_heading': return 'Request details';
			case 'wordRequests.accepted': return 'The request has been adopted.';
			case 'wordRequests.rejected': return 'The request has been rejected.';
			case 'wordRequests.edited_at': return ({required Object time}) => 'Edited ${time} ago';
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
			case 'words.pos_tag_id': return 'Part of speech';
			case 'words.meaning': return 'Meaning';
			case 'words.ipa': return 'IPA(Pronunciation)';
			case 'words.search_sentence': return 'Search Example Sentences';
			case 'words.search_sentence_placeholder': return 'Please enter keywords.';
			case 'words.no_sentence': return 'No example sentence is set.';
			case 'words.set_sentence_with_ai': return 'Set an example sentence with AI';
			case 'words.generate_meaning_with_ai': return 'Generate meanings with AI';
			case 'words.meaning_generation_keyword_placeholder': return 'keywords to generate the meaning.';
			case 'words.success_to_generate_meanings': return 'Successful generation of meanings.';
			case 'words.failed_to_generate_meanings': return 'Generation of meanings failed.';
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
			case 'purchase.premium_plan': return 'Premium Plan';
			case 'purchase.premium_plan_description': return 'This plan allows unlimited use of all DiQt features.';
			case 'purchase.trial_period_description': return 'Now with a 2-week free trial period!';
			case 'purchase.free_plan': return 'Free';
			case 'purchase.yen': return 'Yen';
			case 'purchase.answers_limit': return 'Number of answers per day';
			case 'purchase.unlimited': return 'Unlimited';
			case 'purchase.translations_limit': return 'Number of translations per day';
			case 'purchase.ad_free': return 'Ad-free';
			case 'purchase.weakness': return 'The Weakness Questions';
			case 'purchase.note': return 'Notes';
			case 'purchase.answer_analysis': return 'Answer Analyses';
			case 'purchase.answer_history': return 'Answer histories';
			case 'purchase.questions_you_got_wrong': return 'Questions you got wrong today';
			case 'purchase.deletion_of_all_reviews': return 'Deletion of all reviews';
			case 'purchase.monthly_plan': return 'Monthly';
			case 'purchase.month': return 'Month';
			case 'purchase.annual_plan': return 'Annual';
			case 'purchase.year': return 'Year';
			case 'purchase.two_months_free': return '2 months\' savings!';
			case 'purchase.start_free_trial': return 'Start Free Trial';
			case 'purchase.get_started': return 'Get Started';
			case 'purchase.registered': return 'Registered';
			case 'purchase.bank_transfer': return 'If you wish to make a bank transfer, please click here';
			case 'purchase.stripe_explanation': return 'We use Stripe for payments - Stripe is a secure payment system widely used around the world and we do not store your card details on our servers.';
			case 'purchase.auto_renew_explanation': return 'Plans are auto-renewing. If you cancel via payment settings at least 24 hours before the expiry date, your plan will not be auto-renewed.';
			case 'purchase.this_is_premium_plan_feature': return 'This is a feature for premium members.';
			case 'purchase.all_features_will_be_available': return 'All features will be available.';
			case 'purchase.notice': return 'Seven days\' notice before the charge is made.';
			case 'purchase.cancel_at_any_time': return 'You can cancel at any time.';
			case 'purchase.monthly_plan_price': return '¥500／Month';
			case 'purchase.annual_plan_price': return '¥5,000／Year';
			case 'purchase.purchase_succeded': return 'You are now a premium member!';
			case 'purchase.view_premium_plan_benefits': return 'View Premium Plan benefits';
			case 'purchase.view_premium_plan': return 'View Premium Plan';
			case 'purchase.premium_plan_benefits': return 'Premium Plan Benefits';
			case 'purchase.unlimited_answers': return 'Unlimited Answers';
			case 'purchase.unlimited_answers_description': return ({required Object number}) => 'Free users can only answer ${number} questions daily, but as a premium member, you can answer as many questions as you like in a day.';
			case 'purchase.unlimited_translations': return 'Unlimited Translations';
			case 'purchase.unlimited_translations_description': return ({required Object number}) => 'Free users can only translate ${number} times a day, but premium members can translate as many times a day as they like.';
			case 'purchase.weakness_description': return 'Premium members can focus on questions with low percentage of correct answers.';
			case 'purchase.note_description': return 'Premium members will be able to leave notes on answered questions.';
			case 'purchase.answer_analysis_description': return 'Premium members can analyze the questions they have answered by the percentage of correct answers and the number of mistakes.';
			case 'purchase.answer_history_description': return 'If you are a premium member, you can view the history of questions you have answered.';
			case 'purchase.questions_you_got_wrong_description': return 'If you are a premium member, you can review the questions you got wrong that day.';
			case 'purchase.deletion_of_all_reviews_description': return 'If you are a premium member, you can cancel all the reviews you have set up.';
			case 'purchase.ad_free_description': return 'If you are a premium member, you will no longer see all adverts in the app.';
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
			case 'home.inquiry': return 'Inquiry';
			case 'home.maintenance_mode': return 'Under maintenance';
			case 'home.maintenance_description': return 'We are very sorry. DiQt is currently undergoing maintenance. We hope you will be able to access it again in a while.';
			case 'home.maintenance_latest_information': return 'Click here for the latest information.';
			case 'drillLaps.resume': return 'Resume';
			case 'drillLaps.view_more': return 'View More';
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
			case 'dictionaries.reversed_sentence_drill': return 'スピーキングとライティングのための例文問題';
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
			case 'reviews.reviews': return '復習';
			case 'reviews.unreviewed': return '未復習';
			case 'reviews.scheduled': return '予定';
			case 'reviews.all': return 'すべて';
			case 'reviews.order': return '順番';
			case 'reviews.random_random': return 'ランダム';
			case 'reviews.scheduled_date_desc': return '予定日が新しい順';
			case 'reviews.scheduled_date_asc': return '予定日が古い順';
			case 'reviews.empty': return '復習問題はありません。';
			case 'reviews.memorize': return '覚える';
			case 'reviews.set_review': return '復習を設定する';
			case 'reviews.scheduled_date': return '復習予定日';
			case 'reviews.interval': return '復習の間隔';
			case 'reviews.destroy': return '復習予定を取り消す';
			case 'reviews.tomorrow': return '翌日';
			case 'reviews.after_3_days': return '3日後';
			case 'reviews.after_a_week': return '1週間後';
			case 'reviews.after_2_week': return '2週間後';
			case 'reviews.after_3_week': return '3週間後';
			case 'reviews.after_a_month': return '1ヶ月後';
			case 'reviews.after_2_month': return '2ヶ月後';
			case 'reviews.after_3_month': return '3ヶ月後';
			case 'reviews.after_6_month': return '6ヶ月後';
			case 'reviews.after_a_year': return '1年後';
			case 'reviews.review_for': return ({required Object interval}) => '${interval}に復習する';
			case 'reviews.has_been_set_for': return ({required Object interval}) => '${interval}に復習を設定しました。';
			case 'reviews.schedule_canceled': return '復習予定を取り消しました。';
			case 'reviews.cancel_all_schedules': return 'すべての復習予定を取り消す';
			case 'reviews.all_schedules_canceled': return 'すべての復習予定を取り消しました。';
			case 'reviews.details_of_the_question': return '復習する問題の詳細';
			case 'reviews.error_occurred': return '復習にエラーが発生しました。';
			case 'reviews.fix_error': return 'エラーを修正する';
			case 'reviews.error_fixed': return 'エラーを修正しました。';
			case 'errors.error_message_404': return 'ページが見つかりませんでした。';
			case 'errors.error_message_505': return '大変申し訳ございません。サーバーでエラーが発生しました。';
			case 'errors.cant_be_blank': return 'この項目は空欄にできません。';
			case 'errors.error_occured': return 'エラーが発生しました。';
			case 'errors.http_status_400': return '400 Bad Request: 無効なリクエストです';
			case 'errors.http_status_401': return '401 Unauthorized: アクセス権が無いか、あるいは認証に失敗しました。';
			case 'errors.http_status_402': return '402 Payment Required: 申し訳ありませんが、要求されたリソースにアクセスする前に支払いが必要です。アカウントの状態を確認してください。';
			case 'errors.http_status_403': return '403 Forbidden: 申し訳ありませんが、このリソースにアクセスする権限がありません。これが間違いだと思う場合は、管理者に連絡してください。';
			case 'errors.http_status_404': return '404 Not Found: 申し訳ありませんが、要求されたリソースはこのサーバー上に見つかりませんでした。';
			case 'errors.http_status_405': return '405 Method Not Allowed: 申し訳ありませんが、リクエストで使用されたHTTPメソッドは、リソースに対して許可されていません。';
			case 'errors.http_status_406': return '406 Not Acceptable: 申し訳ありませんが、サーバーはあなたのAcceptヘッダーを満足させるレスポンスを提供できません。リクエストを修正して再試行してください。';
			case 'errors.http_status_407': return '407 Proxy Authentication Required: 申し訳ありませんが、まずプロキシサーバーで自分を認証する必要があります。続行するにはログインしてください。';
			case 'errors.http_status_408': return '408 Request Timeout: 申し訳ありません、リクエストがタイムアウトしました。ネットワーク接続を確認して、もう一度試してください。';
			case 'errors.http_status_409': return '409 Conflict: 申し訳ありませんが、要求された操作との間に競合がありました。入力を確認して再試行してください。';
			case 'errors.http_status_410': return '410 Gone: 申し訳ありませんが、要求されたリソースはこのサーバー上で利用できなくなり、転送先のアドレスは不明です。';
			case 'errors.http_status_411': return '411 Length Required: 申し訳ありませんが、サーバーはリクエストに有効なContent-Lengthヘッダーフィールドを必要とします。それを含めて再試行してください。';
			case 'errors.http_status_412': return '412 Precondition Failed: 申し訳ありませんが、リクエストヘッダーフィールドで指定した1つ以上の前提条件が偽と評価されました。';
			case 'errors.http_status_413': return '413 Payload Too Large: 申し訳ありませんが、リクエストエンティティがサーバーが処理する能力を超えています。';
			case 'errors.http_status_414': return '414 URI Too Long: 申し訳ありませんが、提供されたURIはサーバーが処理するには長すぎます。短くしてから再試行してください。';
			case 'errors.http_status_415': return '415 Unsupported Media Type: 申し訳ありませんが、サーバーはリクエストで示されたメディアタイプをサポートしていません。確認してから再試行してください。';
			case 'errors.http_status_416': return '416 Range Not Satisfiable: 申し訳ありませんが、クライアントがファイルの一部を求めていますが、サーバーはその部分を提供できません。';
			case 'errors.http_status_417': return '417 Expectation Failed: 申し訳ありませんが、Expectリクエストヘッダーフィールドで指定した期待値はサーバーでは満たすことができませんでした。';
			case 'errors.http_status_418': return '418 I\'m a teapot: Sorry, 申し訳ありません、私はティーポットです。要求されたエンティティボディは短くてずんぐりむっくりしていて、取っ手はここ、注ぎ口はそこです。';
			case 'errors.http_status_421': return '421 Misdirected Request: 申し訳ありませんが、リクエストはレスポンスを生成できないサーバーに向けられました。';
			case 'errors.http_status_422': return '422 Unprocessable Entity: 申し訳ありませんが、サーバーはリクエストエンティティのコンテンツタイプを理解し、リクエストエンティティの構文も正しいのですが、含まれている指示を処理することができませんでした。';
			case 'errors.http_status_423': return '423 Locked: 申し訳ありませんが、アクセスしようとしているリソースはロックされています。';
			case 'errors.http_status_424': return '424 Failed Dependency: 申し訳ありませんが、要求されたアクションが別のアクションに依存していてそのアクションが失敗したため、リソースに対してメソッドを実行することができませんでした。';
			case 'errors.http_status_425': return '425 Too Early: 申し訳ありませんが、サーバーはリプレイされる可能性のあるリクエストを処理するリスクを冒したくありません。';
			case 'errors.http_status_426': return '426 Upgrade Required: 申し訳ありませんが、クライアントはUpgradeヘッダーフィールドで指定されているTLS/1.0などの別のプロトコルに切り替える必要があります。';
			case 'errors.http_status_427': return '427 Unassigned: 申し訳ありませんが、このエラーコードは現在割り当てられておらず、使用することはできません。';
			case 'errors.http_status_428': return '428 Precondition Required: 申し訳ありませんが、オリジンサーバーはリクエストが条件付きであることを要求しています。これは「ロストアップデート」問題を防ぐためのものです。';
			case 'errors.http_status_429': return '429 Too Many Requests: 申し訳ありませんが、指定された時間内に送信されるリクエストが多すぎます。後でもう一度お試しください。';
			case 'errors.http_status_431': return '431 Request Header Fields Too Large: 申し訳ありませんが、個々のヘッダーフィールドやすべてのヘッダーフィールドがまとめて大きすぎるため、サーバーはリクエストを処理することを拒否しています。';
			case 'errors.http_status_500': return '500 Internal Server Error: 申し訳ありません、サーバー側に何か問題が発生しました。後ほどもう一度お試しください。';
			case 'errors.http_status_501': return '501 Not Implemented: 申し訳ありませんが、リクエストメソッドは実装されていません。確認して再試行してください。';
			case 'errors.http_status_502': return '502 Bad Gateway: 申し訳ありませんが、サーバーは上流のサーバーから無効な応答を受け取りました。再試行してください。';
			case 'errors.http_status_503': return '503 Service Unavailable: 申し訳ありませんが、現在サーバーは利用できません。後ほど再試行してください。';
			case 'errors.http_status_504': return '504 Gateway Timeout: 一時的な過負荷またはメンテナンスのため、現在サーバーはリクエストを処理できません。後ほど再試行してください。';
			case 'errors.http_status_505': return '505 HTTP Version Not Supported: 申し訳ありませんが、リクエストで使用されるHTTPのバージョンはサポートされていません。';
			case 'errors.http_status_506': return '506 Variant Also Negotiates: サーバーに内部構成エラーがあります。選択されたバリアントリソースが透過的コンテンツネゴシエーション自体を行うよう設定されているため、ネゴシエーションプロセスの適切な終点ではありません。';
			case 'errors.http_status_507': return '507 Insufficient Storage: 申し訳ありませんが、サーバーはリクエストを完了するために必要な表現を保存できません。';
			case 'errors.http_status_508': return '508 Loop Detected: サーバーは、リクエストを処理中に無限ループを検出しました。このステータスは、操作全体が失敗したことを示しています。';
			case 'errors.http_status_510': return '510 Not Extended: サーバーがリクエストを満たすためには、リクエストにさらなる拡張が必要です。';
			case 'errors.http_status_511': return '511 Network Authentication Required: ネットワークにアクセスするためには認証が必要です。ネットワークに接続して再試行してください。';
			case 'drills.drills': return 'ドリル';
			case 'drills.unsolved': return '未解答';
			case 'drills.solved': return '解答済';
			case 'drills.search': return '問題を検索する';
			case 'drills.pending_requests': return '審査中のリクエスト';
			case 'drills.accepted_requests': return '承認済のリクエスト';
			case 'drills.create_drill': return 'ドリルを作成する';
			case 'drills.create_drill_with_csv': return 'ドリルをCSVで作成する';
			case 'drills.edit_drill': return 'ドリルを編集する';
			case 'drills.edit_drill_with_csv': return 'CSVでドリルを編集する';
			case 'drills.csv_blank': return 'CSVファイルを添付してください。';
			case 'drills.please_wait': return '作成を開始しました。10秒ほどで出来上がります。';
			case 'drills.created_at_asc': return '最初から';
			case 'drills.created_at_desc': return '最後から';
			case 'drills.random_random': return 'ランダム';
			case 'weaknesses.weaknesses': return '弱点問題';
			case 'weaknesses.premium_recommendation': return '弱点問題を解くには、プレミアムプランへの登録が必要です。';
			case 'weaknesses.correct_answer_rate_asc': return '正答率が低い順';
			case 'weaknesses.correct_answer_rate_desc': return '正答率が高い順';
			case 'weaknesses.incorrect_answers_count_desc': return '不正解が多い順';
			case 'weaknesses.incorrect_answers_count_asc': return '不正解が少ない順';
			case 'weaknesses.created_at_desc': return '追加日が新しい順';
			case 'weaknesses.created_at_asc': return '追加日が古い順';
			case 'weaknesses.random_random': return 'ランダム';
			case 'users.anonymous_user': return '匿名ユーザー';
			case 'users.creating_account_succeeded': return '会員登録が完了しました！ようこそDiQtへ！！';
			case 'users.show': return 'ユーザーページ';
			case 'users.menu': return 'メニュー';
			case 'users.find_users': return 'ユーザーを探す';
			case 'users.contract_details': return 'ご契約内容';
			case 'users.edit': return 'アカウント設定';
			case 'users.withdraw': return 'DiQtから退会する';
			case 'users.withdraw_confirmation': return 'アカウントを削除いたします。削除したアカウントは二度と復元できません。それでもよろしいですか？';
			case 'users.set_icon': return 'アイコンを設定する';
			case 'users.name': return 'ユーザー名';
			case 'users.profile': return 'プロフィール';
			case 'users.profile_placeholder': return '500文字以内でプロフィールを入力してください。';
			case 'users.lang_number': return '言語設定(母語)';
			case 'users.learning_lang_number': return '学習言語';
			case 'users.time_zone_name': return 'タイムゾーン';
			case 'users.you_cant_change_time_zone': return '今日すでに問題に解答してしまっている場合、 タイムゾーンを変更することはできません。明日以降にお試しください。';
			case 'users.authentication': return '認証設定';
			case 'users.email': return 'メールアドレス';
			case 'users.new_password': return '新しいパスワード';
			case 'users.new_password_placeholder': return '半角英数字６文字以上';
			case 'users.new_password_confirmation': return 'パスワード確認';
			case 'users.new_password_confirmation_placeholder': return 'もう一度パスワードを入力してください。';
			case 'users.recommend_setting_password': return 'メールアドレスからもログインできるように、パスワードを設定してください。パスワードを設定しない限り、アカウントの情報を更新することはできません。';
			case 'users.mail_delivered': return 'メールによる通知を受け取る';
			case 'users.updated': return 'アカウントを更新しました。';
			case 'users.failed_to_update': return 'アカウントを更新できませんでした。';
			case 'users.destroyed': return '退会が完了しました。ご利用いただき、誠にありがとうございました。';
			case 'users.drills': return '作成したドリル';
			case 'schools.schools': return '教室';
			case 'schools.school': return '教室';
			case 'schools.name': return '名前';
			case 'schools.name_placeholder': return '教室名を入力してください';
			case 'schools.members': return 'メンバー';
			case 'schools.create_member': return 'メンバーを作成する';
			case 'schools.edit_member': return 'メンバーを編集する';
			case 'schools.invite_member': return 'メンバーを招待する';
			case 'schools.invite': return '招待する';
			case 'schools.remove': return '除名する';
			case 'schools.invitation_limited': return '新たにメンバーを招待するには、メンバーの上限数を増やしてください。';
			case 'schools.invitation_succeeded': return '招待に成功しました。';
			case 'schools.removal_succeeded': return '除名に成功しました。';
			case 'schools.owner': return '創設者';
			case 'schools.admin': return '管理者';
			case 'schools.moderator': return 'モデレーター';
			case 'schools.member': return 'メンバー';
			case 'notices.notifications': return '通知';
			case 'notices.cheered_message': return ({required Object name}) => '${name}があなたを応援しました！';
			case 'notices.followed_message': return ({required Object name}) => '${name}があなたをフォローしました！';
			case 'notices.word_request_accepted_message': return 'あなたの辞書の編集が採用されました！';
			case 'shared.create': return '作成する';
			case 'shared.create_succeeded': return '作成されました。';
			case 'shared.create_failed': return '作成に失敗しました。';
			case 'shared.edit': return '編集する';
			case 'shared.update': return '更新する';
			case 'shared.update_succeeded': return '更新されました。';
			case 'shared.update_failed': return '更新に失敗しました。';
			case 'shared.destroy': return '削除する';
			case 'shared.destroy_confirmation': return '確認';
			case 'shared.destroy_confirmation_description': return '本当に削除してもよろしいですか？';
			case 'shared.destroy_succeeded': return '削除しました。';
			case 'shared.cancel': return 'キャンセルする';
			case 'shared.reload': return '再読み込みする';
			case 'shared.search': return '検索する';
			case 'shared.generate': return '生成する';
			case 'shared.send': return '送信する';
			case 'shared.set_up': return '設定する';
			case 'shared.undefined': return '未定義';
			case 'shared.details': return '詳細';
			case 'shared.view_details': return '詳細を見る';
			case 'shared.view_more': return 'もっと見る';
			case 'shared.please_enter': return ({required Object name}) => '"${name}"を入力してください。';
			case 'shared.no_more_items': return ({required Object name}) => 'すべての${name}を読み込みました';
			case 'shared.no_items_found': return ({required Object name}) => '${name}がありません';
			case 'shared.premium_recommendation': return 'この機能を利用するには、プレミアムプランへの登録が必要です。';
			case 'shared.login_recommendation': return 'この機能を利用するためには、ログインが必要です。';
			case 'shared.processing': return '処理中...';
			case 'shared.done': return '完了';
			case 'shared.download': return 'ダウンロード';
			case 'shared.dictionary_setting': return '辞書設定';
			case 'shared.thumbnail': return 'サムネイル';
			case 'shared.remove_thumbnail': return 'サムネイルを削除する';
			case 'shared.image_alt': return ({required Object name}) => '${name}の画像';
			case 'shared.error_occurred': return 'エラーが発生しました。';
			case 'shared.fix_error': return 'エラーを修正する';
			case 'shared.error_fixed': return 'エラーを修正しました。';
			case 'answerSettings.title': return '解答・復習設定';
			case 'answerSettings.answer_setting': return '解答設定';
			case 'answerSettings.daily_goal': return '1日の目標';
			case 'answerSettings.daily_goal_description': return '1日の目標解答数の目標を定めてください。';
			case 'answerSettings.daily_goal_cant_be_changed': return '本日すでに目標を達成してしまったので、目標を変更できません。';
			case 'answerSettings.question_cover': return '問題文カバー';
			case 'answerSettings.question_cover_description': return '問題文が読み上げられる問題で、問題文を隠すシートを表示できます。主にリスニング力の強化に役立ちます。';
			case 'answerSettings.choices_cover': return '選択肢カバー';
			case 'answerSettings.choices_cover_description': return '選択問題で、選択肢を隠すシートを表示できます。';
			case 'answerSettings.strict_solving_mode': return '厳格解答モード';
			case 'answerSettings.strict_solving_mode_description': return '問題集の未解答の問題を、単なる解答ではなく、正解した場合でのみ解答済にします。';
			case 'answerSettings.se_enabled': return '効果音を鳴らす';
			case 'answerSettings.se_enabled_description': return 'レベルアップなどの効果音がうるさいと感じたらOFFにしてください。';
			case 'answerSettings.effect_enabled': return '報酬やフィードバックを表示する';
			case 'answerSettings.effect_enabled_description': return '問題解答時の報酬やフィードバックが邪魔に感じたらOFFにしてください。';
			case 'answerSettings.review_setting': return '復習設定';
			case 'answerSettings.strict_reviewing_mode': return '厳格復習モード';
			case 'answerSettings.strict_reviewing_mode_description': return '復習の未解答から問題を取り除く条件を、単なる解答ではなく、正解した場合のみにします。';
			case 'answerSettings.initial_interval': return '初期間隔';
			case 'answerSettings.initial_interval_description': return '「覚える」ボタンを押したり、問題に間違えたときに、自動で設定される復習の間隔を決められます。';
			case 'answerSettings.interval_step_up_condition': return '間隔を伸ばす条件';
			case 'answerSettings.interval_step_up_condition_description': return '復習の間隔を伸ばすための条件を決めます。';
			case 'answerSettings.interval_step_up_condition_1': return '正解した場合';
			case 'answerSettings.interval_step_up_condition_2': return '２回連続で正解した場合';
			case 'answerSettings.interval_step_up_condition_3': return '３回連続で正解した場合';
			case 'answerSettings.interval_step_up_condition_4': return '４回連続で正解した場合';
			case 'answerSettings.interval_step_up_condition_5': return '５回連続で正解した場合';
			case 'answerSettings.review_delete_condition': return '復習の解除条件';
			case 'answerSettings.review_delete_condition_description': return '復習を取り除く条件を決められます。';
			case 'answerSettings.review_delete_condition_0': return '翌日の復習で正解した場合';
			case 'answerSettings.review_delete_condition_1': return '３日後の復習で正解した場合';
			case 'answerSettings.review_delete_condition_2': return '１週間後の復習で正解した場合';
			case 'answerSettings.review_delete_condition_3': return '２週間後の復習で正解した場合';
			case 'answerSettings.review_delete_condition_4': return '３週間後の復習で正解した場合';
			case 'answerSettings.review_delete_condition_5': return '１ヶ月後の復習で正解した場合';
			case 'answerSettings.review_delete_condition_6': return '２ヶ月後の復習で正解した場合';
			case 'answerSettings.review_delete_condition_7': return '３ヶ月後の復習で正解した場合';
			case 'answerSettings.review_delete_condition_8': return '６ヶ月後の復習で正解した場合';
			case 'answerSettings.review_delete_condition_9': return '１年後の復習で正解した場合';
			case 'answerSettings.weakness_setting': return '弱点設定';
			case 'answerSettings.weakness_condition': return '弱点にする条件';
			case 'answerSettings.weakness_condition_description': return '苦手な問題に追加する条件を決められます。';
			case 'answerSettings.weakness_condition_0': return '自動で設定しない';
			case 'answerSettings.weakness_condition_1': return '１回以上間違えた場合';
			case 'answerSettings.weakness_condition_2': return '２回以上間違えた場合';
			case 'answerSettings.weakness_condition_3': return '３回以上間違えた場合';
			case 'answerSettings.weakness_condition_4': return '４回以上間違えた場合';
			case 'answerSettings.weakness_condition_5': return '５回以上間違えた場合';
			case 'answerSettings.overcoming_condition': return '克服する条件';
			case 'answerSettings.overcoming_condition_description': return '弱点から取り除く条件を決められます。';
			case 'answerSettings.overcoming_condition_0': return '解答時に克服する';
			case 'answerSettings.overcoming_condition_1': return '正解時に克服する';
			case 'answerSettings.overcoming_condition_120': return '自動で克服しない';
			case 'answerSettings.overcoming_condition_i': return ({required Object percentage}) => '正答率${percentage}%以上';
			case 'answerSettings.change_settings': return '設定を変更する';
			case 'answerSettings.update_succeeded': return '設定を更新しました。';
			case 'answerSettings.update_failed': return '設定の更新に失敗しました。';
			case 'answerSettings.se_switched': return ({required Object state}) => '効果音を${state}にしました。';
			case 'answerSettings.review_notification_enabled': return '復習リマインダー';
			case 'answerSettings.review_notification_enabled_description': return 'その日に復習すべき問題がある場合に、指定した時刻に通知を送ります。';
			case 'answerSettings.set_review_notification': return '復習時刻を設定する';
			case 'answerSettings.set_review_notification_description': return 'あなたが効率的に学習できるように、復習すべき問題があるときにリマインダーを送ります。あなたが学習できる時刻を設定してください。';
			case 'answerSettings.review_notification_set': return ({required Object hours}) => '${hours}時に復習リマインダーを設定しました。';
			case 'answerAnalyses.answer_analyses': return '解答分析';
			case 'answerAnalyses.answer_histories': return '解答履歴';
			case 'answerAnalyses.premium_recommendation': return 'これらの機能を利用するには、プレミアムプランへの登録が必要です。';
			case 'answerAnalyses.correct_answer_rate_asc': return '正答率が低い順';
			case 'answerAnalyses.correct_answer_rate_desc': return '正答率が高い順';
			case 'answerAnalyses.incorrect_answer_histories_count_desc': return '間違いが多い順';
			case 'answerAnalyses.incorrect_answer_histories_count_asc': return '間違いが少ない順';
			case 'answerAnalyses.last_answered_at_desc': return '解答履歴：新しい順';
			case 'answerAnalyses.last_answered_at_asc': return '解答履歴：古い順';
			case 'achievements.medals_won': return '獲得メダル';
			case 'lang.google_translation': return 'Google翻訳';
			case 'lang.deepl_translation': return 'DeepL翻訳';
			case 'lang.translating': return '翻訳中...';
			case 'lang.done': return '完了';
			case 'lang.translation_failed': return '翻訳できませんでした。';
			case 'lang.translation_restricted': return ({required Object number}) => '無料ユーザーが1日に翻訳できる回数は、${number}件までです。';
			case 'lang.deepl_not_supported': return ({required Object language}) => '${language}はDeepLが対応していない言語です。';
			case 'lang.google_not_supported': return ({required Object language}) => '${language}はGoogleが対応していない言語です。';
			case 'lang.need_to_login': return '翻訳機能を利用するにはログインが必要です。';
			case 'lang.language': return '言語';
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
			case 'chapters.lang_number': return '言語設定';
			case 'chapters.lang_number_error': return '：言語を自動で検出できませんでした。言語の種類を手動で設定してください。';
			case 'chapters.chapters': return 'チャプター';
			case 'chapters.answers': return '解答';
			case 'chapters.view_details': return '詳細を見る';
			case 'chapters.administrators': return '管理者';
			case 'chapters.moderators': return '管理者';
			case 'chapters.admin_functions': return '管理機能';
			case 'chapters.subscribers_list': return '購読者一覧';
			case 'chapters.manage_moderators': return 'モデレータを管理する';
			case 'chapters.setting': return 'チャプター設定';
			case 'chapters.setting_updated': return 'チャプター設定を更新しました。';
			case 'chapters.new_section': return 'セクションを作成する';
			case 'chapters.edit_section': return 'セクションを編集する';
			case 'chapters.drills': return 'ドリル';
			case 'chapters.post': return 'ドリルを作成する';
			case 'chapters.view_more': return 'もっと見る';
			case 'chapters.create_drill': return '問題を作成する';
			case 'chapters.subscribe': return '購読する';
			case 'chapters.subscribed': return '購読中';
			case 'chapters.create_chapter': return 'チャプターを作成する';
			case 'chapters.title_placeholder': return 'チャプターの名前を入力してください。';
			case 'chapters.introduction': return '説明';
			case 'chapters.introduction_placeholder': return 'チャプターの説明を入力してください。';
			case 'chapters.create': return '作成する';
			case 'chapters.creating_succeeded': return 'チャプターを作成しました。';
			case 'chapters.creating_failed': return 'チャプターを作成できませんでした。';
			case 'chapters.drill': return '問題集';
			case 'chapters.activities': return '活動';
			case 'experiencePoints.to_the_next_level': return ({required Object points}) => '次のレベルまであと${points}EXP';
			case 'sentences.sentences': return '例文';
			case 'sentences.sentence': return '例文';
			case 'sentences.add': return '例文を追加する';
			case 'sentences.edit': return '例文を編集する';
			case 'sentences.remove': return '例文を取り除く';
			case 'sentences.destroy': return '例文を削除する';
			case 'sentences.original': return '原文';
			case 'sentences.translation': return '翻訳';
			case 'sentences.original_placeholder': return ({required Object language}) => '【必須】${language}の例文を入力してください。';
			case 'sentences.translation_placeholder': return ({required Object language}) => '【必須】例文の${language}の訳を入力してください。';
			case 'sentences.generate_sentence': return 'AIで例文を生成する';
			case 'sentences.keyword_description': return ({required Object limit}) => '例文に含めたいキーワードを入力してください(${limit}文字以内)。';
			case 'sentences.keyword_placeholder': return '例文に含むキーワード';
			case 'sentences.pos': return 'キーワードの品詞';
			case 'sentences.meaning': return 'キーワードの意味（類義語など）';
			case 'sentences.meaning_placeholder': return 'キーワードの意味を指定できます。';
			case 'sentences.difficulty': return '難易度';
			case 'sentences.easy': return '易しい';
			case 'sentences.normal': return '普通';
			case 'sentences.difficult': return '難しい';
			case 'sentences.model': return 'AIの種類';
			case 'sentences.keeping_form': return 'キーワードを変化させない';
			case 'sentences.gpt_3_5': return 'GPT-3.5（速い）';
			case 'sentences.gpt_4': return 'GPT-4（遅いが賢い）';
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
			case 'sentences.no_item_found': return ({required Object keyword}) => '"${keyword}"が含まれる例文は見つかりませんでした。';
			case 'sentences.review_label': return '読めるようになる';
			case 'sentences.review_label_listening': return '聞き取れるようになる';
			case 'sentences.reversed_review_label': return '話せるようになる';
			case 'notes.notes': return 'ノート';
			case 'notes.note': return 'ノート';
			case 'notes.note_placeholder': return 'あなただけが閲覧できるノートです。問題のヒントとしてもご利用いただけます。';
			case 'notes.edit': return '編集する';
			case 'notes.update': return '更新する';
			case 'notes.paywall_message': return 'プレミアム会員になることで、ノート機能をご利用いただけるようになります。';
			case 'notes.destroy': return '削除する';
			case 'notes.confirmation': return '確認';
			case 'notes.confirmation_text': return '本当にこのノートを削除してもよろしいですか？';
			case 'notes.updated_at_desc': return '更新日が新しい順';
			case 'notes.updated_at_asc': return '更新日が古い順';
			case 'notes.created_at_desc': return '作成日が新しい順';
			case 'notes.created_at_asc': return '作成日が古い順';
			case 'ranking.ranking': return 'ランキング';
			case 'ranking.daily': return '日間';
			case 'ranking.weekly': return '週間';
			case 'ranking.monthly': return '月間';
			case 'ranking.daily_answerer': return '日間解答者ランキング';
			case 'ranking.weekly_answerer': return '週間解答者ランキング';
			case 'ranking.monthly_answerer': return '月間解答者ランキング';
			case 'ranking.rank': return ({required Object number}) => '第${number}位';
			case 'timeZone.international_date_line_west': return '国際日付変更線西';
			case 'timeZone.american_samoa': return 'アメリカ領サモア';
			case 'timeZone.midway_island': return 'ミッドウェー島';
			case 'timeZone.hawaii': return 'ハワイ';
			case 'timeZone.alaska': return 'アラスカ';
			case 'timeZone.pacific_time_us_canada': return 'アメリカ・カナダ太平洋時間';
			case 'timeZone.tijuana': return 'ティフアナ';
			case 'timeZone.arizona': return 'アリゾナ';
			case 'timeZone.mazatlan': return 'マサトラン';
			case 'timeZone.mountain_time_us_canada': return 'アメリカ・カナダ山岳部時間';
			case 'timeZone.central_america': return '中央アメリカ';
			case 'timeZone.central_time_us_canada': return 'アメリカ・カナダ中部時間';
			case 'timeZone.chihuahua': return 'チワワ';
			case 'timeZone.guadalajara': return 'グアダラハラ';
			case 'timeZone.mexico_city': return 'メキシコシティ';
			case 'timeZone.monterrey': return 'モンテレイ';
			case 'timeZone.saskatchewan': return 'サスカチュワン';
			case 'timeZone.bogota': return 'ボゴタ';
			case 'timeZone.eastern_time_us_canada': return 'アメリカ・カナダ東部時間';
			case 'timeZone.indiana_east': return 'インディアナ州東部';
			case 'timeZone.lima': return 'リマ';
			case 'timeZone.quito': return 'キト';
			case 'timeZone.atlantic_time_canada': return 'カナダ大西洋時間';
			case 'timeZone.caracas': return 'カラカス';
			case 'timeZone.georgetown': return 'ジョージタウン';
			case 'timeZone.la_paz': return 'ラパス';
			case 'timeZone.puerto_rico': return 'プエルトリコ';
			case 'timeZone.santiago': return 'サンチアゴ';
			case 'timeZone.newfoundland': return 'ニューファンドランド';
			case 'timeZone.brasilia': return 'ブラジリア';
			case 'timeZone.buenos_aires': return 'ブエノスアイレス';
			case 'timeZone.greenland': return 'グリーンランド';
			case 'timeZone.montevideo': return 'モンテビデオ';
			case 'timeZone.mid_atlantic': return '中大西洋';
			case 'timeZone.azores': return 'アゾレス';
			case 'timeZone.cape_verde_is': return 'カーボヴェルデ';
			case 'timeZone.casablanca': return 'カサブランカ';
			case 'timeZone.dublin': return 'ダブリン';
			case 'timeZone.edinburgh': return 'エディンバラ';
			case 'timeZone.lisbon': return 'リスボン';
			case 'timeZone.london': return 'ロンドン';
			case 'timeZone.monrovia': return 'モンロビア';
			case 'timeZone.utc': return '協定世界時';
			case 'timeZone.amsterdam': return 'アムステルダム';
			case 'timeZone.belgrade': return 'ベオグラード';
			case 'timeZone.berlin': return 'ベルリン';
			case 'timeZone.bern': return 'ベルン';
			case 'timeZone.bratislava': return 'ブラチスラヴァ';
			case 'timeZone.brussels': return 'ブリュッセル';
			case 'timeZone.budapest': return 'ブダペスト';
			case 'timeZone.copenhagen': return 'コペンハーゲン';
			case 'timeZone.ljubljana': return 'リュブリャナ';
			case 'timeZone.madrid': return 'マドリード';
			case 'timeZone.paris': return 'パリ';
			case 'timeZone.prague': return 'プラハ';
			case 'timeZone.rome': return 'ローマ';
			case 'timeZone.sarajevo': return 'サラエボ';
			case 'timeZone.skopje': return 'スコピエ';
			case 'timeZone.stockholm': return 'ストックホルム';
			case 'timeZone.vienna': return 'ビーン';
			case 'timeZone.warsaw': return 'ワルシャワ';
			case 'timeZone.west_central_africa': return '西中部アフリカ';
			case 'timeZone.zagreb': return 'ザグレブ';
			case 'timeZone.zurich': return 'チューリッヒ';
			case 'timeZone.athens': return 'アテネ';
			case 'timeZone.bucharest': return 'ブカレスト';
			case 'timeZone.cairo': return 'カイロ';
			case 'timeZone.harare': return 'ハラレ';
			case 'timeZone.helsinki': return 'ヘルシンキ';
			case 'timeZone.jerusalem': return 'エルサレム';
			case 'timeZone.kaliningrad': return 'カリーニングラード';
			case 'timeZone.kyiv': return 'キエフ';
			case 'timeZone.pretoria': return 'プレトリア';
			case 'timeZone.riga': return 'リガ';
			case 'timeZone.sofia': return 'ソフィア';
			case 'timeZone.tallinn': return 'タリン';
			case 'timeZone.vilnius': return 'ヴィリニュス';
			case 'timeZone.baghdad': return 'バグダッド';
			case 'timeZone.istanbul': return 'イスタンブール';
			case 'timeZone.kuwait': return 'クウェート';
			case 'timeZone.minsk': return 'ミンスク';
			case 'timeZone.moscow': return 'モスクワ';
			case 'timeZone.nairobi': return 'ナイロビ';
			case 'timeZone.riyadh': return 'リヤド';
			case 'timeZone.st_petersburg': return 'サンクトペテルブルク';
			case 'timeZone.volgograd': return 'ヴォルゴグラード';
			case 'timeZone.tehran': return 'テヘラン';
			case 'timeZone.abu_dhabi': return 'アブダビ';
			case 'timeZone.baku': return 'バクー';
			case 'timeZone.muscat': return 'マスカット';
			case 'timeZone.samara': return 'サマラ';
			case 'timeZone.tbilisi': return 'トビリシ';
			case 'timeZone.yerevan': return 'エレバン';
			case 'timeZone.kabul': return 'カブール';
			case 'timeZone.ekaterinburg': return 'エカテリンブルク';
			case 'timeZone.islamabad': return 'イスラマバード';
			case 'timeZone.karachi': return 'カラチ';
			case 'timeZone.tashkent': return 'タシュケント';
			case 'timeZone.chennai': return 'チェンナイ';
			case 'timeZone.kolkata': return 'コルカタ';
			case 'timeZone.mumbai': return 'ムンバイ';
			case 'timeZone.new_delhi': return 'ニューデリー';
			case 'timeZone.sri_jayawardenepura': return 'スリジャヤワルダネプラコッテ';
			case 'timeZone.kathmandu': return 'カトマンズ';
			case 'timeZone.almaty': return 'アルマトイ';
			case 'timeZone.astana': return 'アスタナ';
			case 'timeZone.dhaka': return 'ダッカ';
			case 'timeZone.urumqi': return 'ウルムチ';
			case 'timeZone.rangoon': return 'ラングーン';
			case 'timeZone.bangkok': return 'バンコク';
			case 'timeZone.hanoi': return 'ハノイ';
			case 'timeZone.jakarta': return 'ジャカルタ';
			case 'timeZone.krasnoyarsk': return 'クラスノヤルスク';
			case 'timeZone.novosibirsk': return 'ノヴォシビルスク';
			case 'timeZone.beijing': return '北京';
			case 'timeZone.chongqing': return '重慶';
			case 'timeZone.hong_kong': return '香港';
			case 'timeZone.irkutsk': return 'イルクーツク';
			case 'timeZone.kuala_lumpur': return 'クアラルンプール';
			case 'timeZone.perth': return 'パース';
			case 'timeZone.singapore': return 'シンガポール';
			case 'timeZone.taipei': return '台北';
			case 'timeZone.ulaanbaatar': return 'ウランバートル';
			case 'timeZone.osaka': return '大阪';
			case 'timeZone.sapporo': return '札幌';
			case 'timeZone.seoul': return 'ソウル';
			case 'timeZone.tokyo': return '東京';
			case 'timeZone.yakutsk': return 'ヤクーツク';
			case 'timeZone.adelaide': return 'アデレード';
			case 'timeZone.darwin': return 'ダーウィン';
			case 'timeZone.brisbane': return 'ブリスベン';
			case 'timeZone.canberra': return 'キャンベラ';
			case 'timeZone.guam': return 'グアム';
			case 'timeZone.hobart': return 'ホバート';
			case 'timeZone.melbourne': return 'メルボルン';
			case 'timeZone.port_moresby': return 'ポートモレスビー';
			case 'timeZone.sydney': return 'シドニー';
			case 'timeZone.vladivostok': return 'ウラジオストク';
			case 'timeZone.magadan': return 'マガダン';
			case 'timeZone.new_caledonia': return 'ニューカレドニア';
			case 'timeZone.solomon_is': return 'ソロモン諸島';
			case 'timeZone.srednekolymsk': return 'スレドネコリムスク';
			case 'timeZone.auckland': return 'オークランド';
			case 'timeZone.fiji': return 'フィジー';
			case 'timeZone.kamchatka': return 'カムチャツカ';
			case 'timeZone.marshall_is': return 'マーシャル諸島';
			case 'timeZone.wellington': return 'ウェリントン';
			case 'timeZone.chatham_is': return 'チャタム諸島';
			case 'timeZone.nuku_alofa': return 'ヌクアロファ';
			case 'timeZone.samoa': return 'サモア';
			case 'timeZone.tokelau_is': return 'トケラウ諸島';
			case 'answer.answers_count': return ({required Object count}) => '${count}問解答';
			case 'answer.limit_reached': return '制限に達しました';
			case 'answer.limit_reached_description': return ({required Object number}) => '無料ユーザーが解けるのは、１日に${number}問までです。プレミアム会員になって、無制限に問題を解きましょう！';
			case 'quizzes.quiz': return '問題';
			case 'quizzes.edit': return '編集する';
			case 'quizzes.answer': return '解答する';
			case 'quizzes.see_correct_answer': return '正解を見る';
			case 'quizzes.correct': return '正解した';
			case 'quizzes.wrong': return '間違えた';
			case 'quizzes.got_a_correct': return '正解した';
			case 'quizzes.made_a_mistake': return '間違えた';
			case 'quizzes.question': return '問題文';
			case 'quizzes.question_placeholder': return '【必須】問題文を入力してください。';
			case 'quizzes.correct_answer': return '正解';
			case 'quizzes.correct_answer_placeholder': return '【必須】正解を入力してください。';
			case 'quizzes.distractors': return '誤りの選択肢';
			case 'quizzes.distractors_placeholder': return '【空欄可】誤りの選択肢を設定できます。';
			case 'quizzes.explanation': return '解説';
			case 'quizzes.explanation_placeholder': return '【空欄可】解説を設定できます。';
			case 'quizzes.hint': return 'ヒント';
			case 'quizzes.hint_placeholder': return '【空欄可】ヒントを設定できます。';
			case 'quizzes.corrected_time_ago': return '%{time}前に正解';
			case 'quizzes.incorrect_time_ago': return '%{time}前に不正解';
			case 'quizzes.correct_answer_rate': return '正答率%{percent}%';
			case 'activities.activities': return '活動';
			case 'activities.cheer': return '応援する!';
			case 'activities.cheered': return '応援しました！';
			case 'answerHistories.answer_histories': return '解答履歴';
			case 'answerHistories.todays_mistakes': return '今日間違えた問題';
			case 'wordRequests.word_requests': return '辞書の編集履歴';
			case 'wordRequests.edit_histories': return '編集履歴';
			case 'wordRequests.pending_edits': return '審査中の編集';
			case 'wordRequests.rejected_edits': return '却下された編集';
			case 'wordRequests.edit_applied': return '編集が適応されました。';
			case 'wordRequests.addition_request_submitted': return '追加リクエストが申請されました。';
			case 'wordRequests.modification_request_submitted': return '修正リクエストが申請されました。';
			case 'wordRequests.elimination_request_submitted': return '削除リクエストが申請されました。';
			case 'wordRequests.already_submitted': return '編集リクエストをすでに申請済みです。';
			case 'wordRequests.addition': return '項目の追加';
			case 'wordRequests.modification': return '項目の修正';
			case 'wordRequests.elimination': return '項目の削除';
			case 'wordRequests.acceptance': return '採用済';
			case 'wordRequests.rejection': return '却下済';
			case 'wordRequests.pending': return '審査中';
			case 'wordRequests.accept': return '採用';
			case 'wordRequests.reject': return '却下';
			case 'wordRequests.editor_comment': return '編集者のコメント';
			case 'wordRequests.comments': return 'コメント';
			case 'wordRequests.cancel': return 'リクエストを取り下げる';
			case 'wordRequests.canceled': return 'リクエストを取り下げました。';
			case 'wordRequests.target': return '編集先';
			case 'wordRequests.target_already_deleted': return '編集先がすでに削除されています。';
			case 'wordRequests.target_not_found': return '編集先が見つかりませんでした。';
			case 'wordRequests.show_heading': return '編集内容';
			case 'wordRequests.accepted': return 'リクエストが採用されました。';
			case 'wordRequests.rejected': return 'リクエストが却下されました。';
			case 'wordRequests.edited_at': return ({required Object time}) => '${time}前に編集';
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
			case 'words.pos_tag_id': return '品詞';
			case 'words.meaning': return '意味';
			case 'words.ipa': return 'IPA（発音記号）';
			case 'words.search_sentence': return '例文を検索する';
			case 'words.search_sentence_placeholder': return 'キーワードを入力してください';
			case 'words.no_sentence': return '例文が設定されていません。';
			case 'words.set_sentence_with_ai': return 'AIで例文を設定する';
			case 'words.generate_meaning_with_ai': return 'AIで意味を生成する';
			case 'words.meaning_generation_keyword_placeholder': return '意味を生成するキーワード';
			case 'words.success_to_generate_meanings': return '意味を生成しました。';
			case 'words.failed_to_generate_meanings': return '意味の生成に失敗しました。';
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
			case 'purchase.premium_plan': return 'プレミアムプラン';
			case 'purchase.premium_plan_description': return 'DiQtのすべての機能が使い放題になるプランです。';
			case 'purchase.trial_period_description': return '今なら２週間の無料体験期間つき！';
			case 'purchase.free_plan': return '無料プラン';
			case 'purchase.yen': return '円';
			case 'purchase.answers_limit': return '1日の解答数';
			case 'purchase.unlimited': return '無制限';
			case 'purchase.translations_limit': return '1日の翻訳できる回数';
			case 'purchase.ad_free': return '広告非表示';
			case 'purchase.weakness': return '弱点問題';
			case 'purchase.note': return 'ノート機能';
			case 'purchase.answer_analysis': return '解答分析';
			case 'purchase.answer_history': return '解答履歴';
			case 'purchase.questions_you_got_wrong': return '今日間違えた問題';
			case 'purchase.deletion_of_all_reviews': return '復習一括削除';
			case 'purchase.monthly_plan': return '月額プラン';
			case 'purchase.month': return '月';
			case 'purchase.annual_plan': return '年額プラン';
			case 'purchase.year': return '年';
			case 'purchase.two_months_free': return '２ヶ月分お得！';
			case 'purchase.start_free_trial': return '無料で試す';
			case 'purchase.get_started': return '登録する';
			case 'purchase.registered': return '登録済み';
			case 'purchase.bank_transfer': return '銀行口座のお振込をご希望の方はこちらから';
			case 'purchase.stripe_explanation': return '決済には、Stripeを利用しております。Stripeは世界中で幅広く利用されている安全な決済システムであり、当社のサーバーでお客様のカード情報を保存することはありません。';
			case 'purchase.auto_renew_explanation': return 'プランは自動更新です。有効期間が終了する２４時間前までにお支払い設定よりご解約いただければ、自動更新はされません。';
			case 'purchase.this_is_premium_plan_feature': return 'プレミアム会員用の機能です';
			case 'purchase.all_features_will_be_available': return 'すべての機能が利用できるようになります。';
			case 'purchase.notice': return '有料化の7日前にお知らせします。';
			case 'purchase.cancel_at_any_time': return 'いつでもキャンセルできます。';
			case 'purchase.monthly_plan_price': return '500円／月';
			case 'purchase.annual_plan_price': return '5,000円／年';
			case 'purchase.purchase_succeded': return 'プレミアム会員になりました！';
			case 'purchase.view_premium_plan_benefits': return 'プレミアムプランの特典を見る';
			case 'purchase.view_premium_plan': return 'プレミアムプランを見る';
			case 'purchase.premium_plan_benefits': return 'プレミアムプランの特典';
			case 'purchase.unlimited_answers': return '無制限の解答';
			case 'purchase.unlimited_answers_description': return ({required Object number}) => '無料ユーザーが1日に解答できる問題の数は${number}問ですが、プレミアム会員なら、1日に何問でも解答できるようになります。';
			case 'purchase.unlimited_translations': return '無制限の翻訳';
			case 'purchase.unlimited_translations_description': return ({required Object number}) => '無料ユーザーが1日に翻訳できる回数は${number}回ですが、プレミアム会員になら、1日に何回でも翻訳できるようになります。';
			case 'purchase.weakness_description': return 'プレミアム会員なら、正答率が低い問題を重点的に学習できるようになります。';
			case 'purchase.note_description': return 'プレミアム会員なら、解いた問題にメモを残すことができるようになります。';
			case 'purchase.answer_analysis_description': return 'プレミアム会員なら、正答率や間違えた回数で解いた問題を分析できるようになります。';
			case 'purchase.answer_history_description': return 'プレミアム会員なら、解答した問題の履歴を閲覧できるようになります。';
			case 'purchase.questions_you_got_wrong_description': return 'プレミアム会員なら、その日に間違えた問題を確認できるようになります。';
			case 'purchase.deletion_of_all_reviews_description': return 'プレミアム会員なら、今までに設定した復習をすべて取り消すことができるようになります。';
			case 'purchase.ad_free_description': return 'プレミアム会員なら、アプリ内のすべての広告が表示されなくなります。';
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
			case 'home.inquiry': return 'お問い合わせ';
			case 'home.maintenance_mode': return 'メンテナンス中';
			case 'home.maintenance_description': return '大変申し訳ございません。ただ今DiQtはメンテナンスを行なっております。しばらくしてから、再びアクセスいただければ幸いです。';
			case 'home.maintenance_latest_information': return '最新情報はこちら';
			case 'drillLaps.resume': return '続きから';
			case 'drillLaps.view_more': return 'もっと見る';
			default: return null;
		}
	}
}
