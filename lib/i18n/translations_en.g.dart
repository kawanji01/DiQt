///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final TranslationsAchievementsEn achievements = TranslationsAchievementsEn._(_root);
	late final TranslationsActivitiesEn activities = TranslationsActivitiesEn._(_root);
	late final TranslationsAnswerEn answer = TranslationsAnswerEn._(_root);
	late final TranslationsAnswerAnalysesEn answerAnalyses = TranslationsAnswerAnalysesEn._(_root);
	late final TranslationsAnswerHistoriesEn answerHistories = TranslationsAnswerHistoriesEn._(_root);
	late final TranslationsAnswerSettingsEn answerSettings = TranslationsAnswerSettingsEn._(_root);
	late final TranslationsCalendarsEn calendars = TranslationsCalendarsEn._(_root);
	late final TranslationsCancellationEn cancellation = TranslationsCancellationEn._(_root);
	late final TranslationsChaptersEn chapters = TranslationsChaptersEn._(_root);
	late final TranslationsDictionariesEn dictionaries = TranslationsDictionariesEn._(_root);
	late final TranslationsDictionaryMapsEn dictionaryMaps = TranslationsDictionaryMapsEn._(_root);
	late final TranslationsDrillLapsEn drillLaps = TranslationsDrillLapsEn._(_root);
	late final TranslationsDrillsEn drills = TranslationsDrillsEn._(_root);
	late final TranslationsErrorsEn errors = TranslationsErrorsEn._(_root);
	late final TranslationsExperiencePointsEn experiencePoints = TranslationsExperiencePointsEn._(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	late final TranslationsInquiriesEn inquiries = TranslationsInquiriesEn._(_root);
	late final TranslationsLangEn lang = TranslationsLangEn._(_root);
	late final TranslationsLayoutsEn layouts = TranslationsLayoutsEn._(_root);
	late final TranslationsNotesEn notes = TranslationsNotesEn._(_root);
	late final TranslationsNoticesEn notices = TranslationsNoticesEn._(_root);
	late final TranslationsPurchaseEn purchase = TranslationsPurchaseEn._(_root);
	late final TranslationsQuizRequestsEn quizRequests = TranslationsQuizRequestsEn._(_root);
	late final TranslationsQuizzesEn quizzes = TranslationsQuizzesEn._(_root);
	late final TranslationsRankingEn ranking = TranslationsRankingEn._(_root);
	late final TranslationsReviewsEn reviews = TranslationsReviewsEn._(_root);
	late final TranslationsSchoolsEn schools = TranslationsSchoolsEn._(_root);
	late final TranslationsSensesEn senses = TranslationsSensesEn._(_root);
	late final TranslationsSentenceRequestsEn sentenceRequests = TranslationsSentenceRequestsEn._(_root);
	late final TranslationsSentencesEn sentences = TranslationsSentencesEn._(_root);
	late final TranslationsSessionsEn sessions = TranslationsSessionsEn._(_root);
	late final TranslationsSharedEn shared = TranslationsSharedEn._(_root);
	late final TranslationsTimeZoneEn timeZone = TranslationsTimeZoneEn._(_root);
	late final TranslationsUsersEn users = TranslationsUsersEn._(_root);
	late final TranslationsWeaknessesEn weaknesses = TranslationsWeaknessesEn._(_root);
	late final TranslationsWordRequestCommentsEn wordRequestComments = TranslationsWordRequestCommentsEn._(_root);
	late final TranslationsWordRequestsEn wordRequests = TranslationsWordRequestsEn._(_root);
	late final TranslationsWordsEn words = TranslationsWordsEn._(_root);
}

// Path: achievements
class TranslationsAchievementsEn {
	TranslationsAchievementsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get view_got_medals => 'View Got Medals';
	String get getting_medal => 'Medal acquisition!!';
	String getting_medal_for({required Object name}) => '${name} Medal acquisition!!';
	String get got_medals => 'Got Medals';
	String get receive_reward => 'Receive Reward';
	String praise_text({required Object name}) => 'Congratulations!! You have earned the ${name} medal! Please press the button below to receive the medal acquisition reward!!';
	String get tutorial_medal => 'Tutorial Medal';
	String get tutorial_medal_introduction => 'This is a medal that can be earned by achieving the basic operation of Dict.';
	String get drill_clear_name => 'Drill Clear';
	String get drill_clear_introduction => 'This is a medal that can be earned by going around the drill once.';
	String get goal_achievement_name => 'Goal Achievement';
	String get goal_achievement_introduction => 'This is a medal that can be earned by achieving your daily goal.';
	String get review_completion_name => 'Review Completion';
	String get review_completion_introduction => 'This is a medal that can be earned by completing a review.';
	String get continuous_answer_name => 'Continuous Answer';
	String get continuous_answer_introduction => 'This is a medal that can be earned by answering questions for two consecutive days.';
	String get continuous_goal_achievement_name => 'Continuous Goal Achievement';
	String get continuous_goal_achievement_introduction => 'This is a medal that can be earned by achieving your goal for two consecutive days.';
	String get continuous_review_completion_name => 'Continuous Review Completion';
	String get continuous_review_completion_introduction => 'This is a medal that can be earned by completing a review for two consecutive days.';
	String get following_name => 'Following';
	String get following_introduction => 'This is a medal that can be earned by following other users.';
	String get cheering_name => 'Cheering';
	String get cheering_introduction => 'This is a medal that can be earned by cheering for other users.';
	String get all_week_continuation_name => 'All Week Continuation';
	String get all_week_continuation_introduction => 'This is a medal that can be earned by answering questions for one week.';
	String get answers_medal => 'Answers Medal';
	String get answers_medal_introduction => 'This is a medal that can be earned according to the number of answers.';
	String get answers_100_name => '100 Answers';
	String get answers_100_introduction => 'This is a medal that can be earned by answering 100 questions.';
	String get answers_500_name => '500 Answers';
	String get answers_500_introduction => 'This is a medal that can be earned by answering 500 questions.';
	String get answers_1000_name => '1000 Answers';
	String get answers_1000_introduction => 'This is a medal that can be earned by answering 1000 questions.';
	String get answers_2000_name => '2000 Answers';
	String get answers_2000_introduction => 'This is a medal that can be earned by answering 2000 questions.';
	String get answers_5000_name => '5000 Answers';
	String get answers_5000_introduction => 'This is a medal that can be earned by answering 5000 questions.';
	String get answers_10000_name => '10000 Answers';
	String get answers_10000_introduction => 'This is a medal that can be earned by answering 10000 questions.';
	String get answers_20000_name => '20000 Answers';
	String get answers_20000_introduction => 'This is a medal that can be earned by answering 20000 questions.';
	String get answers_30000_name => '30000 Answers';
	String get answers_30000_introduction => 'This is a medal that can be earned by answering 30000 questions.';
	String get answers_40000_name => '40000 Answers';
	String get answers_40000_introduction => 'This is a medal that can be earned by answering 40000 questions.';
	String get answers_50000_name => '50000 Answers';
	String get answers_50000_introduction => 'This is a medal that can be earned by answering 50000 questions.';
	String get answers_60000_name => '60000 Answers';
	String get answers_60000_introduction => 'This is a medal that can be earned by answering 60000 questions.';
	String get answers_70000_name => '70000 Answers';
	String get answers_70000_introduction => 'This is a medal that can be earned by answering 70000 questions.';
	String get answers_80000_name => '80000 Answers';
	String get answers_80000_introduction => 'This is a medal that can be earned by answering 80000 questions.';
	String get answers_90000_name => '90000 Answers';
	String get answers_90000_introduction => 'This is a medal that can be earned by answering 90000 questions.';
	String get answers_100000_name => '100000 Answers';
	String get answers_100000_introduction => 'This is a medal that can be earned by answering 100000 questions.';
	String get answer_days_medal => 'Answer Days Medal';
	String get answer_days_medal_introduction => 'This is a medal that can be earned according to the number of answer days.';
	String get answer_days_2_name => '2 Days Answer';
	String get answer_days_2_introduction => 'This is a medal that can be earned by answering questions for two consecutive days.';
	String get answer_days_7_name => '7 Days Answer';
	String get answer_days_7_introduction => 'This is a medal that can be earned by answering questions for seven consecutive days.';
	String get answer_days_14_name => '14 Days Answer';
	String get answer_days_14_introduction => 'This is a medal that can be earned by answering questions for fourteen consecutive days.';
	String get answer_days_30_name => '30 Days Answer';
	String get answer_days_30_introduction => 'This is a medal that can be earned by answering questions for thirty consecutive days.';
	String get answer_days_60_name => '60 Days Answer';
	String get answer_days_60_introduction => 'This is a medal that can be earned by answering questions for sixty consecutive days.';
	String get answer_days_100_name => '100 Days Answer';
	String get answer_days_100_introduction => 'This is a medal that can be earned by answering questions for one hundred consecutive days.';
	String get answer_days_200_name => '200 Days Answer';
	String get answer_days_200_introduction => 'This is a medal that can be earned by answering questions for two hundred consecutive days.';
	String get answer_days_300_name => '300 Days Answer';
	String get answer_days_300_introduction => 'This is a medal that can be earned by answering questions for three hundred consecutive days.';
	String get answer_days_365_name => '365 Days Answer';
	String get answer_days_365_introduction => 'This is a medal that can be earned by answering questions for three hundred and sixty-five consecutive days.';
	String get master_medal => 'Master Medal';
	String get master_medal_introduction => 'This is a medal that can be earned by achieving the highest rank.';
	String get lv_100_name => 'Level 100';
	String get lv_100_introduction => 'This is a medal that can be earned by reaching level 100.';
	String get rank_1_name => 'Rank 1';
	String get rank_1_introduction => 'This is a medal that can be earned by reaching rank 1.';
	String get all_year_continuation_name => 'All Year Continuation';
	String get all_year_continuation_introduction => 'This is a medal that can be earned by answering questions for one year.';
	String get tutorial_completion_name => 'Tutorial Completion';
	String get tutorial_completion_introduction => 'This is a medal that can be earned by completing the tutorial.';
	String get answers_completion_name => 'Answers Completion';
	String get answers_completion_introduction => 'This is a medal that can be earned by answering questions for 100 consecutive days.';
	String get answer_days_completion_name => 'Answer Days Completion';
	String get answer_days_completion_introduction => 'This is a medal that can be earned by answering questions for 365 consecutive days.';
}

// Path: activities
class TranslationsActivitiesEn {
	TranslationsActivitiesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get activities => 'Activities';
	String get display => 'Display';
	String get all => 'All users';
	String get following => 'Following users';
	String get myself => 'Myself';
	String get cheer => 'Cheer';
	String get cheered => 'Cheered';
	String answer_days({required Object name, required Object number}) => '${name} answered ${number} days!';
	String continuation_count({required Object number}) => '${number} days in a row!';
	String all_week_continuation_count({required Object number}) => '${number} weeks in a row!';
	String all_month_continuation_count({required Object number}) => '${number} months in a row!';
	String all_year_continuation_count({required Object number}) => '${number} years in a row!';
	String goal_achievement({required Object name, required Object number}) => '${name} achieved the daily goal (${number} answers)!';
	String strict_goal_achievement({required Object name, required Object number}) => '${name} achieved the daily goal in strict mode (${number} correct answers)!';
	String continuous_goal_achievement({required Object number}) => 'The goal was achieved for ${number} consecutive days!';
	String review_completion({required Object name}) => '${name} completed the review!';
	String strict_review_completion({required Object name}) => '${name} completed the review in strict mode!';
	String continuous_review_completion({required Object number}) => 'The review was completed for ${number} consecutive days!';
	String drill_clear({required Object name, required Object drill_title, required Object number}) => '${name} cleared "${drill_title}" ${number} times!';
	String strict_drill_clear({required Object name, required Object drill_title, required Object number}) => '${name} cleared "${drill_title}" ${number} times in strict mode!';
	String level_up({required Object name, required Object number}) => '${name} became Lv.${number}!';
	String achievement({required Object name, required Object achievement_name}) => '${name} earned the ${achievement_name} medal!';
}

// Path: answer
class TranslationsAnswerEn {
	TranslationsAnswerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get limit_reached => 'Limit Reached';
	String limit_reached_description({required Object number}) => 'Free users can answer up to ${number} questions per day. Become a premium member and answer unlimited questions!';
	String daily_bonus({required Object count}) => '${count} days of answers';
	String continuous_answers({required Object count}) => '${count} days of continuous answers';
	String continuous_goal_achievement({required Object count}) => '${count} days of continuous goal achievement';
	String continuous_review_completion({required Object count}) => '${count} days of continuous review completion';
	String get goal_achievement => 'Goal achievement';
	String get review_completion => 'Review completion';
	String get strict_solving_mode => 'Strict answer mode';
	String get strict_reviewing_mode => 'Strict review mode';
	String weekly_bonus({required Object count}) => '${count} weeks of continuous answers';
	String monthly_bonus({required Object count}) => '${count} months of continuous answers';
	String yearly_bonus({required Object count}) => '${count} years of continuous answers';
	String get answers => 'answers';
	String answers_count({required Object count}) => '${count} answers';
	String same_mistake_message({required Object count}) => 'You made this mistake ${count} times.';
	String get drill_clear => 'Drill Clear';
	String drill_clear_description({required Object laps_count}) => 'Congratulations! You have answered all the questions in the drill! (${laps_count})';
	String strict_drill_clear_description({required Object laps_count}) => 'Congratulations! You have answered all the questions in the drill correctly! (${laps_count})';
	String get weakness_clear => 'Weakness Clear';
	String get weakness_clear_description => 'Congratulations! You have answered all the questions in the weakness correctly!';
	String get requesting_app_review => 'Thank you very much for using DiQt so much! Did you like DiQt?';
	String review_step_up({required Object interval}) => 'Set review for ${interval} as step-up';
	String get review_released => 'Review released';
	String get answers_on_normal_mode => 'Answers: ';
	String get answers_on_strict_solving_mode => 'Correct Answers: ';
	String get view_explanation => 'View Explanation';
	String get level_up => 'Level Up';
	String level({required Object level}) => 'Lv.${level}';
}

// Path: answerAnalyses
class TranslationsAnswerAnalysesEn {
	TranslationsAnswerAnalysesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get answer_analysis => 'Answer Analysis';
	String get answer_analyses => 'Answer Analyses';
	String get answer_histories => 'Answer Histories';
	String get premium_recommendation => 'To access these features, you need to register for a premium plan.';
	String get order => 'Display';
	String get correct_answer_rate_asc => 'Correct Rate, Low to High';
	String get correct_answer_rate_desc => 'Correct Rate, High to Low';
	String get incorrect_answer_histories_count_desc => 'Mistakes, Most to Least';
	String get incorrect_answer_histories_count_asc => 'Mistakes, Least to Most';
	String get last_answered_at_desc => 'Answered History, New to Old';
	String get last_answered_at_asc => 'Answered History, Old to New';
	String get analyze => 'Analyze';
	String get correct => 'Correct';
	String get incorrect => 'Incorrect';
	String last_record({required Object result, required Object time_ago}) => '${result} - ${time_ago}';
	String correct_at({required Object time_ago}) => 'Correct ${time_ago}';
	String incorrect_at({required Object time_ago}) => 'Incorrect ${time_ago}';
	String get correct_answer_rate => 'Correct Rate';
	String get not_yet_answered => 'You have not answered yet.';
	String answers_count({required Object count}) => '${count} attempts';
	String correct_answers_count({required Object count}) => '${count} Correct';
	String incorrect_answers_count({required Object count}) => '${count} Incorrect';
	String get last_answer => 'Last Answer';
	String get status => 'Status';
}

// Path: answerHistories
class TranslationsAnswerHistoriesEn {
	TranslationsAnswerHistoriesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get answer_histories => 'Answer Histories';
	String get todays_mistakes => 'Today\'s Mistakes';
}

// Path: answerSettings
class TranslationsAnswerSettingsEn {
	TranslationsAnswerSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

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
	String get adjust_difficulty => 'How to increase the difficulty of questions';
	String get adjust_review_difficulty => 'How to increase the difficulty of reviews';
}

// Path: calendars
class TranslationsCalendarsEn {
	TranslationsCalendarsEn._(this._root);

	final Translations _root; // ignore: unused_field

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

// Path: cancellation
class TranslationsCancellationEn {
	TranslationsCancellationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get cancel_subscription => 'Cancel Subscription';
	String get please_login => 'Please sign in';
	String get communication_error => 'Network error occurred';
	String get confirm_cancellation => 'Cancel Your Subscription';
	String user_name_suffix({required Object user}) => 'Hi ${user}!';
	String get premium_thanks => 'Thanks for being a DiQt Premium member.';
	String get apology_message => 'We\'re sorry we didn\'t meet your expectations.';
	String feedback_request({required Object user}) => '${user}, would you mind sharing what led to your decision to cancel? Your feedback will help us improve DiQt for everyone.';
	String get apology_for_trouble => 'Sorry for the hassle.';
	String get honest_feedback_request => 'We\'d love to hear your thoughts.';
	String get cancellation_reason_title => 'Why are you leaving?';
	String get cancellation_reason_request => 'Help us understand why you\'re canceling';
	String get cancellation_reason_required => 'Please provide a reason for cancellation';
}

// Path: chapters
class TranslationsChaptersEn {
	TranslationsChaptersEn._(this._root);

	final Translations _root; // ignore: unused_field

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
	String get external_reference_link => 'External Link';
}

// Path: dictionaries
class TranslationsDictionariesEn {
	TranslationsDictionariesEn._(this._root);

	final Translations _root; // ignore: unused_field

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
	String get keyword => 'Keyword';
	String get word_segmentation => 'Word Segmentation';
	String get search_results => 'Search results';
	String search_results_of({required Object query}) => 'Search results of "${query}"';
	String entry_not_found({required Object query}) => '"${query}" is not found.';
	String get keyword_not_found => 'The keyword is not registered in the dictionary.';
	String get search_by_web => 'Search by Web';
	String search_by_another({required Object name}) => 'Search by ${name}';
	String get edit_by_web => 'Edit by Web';
	String add_keyword_to_dictionary({required Object keyword}) => 'Add "${keyword}" to the dictionary';
	String get add_by_web => 'Add by Web';
	String get register_keyword => 'Register keyword to the dictionary';
	String get open_by_web => 'Open by Web';
	String get no_permission => 'You don\'t have permission.';
	String get no_addition_permission => 'You don\'t have create permission.';
	String get no_modification_permission => 'You don\'t have update permission.';
	String get no_elimination_permission => 'You don\'t have delete permission.';
}

// Path: dictionaryMaps
class TranslationsDictionaryMapsEn {
	TranslationsDictionaryMapsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get please_select => 'Please select a dictionary';
	String get not_selected => 'Dictionary not selected';
	String enter({required Object language}) => 'Please enter ${language}';
	String get set_dictionaries => 'Set dictionaries';
	String get add_dictionaries => 'Add dictionaries';
	String get remove_dictionaries => 'Remove dictionaries';
	String get select_dictionaries_to_use => 'Select dictionaries to add';
	String get add => 'Add';
	String get select_dictionaries_to_remove => 'Select dictionaries to remove';
	String get remove => 'Remove';
	String get set => 'Set';
	String get update_success => 'My Dictionaries Set';
	String get update_failed => 'Setting My Dictionaries Failed';
	String get search_menu => 'Search Menu';
	String get search_by_speech => 'Search by speech';
	String get start_speech_recognition => 'Start';
	String get stop_speech_recognition => 'OK';
	String get search_by_image => 'Search by image';
	String get image_for_ocr => 'An image to load text';
	String get upload => 'Upload';
}

// Path: drillLaps
class TranslationsDrillLapsEn {
	TranslationsDrillLapsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get resume => 'Resume';
	String get view_more => 'View More';
}

// Path: drills
class TranslationsDrillsEn {
	TranslationsDrillsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get drills => 'Drills';
	String get private_drill => 'This drill is private';
	String answers({required Object number}) => '${number} answers';
	String laps_count({required Object number}) => 'Laps: ${number} ';
	String clears_count({required Object number}) => 'Clears: ${number}';
	String get unsolved => 'Unsolved';
	String get solved => 'Solved';
	String get all => 'All';
	String get search => 'Search Quizzes';
	String get pending_requests => 'Pending Requests';
	String get accepted_requests => 'Accepted Requests';
	String get rejected_requests => 'Rejected Requests';
	String get create_drill => 'Create drill';
	String get create_drill_with_csv => 'Create drill with CSV';
	String get edit_drill => 'Edit drill';
	String get edit_drill_with_csv => 'Edit drill with csv';
	String get csv_blank => 'Please attach a CSV file.';
	String get please_wait => 'Creating drill. Please wait for 10 seconds.';
	String get title_placeholder => 'Please enter the title of the drill';
	String get introduction => 'Introduction';
	String get over_item_limit => 'If you have more than 100 questions, please edit the questions from here';
	String get order => 'Order';
	String get created_at_asc => 'From the beginning';
	String get created_at_desc => 'From the end';
	String get random_random => 'Random';
	String get edit_setting => 'Edit Setting';
	String get owner => 'Owner';
	String get following_users => 'Following Users';
	String get followed_users => 'Followed Users';
	String get users => 'Users';
	String get settings => 'Settings';
	String get edit_tags => 'Edit Tags';
	String get open => 'Open';
	String get new_lap => 'New Lap';
	String get new_lap_description => 'Return all questions unanswered. Are you sure?';
	String get new_lap_started => 'All questions were returned unanswered and a new round started.';
	String get require_login => 'Please log in to solve problems.';
}

// Path: errors
class TranslationsErrorsEn {
	TranslationsErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

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

// Path: experiencePoints
class TranslationsExperiencePointsEn {
	TranslationsExperiencePointsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String to_the_next_level({required Object points}) => '${points} EXP to the next level.';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get welcome => 'Welcome to DiQt!';
	String get welcome_description_1 => 'DiQt is a dictionary app to help you never forget vocabulary.';
	String get welcome_description_2 => 'Easy to use. Look up the word in the dictionary,';
	String get welcome_description_3 => 'set a review for the word you want to memorize,';
	String get welcome_description_4 => 'and you can review it automatically until you learn it.';
	String get help_page => 'Help Page';
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

// Path: inquiries
class TranslationsInquiriesEn {
	TranslationsInquiriesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get inquiry => 'Inquiry';
	String get inquireis => 'Inquiries';
	String get content => 'Inquiry content';
	String get contact_form => 'Contact form';
	String get contact_form_placeholder => 'If you have any questions or concerns about DiQt, please feel free to contact us. We may reply to you by email at a later date if necessary.';
	String contact_description({required Object name}) => 'Please feel free to contact ${name} from the following.';
	String get inquiry_sent => 'Your inquiry has been sent. We may reply to you by email at a later date if necessary.';
	String get sending_inquiry_failed => 'Failed to send inquiry.';
}

// Path: lang
class TranslationsLangEn {
	TranslationsLangEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get google_translation => 'Google Translation';
	String get deepl_translation => 'DeepL Translation';
	String get translating => 'Translating...';
	String get done => 'Done';
	String get translation_failed => 'Translation Failed';
	String translation_restricted({required Object number}) => 'Free users are limited to ${number} translations per day.';
	String ai_searches_restricted({required Object number}) => 'Free users are limited to ${number} AI searches per day.';
	String deepl_not_supported({required Object language}) => '${language} is not supported by DeepL.';
	String google_not_supported({required Object language}) => '${language} is not supported by Google.';
	String get need_to_login => 'You need to log in to use the translation.';
	String get ask_ai => 'Ask AI';
	String get explain_meaning => 'What does it mean?';
	String get explain_usage => 'Please explain the usage.';
	String get explain_example => 'Please explain the example.';
	String get explain_synonym => 'Please explain the synonym.';
	String get explain_antonym => 'Please explain the antonym.';
	String get explain_conjugation => 'Please explain the conjugation.';
	String get explain_etymology => 'Please explain the etymology.';
	String get explain_grammar => 'Please explain the grammar and syntax in the sentence.';
	String get proofread_sentence => 'Please proofread the sentence';
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
	String get zh_Hans => 'Chinese (Simplified)';
	String get zh => 'Chinese';
	String get zh_TW => 'Chinese (Traditional)';
	String get zh_Hant => 'Chinese (Traditional)';
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
	String get nb => 'Norwegian (Bokmål)';
	String get no => 'Norwegian';
	String get ny => 'Nyanja (Chichewa)';
	String get or => 'Odia (Oriya)';
	String get ps => 'Pashto';
	String get fa => 'Persian';
	String get pl => 'Polish';
	String get prs => 'Dari';
	String get pt => 'Portuguese (Portugal, Brazil)';
	String get pa => 'Punjabi';
	String get ro => 'Romanian';
	String get ru => 'Russian';
	String get sm => 'Samoan';
	String get gd => 'Scots Gaelic';
	String get sr => 'Serbian';
	String get sr_Cryl => 'Serbian (Cyrillic)';
	String get sr_Latn => 'Serbian (Latin)';
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

// Path: layouts
class TranslationsLayoutsEn {
	TranslationsLayoutsEn._(this._root);

	final Translations _root; // ignore: unused_field

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
	String get other_apps => 'How to make DiQt more useful!';
	String get other_apps_description => 'DiQt offers not only an application, but also a browser extension and a website. By using these together, you can learn vocabulary more conveniently and efficiently.';
	String get chrome_extension => 'Google Chrome Extension';
	String get chrome_extension_description => 'If you install the Google Chrome extension, you can set a review for a word just by clicking on it on a web page.';
	String get free => 'Free';
	String get app_store_url => 'https://apps.apple.com/us/app/diqt/id1594559036?uo=4';
	String get play_store_url => 'https://play.google.com/store/apps/details?id=com.booqs.booqs_mobile&hl=en';
	String get chrome_web_store_url => 'https://chrome.google.com/webstore/detail/booqs-dictionary/khgjdchimekphdebkmcknjkphkbpbpkj?hl=en&authuser=0';
}

// Path: notes
class TranslationsNotesEn {
	TranslationsNotesEn._(this._root);

	final Translations _root; // ignore: unused_field

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
	String timestamp_info({required Object updatedAtTimeAgo, required Object createdAtTimeAgo}) => 'Updated: ${updatedAtTimeAgo} / Created: ${createdAtTimeAgo}';
}

// Path: notices
class TranslationsNoticesEn {
	TranslationsNoticesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get notifications => 'Notifications';
	String cheered_message({required Object name}) => '${name} has cheered you!';
	String followed_message({required Object name}) => '${name} has followed you!';
	String get word_request_accepted_message => 'Your dictionary edit has been adopted!';
	String get word_request_commented_message => 'Your dictionary edit has been commented!';
	String word_request_upvoted_message({required Object name}) => '${name} has upvoted your dictionary edit!';
	String get sentence_request_accepted_message => 'Your example sentence edit has been adopted!';
	String get sentence_request_commented_message => 'Your example sentence edit has been commented!';
	String sentence_request_upvoted_message({required Object name}) => '${name} has upvoted your example sentence edit!';
	String get quiz_request_accepted_message => 'Your quiz edit has been adopted!';
	String get quiz_request_commented_message => 'Your quiz edit has been commented!';
	String quiz_request_upvoted_message({required Object name}) => '${name} has upvoted your quiz edit!';
	String get reply => 'Reply';
	String achievement_acquired_message({required Object name}) => 'You have acquired "${name} medal"!';
	String get monthly_date_format => 'MMM yyyy';
	String get monthly_report => '[Monthly Report]';
	String get monthly_ranking => 'Monthly Ranking';
	String get weekly_first_date_format => 'MMM dd, yyyy';
	String get weekly_last_date_format => 'MMM dd';
	String get weekly_report => '[Weekly Report]';
	String get weekly_ranking => 'Weekly Ranking';
	String ranking_position({required Object rank}) => '#${rank}';
	String get answers_count => 'Total Answers';
	String answer_times({required Object count}) => '${count} times';
}

// Path: purchase
class TranslationsPurchaseEn {
	TranslationsPurchaseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get premium_plan => 'Premium Plan';
	String get premium_plan_description => 'This plan allows unlimited use of all DiQt features.';
	String get trial_period_description => 'Start with a 7-day free trial.';
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
	String get unlimited_ai_searches => 'Unlimited AI Features';
	String unlimited_ai_searches_description({required Object number}) => 'Free users are limited to ${number} AI queries per day, but with Premium membership, you can use AI features unlimited times.';
	String get unlimited_translations => 'Unlimited Translations';
	String unlimited_translations_description({required Object number}) => 'Free users can only translate ${number} times a day, but premium members can translate as many times a day as they like.';
	String get weakness_description => 'Premium members can focus on questions with low percentage of correct answers.';
	String get note_description => 'Premium members will be able to leave notes on answered questions.';
	String get answer_analysis_description => 'Premium members can analyze the questions they have answered by the percentage of correct answers and the number of mistakes.';
	String get answer_history_description => 'If you are a premium member, you can view the history of questions you have answered.';
	String get questions_you_got_wrong_description => 'If you are a premium member, you can review the questions you got wrong that day.';
	String get deletion_of_all_reviews_description => 'If you are a premium member, you can cancel all the reviews you have set up.';
	String get ad_free_description => 'If you are a premium member, you will no longer see all adverts in the app.';
	String get restore => 'Click here if you have previously purchased.';
	String get restore_success => 'Your purchase has been restored.';
	String get restore_error => 'Your purchase could not be restored.';
	String get footer_description => '・The premium subscription period is automatically renewed every month from the start date. \n ・The first payment starts at the end of the two-week free trial period. \n ・Unless you cancel more than 24 hours before the end of the premium subscription period, the subscription period will be automatically renewed. \n ・Please check the following before registering. \n';
	String get monthly_premium_plan => 'Monthly Premium Plan';
	String get annual_premium_plan => 'Annual Premium Plan';
	String get price => 'Price';
	String no_label({required Object label}) => '${label}: None';
	String get auto_renewal => 'Auto-Renewal';
	String get trial_period => 'Free Trial Period';
	String get subscription_store => 'Purchase Platform';
	String cancellation_date({required Object date}) => 'Will be cancelled on ${date}';
	String get subscription_cancelled => 'Cancelled';
	String get renewal_date => 'Renewal Date';
	String get expiry_date => 'Expiration Date';
	String get no_contract => 'You don\'t have a subscription plan';
	String get subscribed_via_web => 'Subscribed via web';
}

// Path: quizRequests
class TranslationsQuizRequestsEn {
	TranslationsQuizRequestsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get quiz_requests => 'Edit Histories of quizzes';
	String get edit_histories => 'Edit Histories';
	String get pending_edits => 'Pending Edits';
	String get edit_applied => 'Your edit applied.';
	String get addition_request_submitted => 'Your addition request submitted.';
	String get modification_request_submitted => 'Your modification request submitted.';
	String get elimination_request_submitted => 'Your elimination request submitted.';
	String get addition => 'Addition of quiz';
	String get modification => 'Modification of quiz';
	String get elimination => 'Deletion of quiz';
	String get acceptance => 'Adopted';
	String get rejection => 'Rejected';
	String get pending => 'Pending';
}

// Path: quizzes
class TranslationsQuizzesEn {
	TranslationsQuizzesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get quiz => 'Quiz';
	String get quizzes => 'Quizzes';
	String get add => 'Add Quiz';
	String get edit => 'Edit Quiz';
	String get answer => 'Answer';
	String get see_correct_answer => 'See correct answer';
	String get correct => 'Correct';
	String get wrong => 'Wrong';
	String get got_a_correct => 'Got a correct';
	String get made_a_mistake => 'Made a mistake';
	String get question => 'Question';
	String get question_placeholder => '【Required】Please input a question.';
	String get lang_number_of_question => 'Language of question';
	String get reading_out_question => 'Reading out the question';
	String get question_hidden => 'Hide the question';
	String get question_preview => 'Question Preview';
	String get show_preview => 'Show Preview';
	String get correct_answer => 'Correct Answer';
	String get correct_answer_placeholder => '【Required】Please input a correct answer.';
	String get lang_number_of_answer => 'Language of answer';
	String get reading_out_answer => 'Reading out the answer';
	String get short_answer_enabled => 'Let them enter the answer';
	String get distractors => 'Distractors';
	String get distractor => 'Distractor';
	String get distractors_placeholder => 'You can input a distractor.';
	String get generate_distractors => 'Generate distractors';
	String get distractors_generated => 'Distractors generated';
	String get distractors_generation_failed => 'Distractors generation failed';
	String get explanation => 'Explanation';
	String get explanation_placeholder => 'You can input a explanation.';
	String get hint => 'Hint';
	String get hint_placeholder => 'You can input a hint for the question.';
	String get source_word => 'Source Word';
	String get source_sentence => 'Source Sentence';
	String corrected_time_ago({required Object time}) => 'Corrected ${time} ago';
	String incorrect_time_ago({required Object time}) => 'Incorrect ${time} ago';
	String correct_answer_rate({required Object percent}) => '${percent}% of correct answers';
	String get question_cover_text => 'Show question';
	String get choices_cover_text => 'Show choices';
	String get choices_cover_keys => 'Tap or Enter key';
	String get please_input_answer => 'Please input an answer.';
	String get modified => 'Modified the quiz.';
	String get word_quiz_edit_prevention => 'This quiz is based on the information of the dictionary, so you need to edit the dictionary item to change it.';
	String get sentence_quiz_edit_prevention => 'This quiz is based on the information of the sentence, so you need to edit the sentence to change it.';
	String get do_not_know => 'Pass';
}

// Path: ranking
class TranslationsRankingEn {
	TranslationsRankingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get ranking => 'Ranking';
	String get daily => 'Daily';
	String get weekly => 'Weekly';
	String get monthly => 'Monthly';
	String get daily_answerer => 'Daily Answerers Ranking';
	String get weekly_answerer => 'Weekly Answerers Ranking';
	String get monthly_answerer => 'Monthly Answerers Ranking';
	String rank({required Object number}) => 'No.${number}';
	String user_ranking({required Object rank, required Object name}) => '#${rank}: ${name}';
	String daily_answer_count({required Object count}) => 'Answers Today: ${count}';
	String weekly_answer_count({required Object count}) => 'Answers This Week: ${count}';
	String monthly_answer_count({required Object count}) => 'Answers This Month: ${count}';
}

// Path: reviews
class TranslationsReviewsEn {
	TranslationsReviewsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get reviews => 'Reviews';
	String get unreviewed => 'Unreviewed';
	String get scheduled => 'Scheduled';
	String get all => 'All';
	String get order => 'Order';
	String get random_random => 'Random';
	String get scheduled_date_desc => 'Latest first';
	String get scheduled_date_asc => 'Upcoming first';
	String get empty => 'There are no review questions.';
	String get memorize => 'Remember';
	String get word_label => 'Remember the meaning';
	String get reversed_word_label => 'Remember the word';
	String get sentence_label => 'Be able to read';
	String get reversed_sentence_label => 'be able to speak';
	String get listening_sentence_label => 'Be able to listen';
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
	String scheduled_at({required Object scheduled_date}) => 'Scheduled at ${scheduled_date}';
	String get delete_all_reviews_completed => 'All reviews have been deleted.';
	String get cancel => 'Cancel';
	String get confirm_deletion => 'Delete Confirmation';
	String get execute => 'Delete';
	String get delete_all_reviews_confirmation => 'All reviews will be deleted. This operation cannot be undone. Are you sure you want to proceed?';
	String get all_review_deletion_help_link_description => 'How to delete all reviews';
}

// Path: schools
class TranslationsSchoolsEn {
	TranslationsSchoolsEn._(this._root);

	final Translations _root; // ignore: unused_field

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

// Path: senses
class TranslationsSensesEn {
	TranslationsSensesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get senses => 'Meaning details';
	String get sense => 'Sense';
	String get gloss => 'Gloss';
	String get add => 'Add sense';
	String get show_preview => 'Show preview';
	String get meaning_preview => 'Preview definition';
	String get destroy => 'Delete';
	String get confirm_destroy => 'Confirm Deletion';
	String get confirm_destroy_message => 'Are you sure you want to request deletion of this definition?';
}

// Path: sentenceRequests
class TranslationsSentenceRequestsEn {
	TranslationsSentenceRequestsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get sentence_requests => 'Edit histories of example sentences';
	String get edit_histories => 'Edit Histories';
	String get pending_edits => 'Pending Edits';
	String get rejected_edits => 'Rejected Edits';
	String get edit_applied => 'Your edit applied.';
	String get addition_request_submitted => 'Your addition request submitted.';
	String get modification_request_submitted => 'Your modification request submitted.';
	String get elimination_request_submitted => 'Your elimination request submitted.';
	String get already_submitted => 'You have already submitted a request.';
	String get addition => 'Addition of sentence';
	String get modification => 'Modification of sentence';
	String get elimination => 'Deletion of sentence';
	String get acceptance => 'Adopted';
	String get rejection => 'Rejected';
	String get pending => 'Pending';
}

// Path: sentences
class TranslationsSentencesEn {
	TranslationsSentencesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get sentences => 'Sentences';
	String get sentence => 'Sentence';
	String get add => 'Add sentence';
	String get edit => 'Edit sentence';
	String get remove => 'Remove sentence';
	String get destroy => 'Delete sentence';
	String get original => 'Original';
	String get original_ssml => 'Original SSML';
	String get translation => 'Translation';
	String original_placeholder({required Object language}) => 'Please enter an example sentence in ${language}.';
	String translation_placeholder({required Object language}) => 'Please enter a ${language} translation of the example sentence.';
	String get explanation => 'Explanation';
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
	String get what_is_this_button => 'What is this button?';
}

// Path: sessions
class TranslationsSessionsEn {
	TranslationsSessionsEn._(this._root);

	final Translations _root; // ignore: unused_field

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
	String get okay => 'OK';
	String get continue_with_apple => 'Continue with Apple';
	String get continue_with_google => 'Continue with Google';
	String get continue_with_twitter => 'Continue with Twitter';
	String get confirm_web_diqt => 'Open DiQt in your web browser?';
	String get external_link => 'External link';
	String get log_out => 'Log out';
	String get log_out_succeeded => 'Logged out';
}

// Path: shared
class TranslationsSharedEn {
	TranslationsSharedEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get create => 'Create';
	String get create_succeeded => 'Created';
	String get create_failed => 'Create failed';
	String get edit => 'Edit';
	String get update => 'Update';
	String get update_succeeded => 'Updated';
	String get update_failed => 'Update failed';
	String get return_confirmation => 'Confirmation';
	String get return_confirmation_description => 'Discard the edit and return. Are you sure?';
	String get destroy => 'Destroy';
	String get destroy_confirmation => 'Delete Confirmation';
	String get destroy_confirmation_description => 'Are you sure you want to delete it?';
	String get destroy_comment => 'Delete Reason';
	String get destroy_comment_placeholder => 'Please enter the reason for deletion';
	String get destroy_succeeded => 'Destroyed';
	String get cancel => 'Cancel';
	String get ok => 'OK';
	String get yes => 'Yes';
	String get no => 'No';
	String get reload => 'Reload';
	String get search => 'Search';
	String get generate => 'Generate';
	String get send => 'Send';
	String get set_up => 'Set Up';
	String get share => 'Share';
	String get close => 'Close';
	String get undefined => 'Undefined';
	String get details => 'Details';
	String get view_details => 'View Details';
	String get view_more => 'View More';
	String please_enter({required Object name}) => 'Please enter "${name}"';
	String no_more_items({required Object name}) => 'All ${name} loaded';
	String no_items_found({required Object name}) => 'No ${name} found';
	String no_name_found({required Object name}) => 'No ${name} found';
	String get no_item_found => 'No item found';
	String get premium_recommendation => 'To use this function, you need to register for a premium plan.';
	String get login_recommendation => 'To use this function, you need to log in.';
	String get processing => 'Processing';
	String get done => 'Done';
	String get download => 'Download';
	String get diqt_markdown => 'DiQt Markdown';
	String get diqt_markdown_supported => 'DiQt Markdown Supported';
	String get required => 'Required';
	String get dictionary_setting => 'Dictionary Setting';
	String get thumbnail => 'Thumbnail';
	String get remove_thumbnail => 'Remove Thumbnail';
	String image_alt({required Object name}) => 'Image of ${name}';
	String get error_occurred => 'An error occurred.';
	String get fix_error => 'Fix error';
	String get error_fixed => 'Error fixed.';
	String get ssml_template_generation_failed => 'Failed to generate SSML template.';
	String get how_to_write_ssml => 'How to write SSML';
	String get preview => 'Preview';
	String get audio_preview => 'Audio Preview';
	String get generate_template => 'Generate template';
}

// Path: timeZone
class TranslationsTimeZoneEn {
	TranslationsTimeZoneEn._(this._root);

	final Translations _root; // ignore: unused_field

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

// Path: users
class TranslationsUsersEn {
	TranslationsUsersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get users => 'Users';
	String get user => 'User';
	String get anonymous_user => 'Anonymous user';
	String get deleted_user => 'Deleted user';
	String get creating_account_succeeded => 'Your account registration has been completed! Welcome to DiQt!';
	String get show => 'User Page';
	String get menu => 'Menu';
	String get find_users => 'Find users';
	String get search => 'Search';
	String get enter_keyword => 'Enter keyword';
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
	String get time_zone_description => 'By setting the time zone, you can solve the problem of time difference and receive more accurate notifications such as review notifications.';
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
	String get drills => 'Created drills';
	String get follow => 'Follow';
	String get following => 'Following';
	String get resume => 'Resume';
	String get status => 'Status';
	String get please_set_password => 'Please set your password.';
	String get please_set_email => 'Please set your email address.';
	String get please_activate_email => 'Please verify your email address.';
	String get already_activated => 'Your email address has already been verified.';
	String get activation => 'Verification';
	String get activation_cta_text => 'Click on the button below to send an email confirming your identity. Then click on the button in the email.';
	String get activation_description => 'This is to confirm that your registered email address is your own and is an important security operation, for example, to prevent identity theft. Verifying your email address also allows you to reset your password if you forget it, for example. We frequently receive inquiries from users who have logged out without verifying their identity, forgotten their password, and cannot log in (we will, of course, take care of this for you). (Of course, we will take care of this).';
	String get send_activation_email => 'Send verification email';
	String get activation_email_resent => 'We have sent you a verification email. Please click on the link in the email to complete the verification.';
	String get activated => 'Your email address has been verified.';
	String get activation_failed => 'Invalid link. Verification failed.';
	String get email_change => 'Change email address';
	String get email_change_cta_text => 'Set up a new email address and press the button below to send the email address change email. Then click on the button in the email.';
	String get change_email => 'Change email address';
	String get new_email => 'New email address';
	String get already_taken => 'This email address is already in use.';
	String get email_change_email_resent => 'We have sent you an email to change your email address. Please click on the link in the email to complete the change.';
	String get email_changed => 'Your email address has been changed.';
	String get expired => 'The link has expired.';
	String get accumulated_experience => 'Accumulated experience';
	String get total_answers_count => 'Total number of answers';
	String get total_answer_days_count => 'Total number of answer days';
	String get todays_answers_count => 'Number of answers today';
	String get weekly_answers_count => 'Number of answers this week';
	String get monthly_answers_count => 'Number of answers this month';
	String answers_count({required Object count}) => '${count} answers';
	String answer_days_count({required Object count}) => '${count} days';
	String exp_for_next_level({required Object exp}) => '${exp} more EXP to the next level';
	String continuous_answer_days_count({required Object count}) => '${count} days of continuous answers!';
	String continuous_goal_achievement_count({required Object count}) => '${count} days of continuous goal achievement!';
	String continuous_review_completion_count({required Object count}) => '${count} days of continuous review completion!';
	String get language_settings => 'Language settings';
	String get invite => 'Invite friends';
	String invitation_message({required Object name}) => 'Hey! ${name} wants you to join DiQt✨\nLet\'s learn languages together!';
}

// Path: weaknesses
class TranslationsWeaknessesEn {
	TranslationsWeaknessesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get weakness => 'Weakness';
	String get weaknesses => 'Weaknesses';
	String quizzes_count({required Object count}) => '${count} quizzes';
	String get premium_recommendation => 'To solve weak questions, you need to register for a premium plan.';
	String get order => 'Order';
	String get correct_answer_rate => 'Correct Rate';
	String get correct_answer_rate_asc => 'Correct Rate, Low to High';
	String get correct_answer_rate_desc => 'Correct Rate, High to Low';
	String get incorrect_answers_count_desc => 'Incorrect, Most to Least';
	String get incorrect_answers_count_asc => 'Incorrect, Least to Most';
	String get created_at_desc => 'Added, Newest First';
	String get created_at_asc => 'Added, Oldest First';
	String get random_random => 'Random';
	String get set_to_weakness => 'Add to Weakness';
	String get remove_from_weakness => 'Remove from Weakness';
	String get weakness_condition => 'Addition Condition';
	String weakness_condition_description({required Object number}) => 'Questions that are answered incorrectly more than ${number} times are automatically added to the weakness.';
	String get overcoming_condition => 'Overcoming Condition';
	String overcoming_condition_description({required Object number}) => 'When the correct answer rate is ${number} or more, it is automatically removed from the weakness.';
	String get edit => 'Edit weakness settings';
	String get unsolved => 'Incorrect';
	String get solved => 'Correct';
	String get all => 'All';
	String added_at({required Object time_ago}) => 'Added ${time_ago}';
	String incorrect_answers_count({required Object count}) => '${count} Incorrect';
	String get weakness_overcame => 'Weakness overcame';
	String get new_lap => 'New rounds of weakness';
	String get new_lap_description => 'Return all questions that have been answered correctly to uncorrected. Are you sure?';
	String get new_lap_started => 'All questions returned as uncorrected.';
}

// Path: wordRequestComments
class TranslationsWordRequestCommentsEn {
	TranslationsWordRequestCommentsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get comment => 'Comment';
	String get comment_to_you => 'Comment to you';
	String get comment_placeholder => 'Write a comment';
	String get send => 'Send';
}

// Path: wordRequests
class TranslationsWordRequestsEn {
	TranslationsWordRequestsEn._(this._root);

	final Translations _root; // ignore: unused_field

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
	String get upvote => 'Upvote';
	String get downvote => 'Downvote';
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
	String get approved => 'You have voted for the request.';
	String get disapproved => 'You have voted against the request.';
	String get vote_cancelled => 'You have cancelled your vote for the request.';
	String votes_count_to_close({required Object count}) => 'Number of votes needed for decision: ${count}';
	String edited_at({required Object time}) => 'Edited ${time} ago';
	String get pending_reason => 'Reason for pending';
	String get duplicating_entry => 'The same item already exists.';
	String get changing_entry => 'The item name is about to be changed.';
	String get pending_elimination => 'The item is about to be deleted.';
	String get pending_modification => 'The item is about to be modified.';
	String get pending_addition => 'The item is about to be added.';
	String get unknown_reason => 'Other reasons';
	String get not_allowed_to_edit => 'You are not allowed to edit.';
}

// Path: words
class TranslationsWordsEn {
	TranslationsWordsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get words => 'Words';
	String get word => 'Word';
	String get add => 'Add Word';
	String get edit => 'Edit Word';
	String get created => 'Word Created';
	String get create_failed => 'Creating Word failed';
	String get updated => 'Word Updated';
	String get update_failed => 'Word Update Failed ';
	String get destroyed => 'Word Destroyed';
	String get entry => 'Headword';
	String get entry_ssml => 'Entry SSML';
	String get reading => 'Reading';
	String get pos_tag_id => 'Part of speech';
	String get meaning => 'Meaning';
	String get ipa => 'IPA(Pronunciation)';
	String get senses => 'Meaning details';
	String sense({required Object number}) => 'sense(${number})';
	String get show_senses => 'Show meaning details';
	String get search_sentence => 'Search Example Sentences';
	String get search_sentence_placeholder => 'Please enter the sentence you want to search for';
	String get no_sentence => 'No example sentence is set.';
	String get set_sentence_with_ai => 'Set an example sentence with AI';
	String get generate_meaning_with_ai => 'Generate meanings with AI';
	String get meaning_generation_keyword_placeholder => '【Required】Please enter the headword to generate the meaning.';
	String get success_to_generate_meanings => 'Successful generation of meanings.';
	String get failed_to_generate_meanings => 'Generation of meanings failed.';
	String get generate_ipa_with_ai => 'Generate IPA with AI';
	String get ipa_generation_keyword_placeholder => '【Required】Please enter the headword to generate the IPA.';
	String get regional_pronunciation => 'Generate regional pronunciations';
	String get success_to_generate_ipa => 'Successful generation of IPA.';
	String get failed_to_generate_ipa => 'Generation of IPA failed.';
	String get etymologies => 'Etymologies';
	String get explanation => 'Explanation';
	String get sentence => 'Example Sentence';
	String get synonyms => 'Synonyms';
	String get antonyms => 'Antonyms';
	String get related => 'Related Words';
	String get detailed_settings => 'Detailed Settings';
	String get comment => 'Editor\'s Comment';
	String get comment_placeholder => 'Please write your comments here if you have any';
	String get update => 'Fix';
	String get diqt_markdown_support => 'DiQt Markdown Support';
	String get text_preview => 'Preview';
	String get there_is_no_text => 'There is no text.';
	String get undefined_lang_number => 'Language is not set.';
	String get diqt_notation => 'DiQt Notation';
	String get destroy => 'Destroy';
	String get confirmation => 'Confirmation';
	String get edit_btn => 'Edit this word';
	String get new_btn => 'Add a word';
	String get view_your_edit => 'View your edit';
	String get details => 'Details';
	String get not_found => 'Not Found';
	String get pos_tag_required => 'Please select a part of speech.';
	String get sentence_required => 'Please set an example sentence.';
	String get what_is_this_button => 'What is this buttons?';
	String get ja_meaning => 'Japanese Meaning';
	String get en_meaning => 'English Meaning';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'achievements.view_got_medals': return 'View Got Medals';
			case 'achievements.getting_medal': return 'Medal acquisition!!';
			case 'achievements.getting_medal_for': return ({required Object name}) => '${name} Medal acquisition!!';
			case 'achievements.got_medals': return 'Got Medals';
			case 'achievements.receive_reward': return 'Receive Reward';
			case 'achievements.praise_text': return ({required Object name}) => 'Congratulations!! You have earned the ${name} medal! Please press the button below to receive the medal acquisition reward!!';
			case 'achievements.tutorial_medal': return 'Tutorial Medal';
			case 'achievements.tutorial_medal_introduction': return 'This is a medal that can be earned by achieving the basic operation of Dict.';
			case 'achievements.drill_clear_name': return 'Drill Clear';
			case 'achievements.drill_clear_introduction': return 'This is a medal that can be earned by going around the drill once.';
			case 'achievements.goal_achievement_name': return 'Goal Achievement';
			case 'achievements.goal_achievement_introduction': return 'This is a medal that can be earned by achieving your daily goal.';
			case 'achievements.review_completion_name': return 'Review Completion';
			case 'achievements.review_completion_introduction': return 'This is a medal that can be earned by completing a review.';
			case 'achievements.continuous_answer_name': return 'Continuous Answer';
			case 'achievements.continuous_answer_introduction': return 'This is a medal that can be earned by answering questions for two consecutive days.';
			case 'achievements.continuous_goal_achievement_name': return 'Continuous Goal Achievement';
			case 'achievements.continuous_goal_achievement_introduction': return 'This is a medal that can be earned by achieving your goal for two consecutive days.';
			case 'achievements.continuous_review_completion_name': return 'Continuous Review Completion';
			case 'achievements.continuous_review_completion_introduction': return 'This is a medal that can be earned by completing a review for two consecutive days.';
			case 'achievements.following_name': return 'Following';
			case 'achievements.following_introduction': return 'This is a medal that can be earned by following other users.';
			case 'achievements.cheering_name': return 'Cheering';
			case 'achievements.cheering_introduction': return 'This is a medal that can be earned by cheering for other users.';
			case 'achievements.all_week_continuation_name': return 'All Week Continuation';
			case 'achievements.all_week_continuation_introduction': return 'This is a medal that can be earned by answering questions for one week.';
			case 'achievements.answers_medal': return 'Answers Medal';
			case 'achievements.answers_medal_introduction': return 'This is a medal that can be earned according to the number of answers.';
			case 'achievements.answers_100_name': return '100 Answers';
			case 'achievements.answers_100_introduction': return 'This is a medal that can be earned by answering 100 questions.';
			case 'achievements.answers_500_name': return '500 Answers';
			case 'achievements.answers_500_introduction': return 'This is a medal that can be earned by answering 500 questions.';
			case 'achievements.answers_1000_name': return '1000 Answers';
			case 'achievements.answers_1000_introduction': return 'This is a medal that can be earned by answering 1000 questions.';
			case 'achievements.answers_2000_name': return '2000 Answers';
			case 'achievements.answers_2000_introduction': return 'This is a medal that can be earned by answering 2000 questions.';
			case 'achievements.answers_5000_name': return '5000 Answers';
			case 'achievements.answers_5000_introduction': return 'This is a medal that can be earned by answering 5000 questions.';
			case 'achievements.answers_10000_name': return '10000 Answers';
			case 'achievements.answers_10000_introduction': return 'This is a medal that can be earned by answering 10000 questions.';
			case 'achievements.answers_20000_name': return '20000 Answers';
			case 'achievements.answers_20000_introduction': return 'This is a medal that can be earned by answering 20000 questions.';
			case 'achievements.answers_30000_name': return '30000 Answers';
			case 'achievements.answers_30000_introduction': return 'This is a medal that can be earned by answering 30000 questions.';
			case 'achievements.answers_40000_name': return '40000 Answers';
			case 'achievements.answers_40000_introduction': return 'This is a medal that can be earned by answering 40000 questions.';
			case 'achievements.answers_50000_name': return '50000 Answers';
			case 'achievements.answers_50000_introduction': return 'This is a medal that can be earned by answering 50000 questions.';
			case 'achievements.answers_60000_name': return '60000 Answers';
			case 'achievements.answers_60000_introduction': return 'This is a medal that can be earned by answering 60000 questions.';
			case 'achievements.answers_70000_name': return '70000 Answers';
			case 'achievements.answers_70000_introduction': return 'This is a medal that can be earned by answering 70000 questions.';
			case 'achievements.answers_80000_name': return '80000 Answers';
			case 'achievements.answers_80000_introduction': return 'This is a medal that can be earned by answering 80000 questions.';
			case 'achievements.answers_90000_name': return '90000 Answers';
			case 'achievements.answers_90000_introduction': return 'This is a medal that can be earned by answering 90000 questions.';
			case 'achievements.answers_100000_name': return '100000 Answers';
			case 'achievements.answers_100000_introduction': return 'This is a medal that can be earned by answering 100000 questions.';
			case 'achievements.answer_days_medal': return 'Answer Days Medal';
			case 'achievements.answer_days_medal_introduction': return 'This is a medal that can be earned according to the number of answer days.';
			case 'achievements.answer_days_2_name': return '2 Days Answer';
			case 'achievements.answer_days_2_introduction': return 'This is a medal that can be earned by answering questions for two consecutive days.';
			case 'achievements.answer_days_7_name': return '7 Days Answer';
			case 'achievements.answer_days_7_introduction': return 'This is a medal that can be earned by answering questions for seven consecutive days.';
			case 'achievements.answer_days_14_name': return '14 Days Answer';
			case 'achievements.answer_days_14_introduction': return 'This is a medal that can be earned by answering questions for fourteen consecutive days.';
			case 'achievements.answer_days_30_name': return '30 Days Answer';
			case 'achievements.answer_days_30_introduction': return 'This is a medal that can be earned by answering questions for thirty consecutive days.';
			case 'achievements.answer_days_60_name': return '60 Days Answer';
			case 'achievements.answer_days_60_introduction': return 'This is a medal that can be earned by answering questions for sixty consecutive days.';
			case 'achievements.answer_days_100_name': return '100 Days Answer';
			case 'achievements.answer_days_100_introduction': return 'This is a medal that can be earned by answering questions for one hundred consecutive days.';
			case 'achievements.answer_days_200_name': return '200 Days Answer';
			case 'achievements.answer_days_200_introduction': return 'This is a medal that can be earned by answering questions for two hundred consecutive days.';
			case 'achievements.answer_days_300_name': return '300 Days Answer';
			case 'achievements.answer_days_300_introduction': return 'This is a medal that can be earned by answering questions for three hundred consecutive days.';
			case 'achievements.answer_days_365_name': return '365 Days Answer';
			case 'achievements.answer_days_365_introduction': return 'This is a medal that can be earned by answering questions for three hundred and sixty-five consecutive days.';
			case 'achievements.master_medal': return 'Master Medal';
			case 'achievements.master_medal_introduction': return 'This is a medal that can be earned by achieving the highest rank.';
			case 'achievements.lv_100_name': return 'Level 100';
			case 'achievements.lv_100_introduction': return 'This is a medal that can be earned by reaching level 100.';
			case 'achievements.rank_1_name': return 'Rank 1';
			case 'achievements.rank_1_introduction': return 'This is a medal that can be earned by reaching rank 1.';
			case 'achievements.all_year_continuation_name': return 'All Year Continuation';
			case 'achievements.all_year_continuation_introduction': return 'This is a medal that can be earned by answering questions for one year.';
			case 'achievements.tutorial_completion_name': return 'Tutorial Completion';
			case 'achievements.tutorial_completion_introduction': return 'This is a medal that can be earned by completing the tutorial.';
			case 'achievements.answers_completion_name': return 'Answers Completion';
			case 'achievements.answers_completion_introduction': return 'This is a medal that can be earned by answering questions for 100 consecutive days.';
			case 'achievements.answer_days_completion_name': return 'Answer Days Completion';
			case 'achievements.answer_days_completion_introduction': return 'This is a medal that can be earned by answering questions for 365 consecutive days.';
			case 'activities.activities': return 'Activities';
			case 'activities.display': return 'Display';
			case 'activities.all': return 'All users';
			case 'activities.following': return 'Following users';
			case 'activities.myself': return 'Myself';
			case 'activities.cheer': return 'Cheer';
			case 'activities.cheered': return 'Cheered';
			case 'activities.answer_days': return ({required Object name, required Object number}) => '${name} answered ${number} days!';
			case 'activities.continuation_count': return ({required Object number}) => '${number} days in a row!';
			case 'activities.all_week_continuation_count': return ({required Object number}) => '${number} weeks in a row!';
			case 'activities.all_month_continuation_count': return ({required Object number}) => '${number} months in a row!';
			case 'activities.all_year_continuation_count': return ({required Object number}) => '${number} years in a row!';
			case 'activities.goal_achievement': return ({required Object name, required Object number}) => '${name} achieved the daily goal (${number} answers)!';
			case 'activities.strict_goal_achievement': return ({required Object name, required Object number}) => '${name} achieved the daily goal in strict mode (${number} correct answers)!';
			case 'activities.continuous_goal_achievement': return ({required Object number}) => 'The goal was achieved for ${number} consecutive days!';
			case 'activities.review_completion': return ({required Object name}) => '${name} completed the review!';
			case 'activities.strict_review_completion': return ({required Object name}) => '${name} completed the review in strict mode!';
			case 'activities.continuous_review_completion': return ({required Object number}) => 'The review was completed for ${number} consecutive days!';
			case 'activities.drill_clear': return ({required Object name, required Object drill_title, required Object number}) => '${name} cleared "${drill_title}" ${number} times!';
			case 'activities.strict_drill_clear': return ({required Object name, required Object drill_title, required Object number}) => '${name} cleared "${drill_title}" ${number} times in strict mode!';
			case 'activities.level_up': return ({required Object name, required Object number}) => '${name} became Lv.${number}!';
			case 'activities.achievement': return ({required Object name, required Object achievement_name}) => '${name} earned the ${achievement_name} medal!';
			case 'answer.limit_reached': return 'Limit Reached';
			case 'answer.limit_reached_description': return ({required Object number}) => 'Free users can answer up to ${number} questions per day. Become a premium member and answer unlimited questions!';
			case 'answer.daily_bonus': return ({required Object count}) => '${count} days of answers';
			case 'answer.continuous_answers': return ({required Object count}) => '${count} days of continuous answers';
			case 'answer.continuous_goal_achievement': return ({required Object count}) => '${count} days of continuous goal achievement';
			case 'answer.continuous_review_completion': return ({required Object count}) => '${count} days of continuous review completion';
			case 'answer.goal_achievement': return 'Goal achievement';
			case 'answer.review_completion': return 'Review completion';
			case 'answer.strict_solving_mode': return 'Strict answer mode';
			case 'answer.strict_reviewing_mode': return 'Strict review mode';
			case 'answer.weekly_bonus': return ({required Object count}) => '${count} weeks of continuous answers';
			case 'answer.monthly_bonus': return ({required Object count}) => '${count} months of continuous answers';
			case 'answer.yearly_bonus': return ({required Object count}) => '${count} years of continuous answers';
			case 'answer.answers': return 'answers';
			case 'answer.answers_count': return ({required Object count}) => '${count} answers';
			case 'answer.same_mistake_message': return ({required Object count}) => 'You made this mistake ${count} times.';
			case 'answer.drill_clear': return 'Drill Clear';
			case 'answer.drill_clear_description': return ({required Object laps_count}) => 'Congratulations! You have answered all the questions in the drill! (${laps_count})';
			case 'answer.strict_drill_clear_description': return ({required Object laps_count}) => 'Congratulations! You have answered all the questions in the drill correctly! (${laps_count})';
			case 'answer.weakness_clear': return 'Weakness Clear';
			case 'answer.weakness_clear_description': return 'Congratulations! You have answered all the questions in the weakness correctly!';
			case 'answer.requesting_app_review': return 'Thank you very much for using DiQt so much! Did you like DiQt?';
			case 'answer.review_step_up': return ({required Object interval}) => 'Set review for ${interval} as step-up';
			case 'answer.review_released': return 'Review released';
			case 'answer.answers_on_normal_mode': return 'Answers: ';
			case 'answer.answers_on_strict_solving_mode': return 'Correct Answers: ';
			case 'answer.view_explanation': return 'View Explanation';
			case 'answer.level_up': return 'Level Up';
			case 'answer.level': return ({required Object level}) => 'Lv.${level}';
			case 'answerAnalyses.answer_analysis': return 'Answer Analysis';
			case 'answerAnalyses.answer_analyses': return 'Answer Analyses';
			case 'answerAnalyses.answer_histories': return 'Answer Histories';
			case 'answerAnalyses.premium_recommendation': return 'To access these features, you need to register for a premium plan.';
			case 'answerAnalyses.order': return 'Display';
			case 'answerAnalyses.correct_answer_rate_asc': return 'Correct Rate, Low to High';
			case 'answerAnalyses.correct_answer_rate_desc': return 'Correct Rate, High to Low';
			case 'answerAnalyses.incorrect_answer_histories_count_desc': return 'Mistakes, Most to Least';
			case 'answerAnalyses.incorrect_answer_histories_count_asc': return 'Mistakes, Least to Most';
			case 'answerAnalyses.last_answered_at_desc': return 'Answered History, New to Old';
			case 'answerAnalyses.last_answered_at_asc': return 'Answered History, Old to New';
			case 'answerAnalyses.analyze': return 'Analyze';
			case 'answerAnalyses.correct': return 'Correct';
			case 'answerAnalyses.incorrect': return 'Incorrect';
			case 'answerAnalyses.last_record': return ({required Object result, required Object time_ago}) => '${result} - ${time_ago}';
			case 'answerAnalyses.correct_at': return ({required Object time_ago}) => 'Correct ${time_ago}';
			case 'answerAnalyses.incorrect_at': return ({required Object time_ago}) => 'Incorrect ${time_ago}';
			case 'answerAnalyses.correct_answer_rate': return 'Correct Rate';
			case 'answerAnalyses.not_yet_answered': return 'You have not answered yet.';
			case 'answerAnalyses.answers_count': return ({required Object count}) => '${count} attempts';
			case 'answerAnalyses.correct_answers_count': return ({required Object count}) => '${count} Correct';
			case 'answerAnalyses.incorrect_answers_count': return ({required Object count}) => '${count} Incorrect';
			case 'answerAnalyses.last_answer': return 'Last Answer';
			case 'answerAnalyses.status': return 'Status';
			case 'answerHistories.answer_histories': return 'Answer Histories';
			case 'answerHistories.todays_mistakes': return 'Today\'s Mistakes';
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
			case 'answerSettings.adjust_difficulty': return 'How to increase the difficulty of questions';
			case 'answerSettings.adjust_review_difficulty': return 'How to increase the difficulty of reviews';
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
			case 'cancellation.cancel_subscription': return 'Cancel Subscription';
			case 'cancellation.please_login': return 'Please sign in';
			case 'cancellation.communication_error': return 'Network error occurred';
			case 'cancellation.confirm_cancellation': return 'Cancel Your Subscription';
			case 'cancellation.user_name_suffix': return ({required Object user}) => 'Hi ${user}!';
			case 'cancellation.premium_thanks': return 'Thanks for being a DiQt Premium member.';
			case 'cancellation.apology_message': return 'We\'re sorry we didn\'t meet your expectations.';
			case 'cancellation.feedback_request': return ({required Object user}) => '${user}, would you mind sharing what led to your decision to cancel? Your feedback will help us improve DiQt for everyone.';
			case 'cancellation.apology_for_trouble': return 'Sorry for the hassle.';
			case 'cancellation.honest_feedback_request': return 'We\'d love to hear your thoughts.';
			case 'cancellation.cancellation_reason_title': return 'Why are you leaving?';
			case 'cancellation.cancellation_reason_request': return 'Help us understand why you\'re canceling';
			case 'cancellation.cancellation_reason_required': return 'Please provide a reason for cancellation';
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
			case 'chapters.external_reference_link': return 'External Link';
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
			case 'dictionaries.keyword': return 'Keyword';
			case 'dictionaries.word_segmentation': return 'Word Segmentation';
			case 'dictionaries.search_results': return 'Search results';
			case 'dictionaries.search_results_of': return ({required Object query}) => 'Search results of "${query}"';
			case 'dictionaries.entry_not_found': return ({required Object query}) => '"${query}" is not found.';
			case 'dictionaries.keyword_not_found': return 'The keyword is not registered in the dictionary.';
			case 'dictionaries.search_by_web': return 'Search by Web';
			case 'dictionaries.search_by_another': return ({required Object name}) => 'Search by ${name}';
			case 'dictionaries.edit_by_web': return 'Edit by Web';
			case 'dictionaries.add_keyword_to_dictionary': return ({required Object keyword}) => 'Add "${keyword}" to the dictionary';
			case 'dictionaries.add_by_web': return 'Add by Web';
			case 'dictionaries.register_keyword': return 'Register keyword to the dictionary';
			case 'dictionaries.open_by_web': return 'Open by Web';
			case 'dictionaries.no_permission': return 'You don\'t have permission.';
			case 'dictionaries.no_addition_permission': return 'You don\'t have create permission.';
			case 'dictionaries.no_modification_permission': return 'You don\'t have update permission.';
			case 'dictionaries.no_elimination_permission': return 'You don\'t have delete permission.';
			case 'dictionaryMaps.please_select': return 'Please select a dictionary';
			case 'dictionaryMaps.not_selected': return 'Dictionary not selected';
			case 'dictionaryMaps.enter': return ({required Object language}) => 'Please enter ${language}';
			case 'dictionaryMaps.set_dictionaries': return 'Set dictionaries';
			case 'dictionaryMaps.add_dictionaries': return 'Add dictionaries';
			case 'dictionaryMaps.remove_dictionaries': return 'Remove dictionaries';
			case 'dictionaryMaps.select_dictionaries_to_use': return 'Select dictionaries to add';
			case 'dictionaryMaps.add': return 'Add';
			case 'dictionaryMaps.select_dictionaries_to_remove': return 'Select dictionaries to remove';
			case 'dictionaryMaps.remove': return 'Remove';
			case 'dictionaryMaps.set': return 'Set';
			case 'dictionaryMaps.update_success': return 'My Dictionaries Set';
			case 'dictionaryMaps.update_failed': return 'Setting My Dictionaries Failed';
			case 'dictionaryMaps.search_menu': return 'Search Menu';
			case 'dictionaryMaps.search_by_speech': return 'Search by speech';
			case 'dictionaryMaps.start_speech_recognition': return 'Start';
			case 'dictionaryMaps.stop_speech_recognition': return 'OK';
			case 'dictionaryMaps.search_by_image': return 'Search by image';
			case 'dictionaryMaps.image_for_ocr': return 'An image to load text';
			case 'dictionaryMaps.upload': return 'Upload';
			case 'drillLaps.resume': return 'Resume';
			case 'drillLaps.view_more': return 'View More';
			case 'drills.drills': return 'Drills';
			case 'drills.private_drill': return 'This drill is private';
			case 'drills.answers': return ({required Object number}) => '${number} answers';
			case 'drills.laps_count': return ({required Object number}) => 'Laps: ${number} ';
			case 'drills.clears_count': return ({required Object number}) => 'Clears: ${number}';
			case 'drills.unsolved': return 'Unsolved';
			case 'drills.solved': return 'Solved';
			case 'drills.all': return 'All';
			case 'drills.search': return 'Search Quizzes';
			case 'drills.pending_requests': return 'Pending Requests';
			case 'drills.accepted_requests': return 'Accepted Requests';
			case 'drills.rejected_requests': return 'Rejected Requests';
			case 'drills.create_drill': return 'Create drill';
			case 'drills.create_drill_with_csv': return 'Create drill with CSV';
			case 'drills.edit_drill': return 'Edit drill';
			case 'drills.edit_drill_with_csv': return 'Edit drill with csv';
			case 'drills.csv_blank': return 'Please attach a CSV file.';
			case 'drills.please_wait': return 'Creating drill. Please wait for 10 seconds.';
			case 'drills.title_placeholder': return 'Please enter the title of the drill';
			case 'drills.introduction': return 'Introduction';
			case 'drills.over_item_limit': return 'If you have more than 100 questions, please edit the questions from here';
			case 'drills.order': return 'Order';
			case 'drills.created_at_asc': return 'From the beginning';
			case 'drills.created_at_desc': return 'From the end';
			case 'drills.random_random': return 'Random';
			case 'drills.edit_setting': return 'Edit Setting';
			case 'drills.owner': return 'Owner';
			case 'drills.following_users': return 'Following Users';
			case 'drills.followed_users': return 'Followed Users';
			case 'drills.users': return 'Users';
			case 'drills.settings': return 'Settings';
			case 'drills.edit_tags': return 'Edit Tags';
			case 'drills.open': return 'Open';
			case 'drills.new_lap': return 'New Lap';
			case 'drills.new_lap_description': return 'Return all questions unanswered. Are you sure?';
			case 'drills.new_lap_started': return 'All questions were returned unanswered and a new round started.';
			case 'drills.require_login': return 'Please log in to solve problems.';
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
			case 'experiencePoints.to_the_next_level': return ({required Object points}) => '${points} EXP to the next level.';
			case 'home.welcome': return 'Welcome to DiQt!';
			case 'home.welcome_description_1': return 'DiQt is a dictionary app to help you never forget vocabulary.';
			case 'home.welcome_description_2': return 'Easy to use. Look up the word in the dictionary,';
			case 'home.welcome_description_3': return 'set a review for the word you want to memorize,';
			case 'home.welcome_description_4': return 'and you can review it automatically until you learn it.';
			case 'home.help_page': return 'Help Page';
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
			case 'inquiries.inquiry': return 'Inquiry';
			case 'inquiries.inquireis': return 'Inquiries';
			case 'inquiries.content': return 'Inquiry content';
			case 'inquiries.contact_form': return 'Contact form';
			case 'inquiries.contact_form_placeholder': return 'If you have any questions or concerns about DiQt, please feel free to contact us. We may reply to you by email at a later date if necessary.';
			case 'inquiries.contact_description': return ({required Object name}) => 'Please feel free to contact ${name} from the following.';
			case 'inquiries.inquiry_sent': return 'Your inquiry has been sent. We may reply to you by email at a later date if necessary.';
			case 'inquiries.sending_inquiry_failed': return 'Failed to send inquiry.';
			case 'lang.google_translation': return 'Google Translation';
			case 'lang.deepl_translation': return 'DeepL Translation';
			case 'lang.translating': return 'Translating...';
			case 'lang.done': return 'Done';
			case 'lang.translation_failed': return 'Translation Failed';
			case 'lang.translation_restricted': return ({required Object number}) => 'Free users are limited to ${number} translations per day.';
			case 'lang.ai_searches_restricted': return ({required Object number}) => 'Free users are limited to ${number} AI searches per day.';
			case 'lang.deepl_not_supported': return ({required Object language}) => '${language} is not supported by DeepL.';
			case 'lang.google_not_supported': return ({required Object language}) => '${language} is not supported by Google.';
			case 'lang.need_to_login': return 'You need to log in to use the translation.';
			case 'lang.ask_ai': return 'Ask AI';
			case 'lang.explain_meaning': return 'What does it mean?';
			case 'lang.explain_usage': return 'Please explain the usage.';
			case 'lang.explain_example': return 'Please explain the example.';
			case 'lang.explain_synonym': return 'Please explain the synonym.';
			case 'lang.explain_antonym': return 'Please explain the antonym.';
			case 'lang.explain_conjugation': return 'Please explain the conjugation.';
			case 'lang.explain_etymology': return 'Please explain the etymology.';
			case 'lang.explain_grammar': return 'Please explain the grammar and syntax in the sentence.';
			case 'lang.proofread_sentence': return 'Please proofread the sentence';
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
			case 'lang.zh_Hans': return 'Chinese (Simplified)';
			case 'lang.zh': return 'Chinese';
			case 'lang.zh_TW': return 'Chinese (Traditional)';
			case 'lang.zh_Hant': return 'Chinese (Traditional)';
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
			case 'lang.nb': return 'Norwegian (Bokmål)';
			case 'lang.no': return 'Norwegian';
			case 'lang.ny': return 'Nyanja (Chichewa)';
			case 'lang.or': return 'Odia (Oriya)';
			case 'lang.ps': return 'Pashto';
			case 'lang.fa': return 'Persian';
			case 'lang.pl': return 'Polish';
			case 'lang.prs': return 'Dari';
			case 'lang.pt': return 'Portuguese (Portugal, Brazil)';
			case 'lang.pa': return 'Punjabi';
			case 'lang.ro': return 'Romanian';
			case 'lang.ru': return 'Russian';
			case 'lang.sm': return 'Samoan';
			case 'lang.gd': return 'Scots Gaelic';
			case 'lang.sr': return 'Serbian';
			case 'lang.sr_Cryl': return 'Serbian (Cyrillic)';
			case 'lang.sr_Latn': return 'Serbian (Latin)';
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
			case 'layouts.other_apps': return 'How to make DiQt more useful!';
			case 'layouts.other_apps_description': return 'DiQt offers not only an application, but also a browser extension and a website. By using these together, you can learn vocabulary more conveniently and efficiently.';
			case 'layouts.chrome_extension': return 'Google Chrome Extension';
			case 'layouts.chrome_extension_description': return 'If you install the Google Chrome extension, you can set a review for a word just by clicking on it on a web page.';
			case 'layouts.free': return 'Free';
			case 'layouts.app_store_url': return 'https://apps.apple.com/us/app/diqt/id1594559036?uo=4';
			case 'layouts.play_store_url': return 'https://play.google.com/store/apps/details?id=com.booqs.booqs_mobile&hl=en';
			case 'layouts.chrome_web_store_url': return 'https://chrome.google.com/webstore/detail/booqs-dictionary/khgjdchimekphdebkmcknjkphkbpbpkj?hl=en&authuser=0';
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
			case 'notes.timestamp_info': return ({required Object updatedAtTimeAgo, required Object createdAtTimeAgo}) => 'Updated: ${updatedAtTimeAgo} / Created: ${createdAtTimeAgo}';
			case 'notices.notifications': return 'Notifications';
			case 'notices.cheered_message': return ({required Object name}) => '${name} has cheered you!';
			case 'notices.followed_message': return ({required Object name}) => '${name} has followed you!';
			case 'notices.word_request_accepted_message': return 'Your dictionary edit has been adopted!';
			case 'notices.word_request_commented_message': return 'Your dictionary edit has been commented!';
			case 'notices.word_request_upvoted_message': return ({required Object name}) => '${name} has upvoted your dictionary edit!';
			case 'notices.sentence_request_accepted_message': return 'Your example sentence edit has been adopted!';
			case 'notices.sentence_request_commented_message': return 'Your example sentence edit has been commented!';
			case 'notices.sentence_request_upvoted_message': return ({required Object name}) => '${name} has upvoted your example sentence edit!';
			case 'notices.quiz_request_accepted_message': return 'Your quiz edit has been adopted!';
			case 'notices.quiz_request_commented_message': return 'Your quiz edit has been commented!';
			case 'notices.quiz_request_upvoted_message': return ({required Object name}) => '${name} has upvoted your quiz edit!';
			case 'notices.reply': return 'Reply';
			case 'notices.achievement_acquired_message': return ({required Object name}) => 'You have acquired "${name} medal"!';
			case 'notices.monthly_date_format': return 'MMM yyyy';
			case 'notices.monthly_report': return '[Monthly Report]';
			case 'notices.monthly_ranking': return 'Monthly Ranking';
			case 'notices.weekly_first_date_format': return 'MMM dd, yyyy';
			case 'notices.weekly_last_date_format': return 'MMM dd';
			case 'notices.weekly_report': return '[Weekly Report]';
			case 'notices.weekly_ranking': return 'Weekly Ranking';
			case 'notices.ranking_position': return ({required Object rank}) => '#${rank}';
			case 'notices.answers_count': return 'Total Answers';
			case 'notices.answer_times': return ({required Object count}) => '${count} times';
			case 'purchase.premium_plan': return 'Premium Plan';
			case 'purchase.premium_plan_description': return 'This plan allows unlimited use of all DiQt features.';
			case 'purchase.trial_period_description': return 'Start with a 7-day free trial.';
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
			case 'purchase.unlimited_ai_searches': return 'Unlimited AI Features';
			case 'purchase.unlimited_ai_searches_description': return ({required Object number}) => 'Free users are limited to ${number} AI queries per day, but with Premium membership, you can use AI features unlimited times.';
			case 'purchase.unlimited_translations': return 'Unlimited Translations';
			case 'purchase.unlimited_translations_description': return ({required Object number}) => 'Free users can only translate ${number} times a day, but premium members can translate as many times a day as they like.';
			case 'purchase.weakness_description': return 'Premium members can focus on questions with low percentage of correct answers.';
			case 'purchase.note_description': return 'Premium members will be able to leave notes on answered questions.';
			case 'purchase.answer_analysis_description': return 'Premium members can analyze the questions they have answered by the percentage of correct answers and the number of mistakes.';
			case 'purchase.answer_history_description': return 'If you are a premium member, you can view the history of questions you have answered.';
			case 'purchase.questions_you_got_wrong_description': return 'If you are a premium member, you can review the questions you got wrong that day.';
			case 'purchase.deletion_of_all_reviews_description': return 'If you are a premium member, you can cancel all the reviews you have set up.';
			case 'purchase.ad_free_description': return 'If you are a premium member, you will no longer see all adverts in the app.';
			case 'purchase.restore': return 'Click here if you have previously purchased.';
			case 'purchase.restore_success': return 'Your purchase has been restored.';
			case 'purchase.restore_error': return 'Your purchase could not be restored.';
			case 'purchase.footer_description': return '・The premium subscription period is automatically renewed every month from the start date. \n ・The first payment starts at the end of the two-week free trial period. \n ・Unless you cancel more than 24 hours before the end of the premium subscription period, the subscription period will be automatically renewed. \n ・Please check the following before registering. \n';
			case 'purchase.monthly_premium_plan': return 'Monthly Premium Plan';
			case 'purchase.annual_premium_plan': return 'Annual Premium Plan';
			case 'purchase.price': return 'Price';
			case 'purchase.no_label': return ({required Object label}) => '${label}: None';
			case 'purchase.auto_renewal': return 'Auto-Renewal';
			case 'purchase.trial_period': return 'Free Trial Period';
			case 'purchase.subscription_store': return 'Purchase Platform';
			case 'purchase.cancellation_date': return ({required Object date}) => 'Will be cancelled on ${date}';
			case 'purchase.subscription_cancelled': return 'Cancelled';
			case 'purchase.renewal_date': return 'Renewal Date';
			case 'purchase.expiry_date': return 'Expiration Date';
			case 'purchase.no_contract': return 'You don\'t have a subscription plan';
			case 'purchase.subscribed_via_web': return 'Subscribed via web';
			case 'quizRequests.quiz_requests': return 'Edit Histories of quizzes';
			case 'quizRequests.edit_histories': return 'Edit Histories';
			case 'quizRequests.pending_edits': return 'Pending Edits';
			case 'quizRequests.edit_applied': return 'Your edit applied.';
			case 'quizRequests.addition_request_submitted': return 'Your addition request submitted.';
			case 'quizRequests.modification_request_submitted': return 'Your modification request submitted.';
			case 'quizRequests.elimination_request_submitted': return 'Your elimination request submitted.';
			case 'quizRequests.addition': return 'Addition of quiz';
			case 'quizRequests.modification': return 'Modification of quiz';
			case 'quizRequests.elimination': return 'Deletion of quiz';
			case 'quizRequests.acceptance': return 'Adopted';
			case 'quizRequests.rejection': return 'Rejected';
			case 'quizRequests.pending': return 'Pending';
			case 'quizzes.quiz': return 'Quiz';
			case 'quizzes.quizzes': return 'Quizzes';
			case 'quizzes.add': return 'Add Quiz';
			case 'quizzes.edit': return 'Edit Quiz';
			case 'quizzes.answer': return 'Answer';
			case 'quizzes.see_correct_answer': return 'See correct answer';
			case 'quizzes.correct': return 'Correct';
			case 'quizzes.wrong': return 'Wrong';
			case 'quizzes.got_a_correct': return 'Got a correct';
			case 'quizzes.made_a_mistake': return 'Made a mistake';
			case 'quizzes.question': return 'Question';
			case 'quizzes.question_placeholder': return '【Required】Please input a question.';
			case 'quizzes.lang_number_of_question': return 'Language of question';
			case 'quizzes.reading_out_question': return 'Reading out the question';
			case 'quizzes.question_hidden': return 'Hide the question';
			case 'quizzes.question_preview': return 'Question Preview';
			case 'quizzes.show_preview': return 'Show Preview';
			case 'quizzes.correct_answer': return 'Correct Answer';
			case 'quizzes.correct_answer_placeholder': return '【Required】Please input a correct answer.';
			case 'quizzes.lang_number_of_answer': return 'Language of answer';
			case 'quizzes.reading_out_answer': return 'Reading out the answer';
			case 'quizzes.short_answer_enabled': return 'Let them enter the answer';
			case 'quizzes.distractors': return 'Distractors';
			case 'quizzes.distractor': return 'Distractor';
			case 'quizzes.distractors_placeholder': return 'You can input a distractor.';
			case 'quizzes.generate_distractors': return 'Generate distractors';
			case 'quizzes.distractors_generated': return 'Distractors generated';
			case 'quizzes.distractors_generation_failed': return 'Distractors generation failed';
			case 'quizzes.explanation': return 'Explanation';
			case 'quizzes.explanation_placeholder': return 'You can input a explanation.';
			case 'quizzes.hint': return 'Hint';
			case 'quizzes.hint_placeholder': return 'You can input a hint for the question.';
			case 'quizzes.source_word': return 'Source Word';
			case 'quizzes.source_sentence': return 'Source Sentence';
			case 'quizzes.corrected_time_ago': return ({required Object time}) => 'Corrected ${time} ago';
			case 'quizzes.incorrect_time_ago': return ({required Object time}) => 'Incorrect ${time} ago';
			case 'quizzes.correct_answer_rate': return ({required Object percent}) => '${percent}% of correct answers';
			case 'quizzes.question_cover_text': return 'Show question';
			case 'quizzes.choices_cover_text': return 'Show choices';
			case 'quizzes.choices_cover_keys': return 'Tap or Enter key';
			case 'quizzes.please_input_answer': return 'Please input an answer.';
			case 'quizzes.modified': return 'Modified the quiz.';
			case 'quizzes.word_quiz_edit_prevention': return 'This quiz is based on the information of the dictionary, so you need to edit the dictionary item to change it.';
			case 'quizzes.sentence_quiz_edit_prevention': return 'This quiz is based on the information of the sentence, so you need to edit the sentence to change it.';
			case 'quizzes.do_not_know': return 'Pass';
			case 'ranking.ranking': return 'Ranking';
			case 'ranking.daily': return 'Daily';
			case 'ranking.weekly': return 'Weekly';
			case 'ranking.monthly': return 'Monthly';
			case 'ranking.daily_answerer': return 'Daily Answerers Ranking';
			case 'ranking.weekly_answerer': return 'Weekly Answerers Ranking';
			case 'ranking.monthly_answerer': return 'Monthly Answerers Ranking';
			case 'ranking.rank': return ({required Object number}) => 'No.${number}';
			case 'ranking.user_ranking': return ({required Object rank, required Object name}) => '#${rank}: ${name}';
			case 'ranking.daily_answer_count': return ({required Object count}) => 'Answers Today: ${count}';
			case 'ranking.weekly_answer_count': return ({required Object count}) => 'Answers This Week: ${count}';
			case 'ranking.monthly_answer_count': return ({required Object count}) => 'Answers This Month: ${count}';
			case 'reviews.reviews': return 'Reviews';
			case 'reviews.unreviewed': return 'Unreviewed';
			case 'reviews.scheduled': return 'Scheduled';
			case 'reviews.all': return 'All';
			case 'reviews.order': return 'Order';
			case 'reviews.random_random': return 'Random';
			case 'reviews.scheduled_date_desc': return 'Latest first';
			case 'reviews.scheduled_date_asc': return 'Upcoming first';
			case 'reviews.empty': return 'There are no review questions.';
			case 'reviews.memorize': return 'Remember';
			case 'reviews.word_label': return 'Remember the meaning';
			case 'reviews.reversed_word_label': return 'Remember the word';
			case 'reviews.sentence_label': return 'Be able to read';
			case 'reviews.reversed_sentence_label': return 'be able to speak';
			case 'reviews.listening_sentence_label': return 'Be able to listen';
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
			case 'reviews.scheduled_at': return ({required Object scheduled_date}) => 'Scheduled at ${scheduled_date}';
			case 'reviews.delete_all_reviews_completed': return 'All reviews have been deleted.';
			case 'reviews.cancel': return 'Cancel';
			case 'reviews.confirm_deletion': return 'Delete Confirmation';
			case 'reviews.execute': return 'Delete';
			case 'reviews.delete_all_reviews_confirmation': return 'All reviews will be deleted. This operation cannot be undone. Are you sure you want to proceed?';
			case 'reviews.all_review_deletion_help_link_description': return 'How to delete all reviews';
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
			case 'senses.senses': return 'Meaning details';
			case 'senses.sense': return 'Sense';
			case 'senses.gloss': return 'Gloss';
			case 'senses.add': return 'Add sense';
			case 'senses.show_preview': return 'Show preview';
			case 'senses.meaning_preview': return 'Preview definition';
			case 'senses.destroy': return 'Delete';
			case 'senses.confirm_destroy': return 'Confirm Deletion';
			case 'senses.confirm_destroy_message': return 'Are you sure you want to request deletion of this definition?';
			case 'sentenceRequests.sentence_requests': return 'Edit histories of example sentences';
			case 'sentenceRequests.edit_histories': return 'Edit Histories';
			case 'sentenceRequests.pending_edits': return 'Pending Edits';
			case 'sentenceRequests.rejected_edits': return 'Rejected Edits';
			case 'sentenceRequests.edit_applied': return 'Your edit applied.';
			case 'sentenceRequests.addition_request_submitted': return 'Your addition request submitted.';
			case 'sentenceRequests.modification_request_submitted': return 'Your modification request submitted.';
			case 'sentenceRequests.elimination_request_submitted': return 'Your elimination request submitted.';
			case 'sentenceRequests.already_submitted': return 'You have already submitted a request.';
			case 'sentenceRequests.addition': return 'Addition of sentence';
			case 'sentenceRequests.modification': return 'Modification of sentence';
			case 'sentenceRequests.elimination': return 'Deletion of sentence';
			case 'sentenceRequests.acceptance': return 'Adopted';
			case 'sentenceRequests.rejection': return 'Rejected';
			case 'sentenceRequests.pending': return 'Pending';
			case 'sentences.sentences': return 'Sentences';
			case 'sentences.sentence': return 'Sentence';
			case 'sentences.add': return 'Add sentence';
			case 'sentences.edit': return 'Edit sentence';
			case 'sentences.remove': return 'Remove sentence';
			case 'sentences.destroy': return 'Delete sentence';
			case 'sentences.original': return 'Original';
			case 'sentences.original_ssml': return 'Original SSML';
			case 'sentences.translation': return 'Translation';
			case 'sentences.original_placeholder': return ({required Object language}) => 'Please enter an example sentence in ${language}.';
			case 'sentences.translation_placeholder': return ({required Object language}) => 'Please enter a ${language} translation of the example sentence.';
			case 'sentences.explanation': return 'Explanation';
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
			case 'sentences.what_is_this_button': return 'What is this button?';
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
			case 'sessions.okay': return 'OK';
			case 'sessions.continue_with_apple': return 'Continue with Apple';
			case 'sessions.continue_with_google': return 'Continue with Google';
			case 'sessions.continue_with_twitter': return 'Continue with Twitter';
			case 'sessions.confirm_web_diqt': return 'Open DiQt in your web browser?';
			case 'sessions.external_link': return 'External link';
			case 'sessions.log_out': return 'Log out';
			case 'sessions.log_out_succeeded': return 'Logged out';
			case 'shared.create': return 'Create';
			case 'shared.create_succeeded': return 'Created';
			case 'shared.create_failed': return 'Create failed';
			case 'shared.edit': return 'Edit';
			case 'shared.update': return 'Update';
			case 'shared.update_succeeded': return 'Updated';
			case 'shared.update_failed': return 'Update failed';
			case 'shared.return_confirmation': return 'Confirmation';
			case 'shared.return_confirmation_description': return 'Discard the edit and return. Are you sure?';
			case 'shared.destroy': return 'Destroy';
			case 'shared.destroy_confirmation': return 'Delete Confirmation';
			case 'shared.destroy_confirmation_description': return 'Are you sure you want to delete it?';
			case 'shared.destroy_comment': return 'Delete Reason';
			case 'shared.destroy_comment_placeholder': return 'Please enter the reason for deletion';
			case 'shared.destroy_succeeded': return 'Destroyed';
			case 'shared.cancel': return 'Cancel';
			case 'shared.ok': return 'OK';
			case 'shared.yes': return 'Yes';
			case 'shared.no': return 'No';
			case 'shared.reload': return 'Reload';
			case 'shared.search': return 'Search';
			case 'shared.generate': return 'Generate';
			case 'shared.send': return 'Send';
			case 'shared.set_up': return 'Set Up';
			case 'shared.share': return 'Share';
			case 'shared.close': return 'Close';
			case 'shared.undefined': return 'Undefined';
			case 'shared.details': return 'Details';
			case 'shared.view_details': return 'View Details';
			case 'shared.view_more': return 'View More';
			case 'shared.please_enter': return ({required Object name}) => 'Please enter "${name}"';
			case 'shared.no_more_items': return ({required Object name}) => 'All ${name} loaded';
			case 'shared.no_items_found': return ({required Object name}) => 'No ${name} found';
			case 'shared.no_name_found': return ({required Object name}) => 'No ${name} found';
			case 'shared.no_item_found': return 'No item found';
			case 'shared.premium_recommendation': return 'To use this function, you need to register for a premium plan.';
			case 'shared.login_recommendation': return 'To use this function, you need to log in.';
			case 'shared.processing': return 'Processing';
			case 'shared.done': return 'Done';
			case 'shared.download': return 'Download';
			case 'shared.diqt_markdown': return 'DiQt Markdown';
			case 'shared.diqt_markdown_supported': return 'DiQt Markdown Supported';
			case 'shared.required': return 'Required';
			case 'shared.dictionary_setting': return 'Dictionary Setting';
			case 'shared.thumbnail': return 'Thumbnail';
			case 'shared.remove_thumbnail': return 'Remove Thumbnail';
			case 'shared.image_alt': return ({required Object name}) => 'Image of ${name}';
			case 'shared.error_occurred': return 'An error occurred.';
			case 'shared.fix_error': return 'Fix error';
			case 'shared.error_fixed': return 'Error fixed.';
			case 'shared.ssml_template_generation_failed': return 'Failed to generate SSML template.';
			case 'shared.how_to_write_ssml': return 'How to write SSML';
			case 'shared.preview': return 'Preview';
			case 'shared.audio_preview': return 'Audio Preview';
			case 'shared.generate_template': return 'Generate template';
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
			case 'users.users': return 'Users';
			case 'users.user': return 'User';
			case 'users.anonymous_user': return 'Anonymous user';
			case 'users.deleted_user': return 'Deleted user';
			case 'users.creating_account_succeeded': return 'Your account registration has been completed! Welcome to DiQt!';
			case 'users.show': return 'User Page';
			case 'users.menu': return 'Menu';
			case 'users.find_users': return 'Find users';
			case 'users.search': return 'Search';
			case 'users.enter_keyword': return 'Enter keyword';
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
			case 'users.time_zone_description': return 'By setting the time zone, you can solve the problem of time difference and receive more accurate notifications such as review notifications.';
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
			case 'users.drills': return 'Created drills';
			case 'users.follow': return 'Follow';
			case 'users.following': return 'Following';
			case 'users.resume': return 'Resume';
			case 'users.status': return 'Status';
			case 'users.please_set_password': return 'Please set your password.';
			case 'users.please_set_email': return 'Please set your email address.';
			case 'users.please_activate_email': return 'Please verify your email address.';
			case 'users.already_activated': return 'Your email address has already been verified.';
			case 'users.activation': return 'Verification';
			case 'users.activation_cta_text': return 'Click on the button below to send an email confirming your identity. Then click on the button in the email.';
			case 'users.activation_description': return 'This is to confirm that your registered email address is your own and is an important security operation, for example, to prevent identity theft. Verifying your email address also allows you to reset your password if you forget it, for example. We frequently receive inquiries from users who have logged out without verifying their identity, forgotten their password, and cannot log in (we will, of course, take care of this for you). (Of course, we will take care of this).';
			case 'users.send_activation_email': return 'Send verification email';
			case 'users.activation_email_resent': return 'We have sent you a verification email. Please click on the link in the email to complete the verification.';
			case 'users.activated': return 'Your email address has been verified.';
			case 'users.activation_failed': return 'Invalid link. Verification failed.';
			case 'users.email_change': return 'Change email address';
			case 'users.email_change_cta_text': return 'Set up a new email address and press the button below to send the email address change email. Then click on the button in the email.';
			case 'users.change_email': return 'Change email address';
			case 'users.new_email': return 'New email address';
			case 'users.already_taken': return 'This email address is already in use.';
			case 'users.email_change_email_resent': return 'We have sent you an email to change your email address. Please click on the link in the email to complete the change.';
			case 'users.email_changed': return 'Your email address has been changed.';
			case 'users.expired': return 'The link has expired.';
			case 'users.accumulated_experience': return 'Accumulated experience';
			case 'users.total_answers_count': return 'Total number of answers';
			case 'users.total_answer_days_count': return 'Total number of answer days';
			case 'users.todays_answers_count': return 'Number of answers today';
			case 'users.weekly_answers_count': return 'Number of answers this week';
			case 'users.monthly_answers_count': return 'Number of answers this month';
			case 'users.answers_count': return ({required Object count}) => '${count} answers';
			case 'users.answer_days_count': return ({required Object count}) => '${count} days';
			case 'users.exp_for_next_level': return ({required Object exp}) => '${exp} more EXP to the next level';
			case 'users.continuous_answer_days_count': return ({required Object count}) => '${count} days of continuous answers!';
			case 'users.continuous_goal_achievement_count': return ({required Object count}) => '${count} days of continuous goal achievement!';
			case 'users.continuous_review_completion_count': return ({required Object count}) => '${count} days of continuous review completion!';
			case 'users.language_settings': return 'Language settings';
			case 'users.invite': return 'Invite friends';
			case 'users.invitation_message': return ({required Object name}) => 'Hey! ${name} wants you to join DiQt✨\nLet\'s learn languages together!';
			case 'weaknesses.weakness': return 'Weakness';
			case 'weaknesses.weaknesses': return 'Weaknesses';
			case 'weaknesses.quizzes_count': return ({required Object count}) => '${count} quizzes';
			case 'weaknesses.premium_recommendation': return 'To solve weak questions, you need to register for a premium plan.';
			case 'weaknesses.order': return 'Order';
			case 'weaknesses.correct_answer_rate': return 'Correct Rate';
			case 'weaknesses.correct_answer_rate_asc': return 'Correct Rate, Low to High';
			case 'weaknesses.correct_answer_rate_desc': return 'Correct Rate, High to Low';
			case 'weaknesses.incorrect_answers_count_desc': return 'Incorrect, Most to Least';
			case 'weaknesses.incorrect_answers_count_asc': return 'Incorrect, Least to Most';
			case 'weaknesses.created_at_desc': return 'Added, Newest First';
			case 'weaknesses.created_at_asc': return 'Added, Oldest First';
			case 'weaknesses.random_random': return 'Random';
			case 'weaknesses.set_to_weakness': return 'Add to Weakness';
			case 'weaknesses.remove_from_weakness': return 'Remove from Weakness';
			case 'weaknesses.weakness_condition': return 'Addition Condition';
			case 'weaknesses.weakness_condition_description': return ({required Object number}) => 'Questions that are answered incorrectly more than ${number} times are automatically added to the weakness.';
			case 'weaknesses.overcoming_condition': return 'Overcoming Condition';
			case 'weaknesses.overcoming_condition_description': return ({required Object number}) => 'When the correct answer rate is ${number} or more, it is automatically removed from the weakness.';
			case 'weaknesses.edit': return 'Edit weakness settings';
			case 'weaknesses.unsolved': return 'Incorrect';
			case 'weaknesses.solved': return 'Correct';
			case 'weaknesses.all': return 'All';
			case 'weaknesses.added_at': return ({required Object time_ago}) => 'Added ${time_ago}';
			case 'weaknesses.incorrect_answers_count': return ({required Object count}) => '${count} Incorrect';
			case 'weaknesses.weakness_overcame': return 'Weakness overcame';
			case 'weaknesses.new_lap': return 'New rounds of weakness';
			case 'weaknesses.new_lap_description': return 'Return all questions that have been answered correctly to uncorrected. Are you sure?';
			case 'weaknesses.new_lap_started': return 'All questions returned as uncorrected.';
			case 'wordRequestComments.comment': return 'Comment';
			case 'wordRequestComments.comment_to_you': return 'Comment to you';
			case 'wordRequestComments.comment_placeholder': return 'Write a comment';
			case 'wordRequestComments.send': return 'Send';
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
			case 'wordRequests.upvote': return 'Upvote';
			case 'wordRequests.downvote': return 'Downvote';
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
			case 'wordRequests.approved': return 'You have voted for the request.';
			case 'wordRequests.disapproved': return 'You have voted against the request.';
			case 'wordRequests.vote_cancelled': return 'You have cancelled your vote for the request.';
			case 'wordRequests.votes_count_to_close': return ({required Object count}) => 'Number of votes needed for decision: ${count}';
			case 'wordRequests.edited_at': return ({required Object time}) => 'Edited ${time} ago';
			case 'wordRequests.pending_reason': return 'Reason for pending';
			case 'wordRequests.duplicating_entry': return 'The same item already exists.';
			case 'wordRequests.changing_entry': return 'The item name is about to be changed.';
			case 'wordRequests.pending_elimination': return 'The item is about to be deleted.';
			case 'wordRequests.pending_modification': return 'The item is about to be modified.';
			case 'wordRequests.pending_addition': return 'The item is about to be added.';
			case 'wordRequests.unknown_reason': return 'Other reasons';
			case 'wordRequests.not_allowed_to_edit': return 'You are not allowed to edit.';
			case 'words.words': return 'Words';
			case 'words.word': return 'Word';
			case 'words.add': return 'Add Word';
			case 'words.edit': return 'Edit Word';
			case 'words.created': return 'Word Created';
			case 'words.create_failed': return 'Creating Word failed';
			case 'words.updated': return 'Word Updated';
			case 'words.update_failed': return 'Word Update Failed ';
			case 'words.destroyed': return 'Word Destroyed';
			case 'words.entry': return 'Headword';
			case 'words.entry_ssml': return 'Entry SSML';
			case 'words.reading': return 'Reading';
			case 'words.pos_tag_id': return 'Part of speech';
			case 'words.meaning': return 'Meaning';
			case 'words.ipa': return 'IPA(Pronunciation)';
			case 'words.senses': return 'Meaning details';
			case 'words.sense': return ({required Object number}) => 'sense(${number})';
			case 'words.show_senses': return 'Show meaning details';
			case 'words.search_sentence': return 'Search Example Sentences';
			case 'words.search_sentence_placeholder': return 'Please enter the sentence you want to search for';
			case 'words.no_sentence': return 'No example sentence is set.';
			case 'words.set_sentence_with_ai': return 'Set an example sentence with AI';
			case 'words.generate_meaning_with_ai': return 'Generate meanings with AI';
			case 'words.meaning_generation_keyword_placeholder': return '【Required】Please enter the headword to generate the meaning.';
			case 'words.success_to_generate_meanings': return 'Successful generation of meanings.';
			case 'words.failed_to_generate_meanings': return 'Generation of meanings failed.';
			case 'words.generate_ipa_with_ai': return 'Generate IPA with AI';
			case 'words.ipa_generation_keyword_placeholder': return '【Required】Please enter the headword to generate the IPA.';
			case 'words.regional_pronunciation': return 'Generate regional pronunciations';
			case 'words.success_to_generate_ipa': return 'Successful generation of IPA.';
			case 'words.failed_to_generate_ipa': return 'Generation of IPA failed.';
			case 'words.etymologies': return 'Etymologies';
			case 'words.explanation': return 'Explanation';
			case 'words.sentence': return 'Example Sentence';
			case 'words.synonyms': return 'Synonyms';
			case 'words.antonyms': return 'Antonyms';
			case 'words.related': return 'Related Words';
			case 'words.detailed_settings': return 'Detailed Settings';
			case 'words.comment': return 'Editor\'s Comment';
			case 'words.comment_placeholder': return 'Please write your comments here if you have any';
			case 'words.update': return 'Fix';
			case 'words.diqt_markdown_support': return 'DiQt Markdown Support';
			case 'words.text_preview': return 'Preview';
			case 'words.there_is_no_text': return 'There is no text.';
			case 'words.undefined_lang_number': return 'Language is not set.';
			case 'words.diqt_notation': return 'DiQt Notation';
			case 'words.destroy': return 'Destroy';
			case 'words.confirmation': return 'Confirmation';
			case 'words.edit_btn': return 'Edit this word';
			case 'words.new_btn': return 'Add a word';
			case 'words.view_your_edit': return 'View your edit';
			case 'words.details': return 'Details';
			case 'words.not_found': return 'Not Found';
			case 'words.pos_tag_required': return 'Please select a part of speech.';
			case 'words.sentence_required': return 'Please set an example sentence.';
			case 'words.what_is_this_button': return 'What is this buttons?';
			case 'words.ja_meaning': return 'Japanese Meaning';
			case 'words.en_meaning': return 'English Meaning';
			default: return null;
		}
	}
}

