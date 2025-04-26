///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsJa implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsJa({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsJa _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAchievementsJa achievements = _TranslationsAchievementsJa._(_root);
	@override late final _TranslationsActivitiesJa activities = _TranslationsActivitiesJa._(_root);
	@override late final _TranslationsAnswerJa answer = _TranslationsAnswerJa._(_root);
	@override late final _TranslationsAnswerAnalysesJa answerAnalyses = _TranslationsAnswerAnalysesJa._(_root);
	@override late final _TranslationsAnswerHistoriesJa answerHistories = _TranslationsAnswerHistoriesJa._(_root);
	@override late final _TranslationsAnswerSettingsJa answerSettings = _TranslationsAnswerSettingsJa._(_root);
	@override late final _TranslationsCalendarsJa calendars = _TranslationsCalendarsJa._(_root);
	@override late final _TranslationsCancellationJa cancellation = _TranslationsCancellationJa._(_root);
	@override late final _TranslationsChaptersJa chapters = _TranslationsChaptersJa._(_root);
	@override late final _TranslationsDictionariesJa dictionaries = _TranslationsDictionariesJa._(_root);
	@override late final _TranslationsDictionaryMapsJa dictionaryMaps = _TranslationsDictionaryMapsJa._(_root);
	@override late final _TranslationsDrillLapsJa drillLaps = _TranslationsDrillLapsJa._(_root);
	@override late final _TranslationsDrillsJa drills = _TranslationsDrillsJa._(_root);
	@override late final _TranslationsErrorsJa errors = _TranslationsErrorsJa._(_root);
	@override late final _TranslationsExperiencePointsJa experiencePoints = _TranslationsExperiencePointsJa._(_root);
	@override late final _TranslationsHomeJa home = _TranslationsHomeJa._(_root);
	@override late final _TranslationsInquiriesJa inquiries = _TranslationsInquiriesJa._(_root);
	@override late final _TranslationsLangJa lang = _TranslationsLangJa._(_root);
	@override late final _TranslationsLayoutsJa layouts = _TranslationsLayoutsJa._(_root);
	@override late final _TranslationsNotesJa notes = _TranslationsNotesJa._(_root);
	@override late final _TranslationsNoticesJa notices = _TranslationsNoticesJa._(_root);
	@override late final _TranslationsPurchaseJa purchase = _TranslationsPurchaseJa._(_root);
	@override late final _TranslationsQuizRequestsJa quizRequests = _TranslationsQuizRequestsJa._(_root);
	@override late final _TranslationsQuizzesJa quizzes = _TranslationsQuizzesJa._(_root);
	@override late final _TranslationsRankingJa ranking = _TranslationsRankingJa._(_root);
	@override late final _TranslationsReviewsJa reviews = _TranslationsReviewsJa._(_root);
	@override late final _TranslationsSchoolsJa schools = _TranslationsSchoolsJa._(_root);
	@override late final _TranslationsSensesJa senses = _TranslationsSensesJa._(_root);
	@override late final _TranslationsSentenceRequestsJa sentenceRequests = _TranslationsSentenceRequestsJa._(_root);
	@override late final _TranslationsSentencesJa sentences = _TranslationsSentencesJa._(_root);
	@override late final _TranslationsSessionsJa sessions = _TranslationsSessionsJa._(_root);
	@override late final _TranslationsSharedJa shared = _TranslationsSharedJa._(_root);
	@override late final _TranslationsTimeZoneJa timeZone = _TranslationsTimeZoneJa._(_root);
	@override late final _TranslationsUsersJa users = _TranslationsUsersJa._(_root);
	@override late final _TranslationsWeaknessesJa weaknesses = _TranslationsWeaknessesJa._(_root);
	@override late final _TranslationsWordRequestCommentsJa wordRequestComments = _TranslationsWordRequestCommentsJa._(_root);
	@override late final _TranslationsWordRequestsJa wordRequests = _TranslationsWordRequestsJa._(_root);
	@override late final _TranslationsWordsJa words = _TranslationsWordsJa._(_root);
}

// Path: achievements
class _TranslationsAchievementsJa implements TranslationsAchievementsEn {
	_TranslationsAchievementsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get view_got_medals => '獲得メダルを見る';
	@override String get getting_medal => '実績メダル獲得！！';
	@override String getting_medal_for({required Object name}) => '${name}メダル獲得！！';
	@override String get got_medals => '獲得メダル';
	@override String get receive_reward => '報酬を受け取る';
	@override String praise_text({required Object name}) => 'おめでとうございます！！${name}メダルを獲得しました！以下のボタンを押してメダル獲得報酬を受け取ってください！！';
	@override String get tutorial_medal => 'チュートリアルメダル';
	@override String get tutorial_medal_introduction => 'ディクトの基本的操作を達成することで手に入るメダルです。';
	@override String get drill_clear_name => '問題集クリア';
	@override String get drill_clear_introduction => '問題集を１周することで獲得できるメダルです。';
	@override String get goal_achievement_name => '目標達成';
	@override String get goal_achievement_introduction => '1日の目標を達成することで獲得できるメダルです。';
	@override String get review_completion_name => '復習達成';
	@override String get review_completion_introduction => '復習を達成することで獲得できるメダルです。';
	@override String get continuous_answer_name => '連続解答達成';
	@override String get continuous_answer_introduction => '2日連続で問題を解くことで獲得できるメダルです。';
	@override String get continuous_goal_achievement_name => '連続目標達成';
	@override String get continuous_goal_achievement_introduction => '2日連続で目標を達成することで獲得できるメダルです。';
	@override String get continuous_review_completion_name => '連続復習達成';
	@override String get continuous_review_completion_introduction => '2日連続で復習を達成することで獲得できるメダルです。';
	@override String get following_name => 'フォロー';
	@override String get following_introduction => '他のユーザーをフォローすることで獲得できるメダルです。';
	@override String get cheering_name => '応援';
	@override String get cheering_introduction => '他のユーザーを応援することで獲得できるメダルです。';
	@override String get all_week_continuation_name => '１週間連続解答';
	@override String get all_week_continuation_introduction => '１週間連続で問題を解くことで獲得できるメダルです。';
	@override String get answers_medal => '解答数メダル';
	@override String get answers_medal_introduction => '解答数に応じて獲得できるメダルです。';
	@override String get answers_100_name => '100問解答';
	@override String get answers_100_introduction => '100問解答することで獲得できるメダルです。';
	@override String get answers_500_name => '500問解答';
	@override String get answers_500_introduction => '500問解答することで獲得できるメダルです。';
	@override String get answers_1000_name => '1000問解答';
	@override String get answers_1000_introduction => '1000問解答することで獲得できるメダルです。';
	@override String get answers_2000_name => '2000問解答';
	@override String get answers_2000_introduction => '2000問解答することで獲得できるメダルです。';
	@override String get answers_5000_name => '5000問解答';
	@override String get answers_5000_introduction => '5000問解答することで獲得できるメダルです。';
	@override String get answers_10000_name => '10000問解答';
	@override String get answers_10000_introduction => '10000問解答することで獲得できるメダルです。';
	@override String get answers_20000_name => '20000問解答';
	@override String get answers_20000_introduction => '20000問解答することで獲得できるメダルです。';
	@override String get answers_30000_name => '30000問解答';
	@override String get answers_30000_introduction => '30000問解答することで獲得できるメダルです。';
	@override String get answers_40000_name => '40000問解答';
	@override String get answers_40000_introduction => '40000問解答することで獲得できるメダルです。';
	@override String get answers_50000_name => '50000問解答';
	@override String get answers_50000_introduction => '50000問解答することで獲得できるメダルです。';
	@override String get answers_60000_name => '60000問解答';
	@override String get answers_60000_introduction => '60000問解答することで獲得できるメダルです。';
	@override String get answers_70000_name => '70000問解答';
	@override String get answers_70000_introduction => '70000問解答することで獲得できるメダルです。';
	@override String get answers_80000_name => '80000問解答';
	@override String get answers_80000_introduction => '80000問解答することで獲得できるメダルです。';
	@override String get answers_90000_name => '90000問解答';
	@override String get answers_90000_introduction => '90000問解答することで獲得できるメダルです。';
	@override String get answers_100000_name => '100000問解答';
	@override String get answers_100000_introduction => '100000問解答することで獲得できるメダルです。';
	@override String get answer_days_medal => '解答日数メダル';
	@override String get answer_days_medal_introduction => '解答日数に応じて獲得できるメダルです。';
	@override String get answer_days_2_name => '2日連続解答';
	@override String get answer_days_2_introduction => '2日問題を解くことで獲得できるメダルです。';
	@override String get answer_days_7_name => '7日連続解答';
	@override String get answer_days_7_introduction => '7日問題を解くことで獲得できるメダルです。';
	@override String get answer_days_14_name => '14日連続解答';
	@override String get answer_days_14_introduction => '14日問題を解くことで獲得できるメダルです。';
	@override String get answer_days_30_name => '30日連続解答';
	@override String get answer_days_30_introduction => '30日問題を解くことで獲得できるメダルです。';
	@override String get answer_days_60_name => '60日連続解答';
	@override String get answer_days_60_introduction => '60日問題を解くことで獲得できるメダルです。';
	@override String get answer_days_100_name => '100日連続解答';
	@override String get answer_days_100_introduction => '100日問題を解くことで獲得できるメダルです。';
	@override String get answer_days_200_name => '200日連続解答';
	@override String get answer_days_200_introduction => '200日問題を解くことで獲得できるメダルです。';
	@override String get answer_days_300_name => '300日連続解答';
	@override String get answer_days_300_introduction => '300日問題を解くことで獲得できるメダルです。';
	@override String get answer_days_365_name => '365日連続解答';
	@override String get answer_days_365_introduction => '365日問題を解くことで獲得できるメダルです。';
	@override String get master_medal => 'マスターメダル';
	@override String get master_medal_introduction => '偉業を成し遂げたときに獲得できるメダルです。';
	@override String get lv_100_name => 'レベル100';
	@override String get lv_100_introduction => 'レベル100に到達することで獲得できるメダルです。';
	@override String get rank_1_name => 'ランク1位';
	@override String get rank_1_introduction => 'ランキングで1位になることで獲得できるメダルです。';
	@override String get all_year_continuation_name => '１年間連続解答';
	@override String get all_year_continuation_introduction => '１年間連続で問題を解くことで獲得できるメダルです。';
	@override String get tutorial_completion_name => 'チュートリアルクリア';
	@override String get tutorial_completion_introduction => 'チュートリアルメダルをコンプリートすることで獲得できるメダルです。';
	@override String get answers_completion_name => '解答数コンプリート';
	@override String get answers_completion_introduction => '解答数メダルをコンプリートすることで獲得できるメダルです。';
	@override String get answer_days_completion_name => '解答日数コンプリート';
	@override String get answer_days_completion_introduction => '解答日数メダルをコンプリートすることで獲得できるメダルです。';
}

// Path: activities
class _TranslationsActivitiesJa implements TranslationsActivitiesEn {
	_TranslationsActivitiesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get activities => '活動';
	@override String get display => '表示';
	@override String get all => 'すべてユーザー';
	@override String get following => 'フォロー中のユーザー';
	@override String get myself => '自分';
	@override String get cheer => '応援する';
	@override String get cheered => '応援しました';
	@override String answer_days({required Object name, required Object number}) => '${name}が${number}日解答しました！';
	@override String continuation_count({required Object number}) => '${number}日連続で解答しました！';
	@override String all_week_continuation_count({required Object number}) => '${number}週間連続で解答しました！';
	@override String all_month_continuation_count({required Object number}) => '${number}ヶ月連続で解答しました！';
	@override String all_year_continuation_count({required Object number}) => '${number}年連続で解答しました！';
	@override String goal_achievement({required Object name, required Object number}) => '${name}が1日の目標（${number}問解答）を達成しました！';
	@override String strict_goal_achievement({required Object name, required Object number}) => '${name}が厳格解答モードで1日の目標（${number}問正解）を達成しました！';
	@override String continuous_goal_achievement({required Object number}) => '${number}日連続で目標を達成しました！';
	@override String review_completion({required Object name}) => '${name}が復習を達成しました！';
	@override String strict_review_completion({required Object name}) => '${name}が厳格復習モードで復習を達成しました！';
	@override String continuous_review_completion({required Object number}) => '${number}日連続で復習を達成しました！';
	@override String drill_clear({required Object name, required Object drill_title, required Object number}) => '${name}が「${drill_title}」を${number}周クリアしました！';
	@override String strict_drill_clear({required Object name, required Object drill_title, required Object number}) => '${name}が厳格解答モードで「${drill_title}」を${number}周クリアしました！';
	@override String level_up({required Object name, required Object number}) => '${name}がLv.${number}になりました！';
	@override String achievement({required Object name, required Object achievement_name}) => '${name}が${achievement_name}メダルを獲得しました！';
}

// Path: answer
class _TranslationsAnswerJa implements TranslationsAnswerEn {
	_TranslationsAnswerJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get limit_reached => '制限に達しました';
	@override String limit_reached_description({required Object number}) => '無料ユーザーが解けるのは、１日に${number}問までです。プレミアム会員になって、無制限に問題を解きましょう！';
	@override String daily_bonus({required Object count}) => '${count}日解答';
	@override String continuous_answers({required Object count}) => '${count}日連続解答';
	@override String continuous_goal_achievement({required Object count}) => '${count}日連続目標達成';
	@override String continuous_review_completion({required Object count}) => '${count}日連続復習達成';
	@override String get goal_achievement => '目標達成';
	@override String get review_completion => '復習達成';
	@override String get strict_solving_mode => '厳格解答モード';
	@override String get strict_reviewing_mode => '厳格復習モード';
	@override String weekly_bonus({required Object count}) => '${count}週間連続解答';
	@override String monthly_bonus({required Object count}) => '${count}ヶ月連続解答';
	@override String yearly_bonus({required Object count}) => '${count}年連続解答';
	@override String get answers => '問解答';
	@override String answers_count({required Object count}) => '${count}問解答';
	@override String same_mistake_message({required Object count}) => 'この間違いは${count}回目です';
	@override String get drill_clear => 'ドリルクリア';
	@override String drill_clear_description({required Object laps_count}) => 'おめでとうございます！ドリルを全問解答しました！（${laps_count}）';
	@override String strict_drill_clear_description({required Object laps_count}) => 'おめでとうございます！ドリルを全問正解しました！（${laps_count}）';
	@override String get weakness_clear => '弱点クリア';
	@override String get weakness_clear_description => 'おめでとうございます！弱点を全問正解しました！';
	@override String get requesting_app_review => 'これほどまでにご利用いただき、本当にありがとうございます！！ディクトは気に入っていただけましたでしょうか？';
	@override String review_step_up({required Object interval}) => '繰り上がりで${interval}に復習';
	@override String get review_released => '復習が解除されました。';
	@override String get answers_on_normal_mode => '解答数： ';
	@override String get answers_on_strict_solving_mode => '正解数: ';
	@override String get view_explanation => '解説を見る';
	@override String get level_up => 'レベルアップ';
	@override String level({required Object level}) => 'Lv.${level}';
}

// Path: answerAnalyses
class _TranslationsAnswerAnalysesJa implements TranslationsAnswerAnalysesEn {
	_TranslationsAnswerAnalysesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get answer_analysis => '解答分析';
	@override String get answer_analyses => '解答分析';
	@override String get answer_histories => '解答履歴';
	@override String get premium_recommendation => 'これらの機能を利用するには、プレミアムプランへの登録が必要です。';
	@override String get order => '表示';
	@override String get correct_answer_rate_asc => '正答率が低い順';
	@override String get correct_answer_rate_desc => '正答率が高い順';
	@override String get incorrect_answer_histories_count_desc => '間違いが多い順';
	@override String get incorrect_answer_histories_count_asc => '間違いが少ない順';
	@override String get last_answered_at_desc => '解答履歴：新しい順';
	@override String get last_answered_at_asc => '解答履歴：古い順';
	@override String get analyze => '分析する';
	@override String get correct => '正解';
	@override String get incorrect => '不正解';
	@override String last_record({required Object time_ago, required Object result}) => '${time_ago}に${result}';
	@override String correct_at({required Object time_ago}) => '${time_ago}に正解';
	@override String incorrect_at({required Object time_ago}) => '${time_ago}に不正解';
	@override String get correct_answer_rate => '正答率';
	@override String get not_yet_answered => 'まだ解答したことがありません。';
	@override String answers_count({required Object count}) => '${count}回解答';
	@override String correct_answers_count({required Object count}) => '${count}回正解';
	@override String incorrect_answers_count({required Object count}) => '${count}回不正解';
	@override String get last_answer => '最後の解答';
	@override String get status => '状態';
}

// Path: answerHistories
class _TranslationsAnswerHistoriesJa implements TranslationsAnswerHistoriesEn {
	_TranslationsAnswerHistoriesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get answer_histories => '解答履歴';
	@override String get todays_mistakes => '今日間違えた問題';
}

// Path: answerSettings
class _TranslationsAnswerSettingsJa implements TranslationsAnswerSettingsEn {
	_TranslationsAnswerSettingsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

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

// Path: calendars
class _TranslationsCalendarsJa implements TranslationsCalendarsEn {
	_TranslationsCalendarsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

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

// Path: cancellation
class _TranslationsCancellationJa implements TranslationsCancellationEn {
	_TranslationsCancellationJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get cancel_subscription => '解約する';
	@override String get please_login => 'ログインしてください';
	@override String get communication_error => '通信エラーが発生しました。';
	@override String get confirm_cancellation => '解約の確認';
	@override String user_name_suffix({required Object user}) => '${user}さま';
	@override String get premium_thanks => 'これまでDiQtのプレミアムプランをご利用いただき、誠にありがとうございました...!';
	@override String get apology_message => 'そして、今回ご期待に沿えなかったこと、大変申し訳なく思います....。';
	@override String feedback_request({required Object user}) => 'よろしければ、ぜひ今後のサービス改善のために、${user}さまがこの度プランをご解約されるにいたった理由を教えていただけないでしょうか...？';
	@override String get apology_for_trouble => 'お手数をおかけして大変申し訳ございません...!';
	@override String get honest_feedback_request => 'なにとぞ率直なご感想を、どうかよろしくお願いいたします...！！🙇‍♂️';
	@override String get cancellation_reason_title => '解約理由';
	@override String get cancellation_reason_request => '解約に至った理由を教えてください...!🙇‍♂️';
	@override String get cancellation_reason_required => '解約理由は空欄にできません。';
}

// Path: chapters
class _TranslationsChaptersJa implements TranslationsChaptersEn {
	_TranslationsChaptersJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

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
	@override String get external_reference_link => '外部参照リンク';
}

// Path: dictionaries
class _TranslationsDictionariesJa implements TranslationsDictionariesEn {
	_TranslationsDictionariesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

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
	@override String get keyword => '検索内容';
	@override String get word_segmentation => '単語に分割する';
	@override String get search_results => '検索結果';
	@override String search_results_of({required Object query}) => '『${query}』の検索結果';
	@override String entry_not_found({required Object query}) => '"${query}"は辞書に登録されていません。';
	@override String get keyword_not_found => '検索内容は辞書に登録されていません。';
	@override String get search_by_web => 'Webで検索する';
	@override String search_by_another({required Object name}) => '${name}で検索する';
	@override String get edit_by_web => 'Webで編集する';
	@override String add_keyword_to_dictionary({required Object keyword}) => '"${keyword}"を辞書に追加する';
	@override String get add_by_web => 'Webで追加する';
	@override String get register_keyword => '検索内容を辞書に登録する';
	@override String get open_by_web => 'Webで開く';
	@override String get no_permission => '権限がありません。';
	@override String get no_addition_permission => '追加する権限がありません。';
	@override String get no_modification_permission => '修正する権限がありません。';
	@override String get no_elimination_permission => '削除する権限がありません。';
}

// Path: dictionaryMaps
class _TranslationsDictionaryMapsJa implements TranslationsDictionaryMapsEn {
	_TranslationsDictionaryMapsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get please_select => '辞書を選択してください';
	@override String get not_selected => '辞書が選択されていません';
	@override String enter({required Object language}) => '${language}を入力してください';
	@override String get set_dictionaries => '辞書を設定する';
	@override String get add_dictionaries => '辞書を追加する';
	@override String get remove_dictionaries => '辞書を削除する';
	@override String get select_dictionaries_to_use => '追加する辞書を選択してください';
	@override String get add => '追加する';
	@override String get select_dictionaries_to_remove => '削除する辞書を選択してください';
	@override String get remove => '削除する';
	@override String get set => '設定する';
	@override String get update_success => 'My辞書を設定しました。';
	@override String get update_failed => 'My辞書が設定できませんでした。';
	@override String get search_menu => '検索メニュー';
	@override String get search_by_speech => '音声で検索する';
	@override String get start_speech_recognition => '開始する';
	@override String get stop_speech_recognition => '完了';
	@override String get search_by_image => '画像で検索する';
	@override String get image_for_ocr => '文字を読み込む画像';
	@override String get upload => 'アップロードする';
}

// Path: drillLaps
class _TranslationsDrillLapsJa implements TranslationsDrillLapsEn {
	_TranslationsDrillLapsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get resume => '続きから';
	@override String get view_more => 'もっと見る';
}

// Path: drills
class _TranslationsDrillsJa implements TranslationsDrillsEn {
	_TranslationsDrillsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get drills => 'ドリル';
	@override String get private_drill => 'このドリルは非公開です';
	@override String answers({required Object number}) => '${number}解答';
	@override String laps_count({required Object number}) => '${number}週目';
	@override String clears_count({required Object number}) => '${number}周クリア';
	@override String get unsolved => '未解答';
	@override String get solved => '解答済';
	@override String get all => 'すべて';
	@override String get search => '問題を検索する';
	@override String get pending_requests => '審査中の編集';
	@override String get accepted_requests => '承認済の編集';
	@override String get rejected_requests => '拒否済の編集';
	@override String get create_drill => 'ドリルを作成する';
	@override String get create_drill_with_csv => 'ドリルをCSVで作成する';
	@override String get edit_drill => 'ドリルを編集する';
	@override String get edit_drill_with_csv => 'CSVでドリルを編集する';
	@override String get csv_blank => 'CSVファイルを添付してください。';
	@override String get please_wait => '作成を開始しました。10秒ほどで出来上がります。';
	@override String get title_placeholder => '【必須】ドリルのタイトルを入力してください。';
	@override String get introduction => '紹介';
	@override String get over_item_limit => '100問を超える場合、問題の編集はこちらから行ってください。';
	@override String get order => '並び順';
	@override String get created_at_asc => '最初から';
	@override String get created_at_desc => '最後から';
	@override String get random_random => 'ランダム';
	@override String get edit_setting => 'Edit settings for quizzes';
	@override String get owner => '作成者';
	@override String get following_users => 'フォロー中のユーザー';
	@override String get followed_users => 'フォロワー';
	@override String get users => 'ユーザー';
	@override String get settings => '設定';
	@override String get edit_tags => 'タグを編集する';
	@override String get open => '開く';
	@override String get new_lap => '新たに周回する';
	@override String get new_lap_description => 'すべての問題を未解答に戻します。よろしいですか？';
	@override String get new_lap_started => 'すべての問題を未解答に戻し、新たな周回を始めました。';
	@override String get require_login => '問題を解くにはログインが必要です。';
}

// Path: errors
class _TranslationsErrorsJa implements TranslationsErrorsEn {
	_TranslationsErrorsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

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

// Path: experiencePoints
class _TranslationsExperiencePointsJa implements TranslationsExperiencePointsEn {
	_TranslationsExperiencePointsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String to_the_next_level({required Object points}) => '次のレベルまであと${points}EXP';
}

// Path: home
class _TranslationsHomeJa implements TranslationsHomeEn {
	_TranslationsHomeJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

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

// Path: inquiries
class _TranslationsInquiriesJa implements TranslationsInquiriesEn {
	_TranslationsInquiriesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get inquiry => 'お問い合わせ';
	@override String get inquireis => 'お問い合わせ';
	@override String get content => 'お問い合わせ内容';
	@override String get contact_form => 'お問い合わせフォーム';
	@override String get contact_form_placeholder => 'ディクトについて疑問点やご質問などございましたら、なんでもお気軽にご記入ください。必要に応じて、後日メールにてご返信させていただく場合もございます。';
	@override String contact_description({required Object name}) => '${name}へは、お気軽に以下からご連絡ください。';
	@override String get inquiry_sent => 'お問い合わせを送信しました。必要に応じて、後日メールにてご返信させていただく場合もございます。';
	@override String get sending_inquiry_failed => 'お問い合わせの送信に失敗しました。';
}

// Path: lang
class _TranslationsLangJa implements TranslationsLangEn {
	_TranslationsLangJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get google_translation => 'Google翻訳';
	@override String get deepl_translation => 'DeepL翻訳';
	@override String get translating => '翻訳中...';
	@override String get done => '完了';
	@override String get translation_failed => '翻訳できませんでした。';
	@override String translation_restricted({required Object number}) => '無料ユーザーが1日に翻訳できる回数は、${number}件までです。';
	@override String ai_searches_restricted({required Object number}) => '無料ユーザーが１日にAIに聞ける数は、${number}件までです。';
	@override String deepl_not_supported({required Object language}) => '${language}はDeepLが対応していない言語です。';
	@override String google_not_supported({required Object language}) => '${language}はGoogleが対応していない言語です。';
	@override String get need_to_login => '翻訳機能を利用するにはログインが必要です。';
	@override String get ask_ai => 'AIに聞く';
	@override String get explain_meaning => '意味を教えてください';
	@override String get explain_usage => '用法を教えてください';
	@override String get explain_example => '用例を教えてください';
	@override String get explain_synonym => '類義語を教えてください';
	@override String get explain_antonym => '反意語を教えてください';
	@override String get explain_conjugation => '活用形を教えてください';
	@override String get explain_etymology => '語源を教えてください';
	@override String get explain_grammar => '文中の文法や構文を解説してください';
	@override String get proofread_sentence => '文章を校正してください';
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
	@override String get zh_Hans => '中国語（簡体）';
	@override String get zh => '中国語';
	@override String get zh_TW => '中国語（繁体）';
	@override String get zh_Hant => '中国語（繁体）';
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
	@override String get nb => 'ノルウェー語（ブークモール）';
	@override String get no => 'ノルウェー語';
	@override String get ny => 'ニャンジャ語（チェワ語）';
	@override String get or => 'オリヤ語';
	@override String get ps => 'パシュト語';
	@override String get fa => 'ペルシャ語';
	@override String get pl => 'ポーランド語';
	@override String get prs => 'ダリー語';
	@override String get pt => 'ポルトガル語（ポルトガル、ブラジル）';
	@override String get pa => 'パンジャブ語';
	@override String get ro => 'ルーマニア語';
	@override String get ru => 'ロシア語';
	@override String get sm => 'サモア語';
	@override String get gd => 'スコットランド ゲール語';
	@override String get sr => 'セルビア語';
	@override String get sr_Cryl => 'セルビア語（キリル）';
	@override String get sr_Latn => 'セルビア語（ラテン）';
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

// Path: layouts
class _TranslationsLayoutsJa implements TranslationsLayoutsEn {
	_TranslationsLayoutsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

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
	@override String get other_apps => 'ディクトをもっと便利にする方法！';
	@override String get other_apps_description => 'ディクトは、アプリだけでなく、ブラウザ拡張機能や、Webサイトも提供しています。これらを併用することで、より便利に、より効率的に語彙を覚えられるようになります。';
	@override String get chrome_extension => 'Google Chrome拡張機能';
	@override String get chrome_extension_description => 'Google Chrome拡張機能をインストールすると、Webページ上の単語をクリックするだけで、単語に復習を設定できるようになります。';
	@override String get free => '無料';
	@override String get app_store_url => 'https://apps.apple.com/jp/app/diqt/id1594559036?uo=4';
	@override String get play_store_url => 'https://play.google.com/store/apps/details?id=com.booqs.booqs_mobile&hl=ja';
	@override String get chrome_web_store_url => 'https://chrome.google.com/webstore/detail/booqs-dictionary/khgjdchimekphdebkmcknjkphkbpbpkj?hl=ja&authuser=0';
}

// Path: notes
class _TranslationsNotesJa implements TranslationsNotesEn {
	_TranslationsNotesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

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
	@override String timestamp_info({required Object updatedAtTimeAgo, required Object createdAtTimeAgo}) => '更新：${updatedAtTimeAgo} / 作成：${createdAtTimeAgo}';
}

// Path: notices
class _TranslationsNoticesJa implements TranslationsNoticesEn {
	_TranslationsNoticesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get notifications => '通知';
	@override String cheered_message({required Object name}) => '${name}があなたを応援しました！';
	@override String followed_message({required Object name}) => '${name}があなたをフォローしました！';
	@override String get word_request_accepted_message => 'あなたの辞書の編集が採用されました！';
	@override String get word_request_commented_message => 'あなたの辞書の編集にコメントがつきました！';
	@override String word_request_upvoted_message({required Object name}) => '${name}があなたの辞書の編集に賛成しました！';
	@override String get sentence_request_accepted_message => 'あなたの例文の編集が採用されました！';
	@override String get sentence_request_commented_message => 'あなたの例文の編集にコメントがつきました！';
	@override String sentence_request_upvoted_message({required Object name}) => '${name}があなたの例文の編集に賛成しました！';
	@override String get quiz_request_accepted_message => 'あなたの問題の編集が採用されました！';
	@override String get quiz_request_commented_message => 'あなたの問題の編集にコメントがつきました！';
	@override String quiz_request_upvoted_message({required Object name}) => '${name}があなたの問題の編集に賛成しました！';
	@override String get reply => '返信する';
	@override String achievement_acquired_message({required Object name}) => '${name}メダルを獲得しました！';
	@override String get monthly_date_format => 'yyyy年MM月';
	@override String get monthly_report => '【月報】';
	@override String get monthly_ranking => '月間ランキング';
	@override String get weekly_first_date_format => 'yyyy年MM月dd日';
	@override String get weekly_last_date_format => 'MM月dd日';
	@override String get weekly_report => '【週報】';
	@override String get weekly_ranking => '週間ランキング';
	@override String ranking_position({required Object rank}) => '${rank}位';
	@override String get answers_count => '解答数';
	@override String answer_times({required Object count}) => '${count}回';
}

// Path: purchase
class _TranslationsPurchaseJa implements TranslationsPurchaseEn {
	_TranslationsPurchaseJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get premium_plan => 'プレミアムプラン';
	@override String get premium_plan_description => 'DiQtのすべての機能が使い放題になるプランです。';
	@override String get trial_period_description => '今なら７日間の無料体験期間つき！';
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
	@override String unlimited_answers_description({required Object number}) => '無料ユーザーが1日に解答できる問題の数は${number}問ですが、プレミアム会員になれば、1日に何問でも解答できるようになります。';
	@override String get unlimited_translations => '無制限の翻訳';
	@override String unlimited_translations_description({required Object number}) => '無料ユーザーが1日に翻訳できる回数は${number}回ですが、プレミアム会員になれば、1日に何回でも翻訳できるようになります。';
	@override String get unlimited_ai_searches => '無制限のAI機能';
	@override String unlimited_ai_searches_description({required Object number}) => '無料ユーザーが１日にAIに聞ける数は${number}回ですが、プレミアム会員になれば、1日に何回でもAIに聞けるようになります。';
	@override String get weakness_description => 'プレミアム会員になれば、正答率が低い問題を重点的に学習できるようになります。';
	@override String get note_description => 'プレミアム会員になれば、解いた問題にメモを残すことができるようになります。';
	@override String get answer_analysis_description => 'プレミアム会員になれば、正答率や間違えた回数で解いた問題を分析できるようになります。';
	@override String get answer_history_description => 'プレミアム会員になれば、解答した問題の履歴を閲覧できるようになります。';
	@override String get questions_you_got_wrong_description => 'プレミアム会員になれば、その日に間違えた問題を確認できるようになります。';
	@override String get deletion_of_all_reviews_description => 'プレミアム会員になれば、今までに設定した復習をすべて取り消すことができるようになります。';
	@override String get ad_free_description => 'プレミアム会員になれば、アプリ内のすべての広告が表示されなくなります。';
	@override String get restore => '以前に購入された方はこちら';
	@override String get restore_success => '購入が復元されました。';
	@override String get restore_error => '購入の復元に失敗しました。';
	@override String get footer_description => '・プレミアム契約期間は開始日から起算して1ヶ月ごとの自動更新となります。\n ・２週間の無料お試し期間が終了すると、最初のお支払いが始まります。\n ・プレミアム契約期間の終了日の24時間以上前に解約しない限り契約期間が『自動更新』されます。\n ・以下をご確認の上、ご登録ください。\n';
	@override String get monthly_premium_plan => '月額プレミアムプラン';
	@override String get annual_premium_plan => '年額プレミアムプラン';
	@override String get price => '価格';
	@override String no_label({required Object label}) => '${label}: なし';
	@override String get auto_renewal => '自動更新';
	@override String get trial_period => '無料お試し期間中';
	@override String get subscription_store => '契約ストア';
	@override String cancellation_date({required Object date}) => '${date}に解約されます';
	@override String get subscription_cancelled => '解約済';
	@override String get renewal_date => '契約更新日';
	@override String get expiry_date => '有効期限日';
	@override String get no_contract => 'ご契約プランがありません';
	@override String get subscribed_via_web => 'Webで契約しています';
}

// Path: quizRequests
class _TranslationsQuizRequestsJa implements TranslationsQuizRequestsEn {
	_TranslationsQuizRequestsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get quiz_requests => '問題の編集履歴';
	@override String get edit_histories => '編集履歴';
	@override String get pending_edits => '審査中の編集';
	@override String get edit_applied => '編集が適応されました。';
	@override String get addition_request_submitted => '追加リクエストが申請されました。';
	@override String get modification_request_submitted => '修正リクエストが申請されました。';
	@override String get elimination_request_submitted => '削除リクエストが申請されました。';
	@override String get addition => '問題の追加';
	@override String get modification => '問題の修正';
	@override String get elimination => '問題の削除';
	@override String get acceptance => '採用済';
	@override String get rejection => '却下済';
	@override String get pending => '審査中';
}

// Path: quizzes
class _TranslationsQuizzesJa implements TranslationsQuizzesEn {
	_TranslationsQuizzesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get quiz => '問題';
	@override String get quizzes => '問題';
	@override String get add => '問題を追加する';
	@override String get edit => '問題を編集する';
	@override String get answer => '解答する';
	@override String get see_correct_answer => '正解を見る';
	@override String get correct => '正解';
	@override String get wrong => '不正解';
	@override String get got_a_correct => '正解した';
	@override String get made_a_mistake => '間違えた';
	@override String get question => '問題文';
	@override String get question_placeholder => '【必須】問題文を入力してください。';
	@override String get lang_number_of_question => '問題の言語';
	@override String get reading_out_question => '問題の読み上げ';
	@override String get question_hidden => '問題文の非表示';
	@override String get question_preview => '問題のプレビュー';
	@override String get show_preview => 'プレビューを見る';
	@override String get correct_answer => '正解';
	@override String get correct_answer_placeholder => '【必須】正解を入力してください。';
	@override String get lang_number_of_answer => '答えの言語';
	@override String get reading_out_answer => '答えの読み上げ';
	@override String get short_answer_enabled => '答えを入力式にする';
	@override String get distractors => '誤りの選択肢';
	@override String get distractor => '誤りの選択肢';
	@override String get distractors_placeholder => '【空欄可】誤りの選択肢を設定できます。';
	@override String get generate_distractors => '誤りの選択肢を自動生成する';
	@override String get distractors_generated => '誤りの選択肢を自動生成しました。';
	@override String get distractors_generation_failed => '誤りの選択肢を自動生成できませんでした。';
	@override String get explanation => '解説';
	@override String get explanation_placeholder => '【空欄可】解説を設定できます。';
	@override String get hint => 'ヒント';
	@override String get hint_placeholder => '【空欄可】ヒントを設定できます。';
	@override String get source_word => '元となった辞書の項目';
	@override String get source_sentence => '元となった例文';
	@override String corrected_time_ago({required Object time}) => '${time}前に正解';
	@override String incorrect_time_ago({required Object time}) => '${time}前に不正解';
	@override String correct_answer_rate({required Object percent}) => '正答率${percent}%';
	@override String get question_cover_text => '問題文を表示する';
	@override String get choices_cover_text => '選択肢を表示する';
	@override String get choices_cover_keys => 'タップまたはEnterキー';
	@override String get please_input_answer => '解答を入力してください。';
	@override String get modified => '問題を修正しました。';
	@override String get word_quiz_edit_prevention => 'この問題は辞書の情報に基づいているため、変更するには辞書の項目の編集が必要です。';
	@override String get sentence_quiz_edit_prevention => 'この問題は例文の情報に基づいているため、変更するには例文の編集が必要です。';
	@override String get do_not_know => 'わからない';
}

// Path: ranking
class _TranslationsRankingJa implements TranslationsRankingEn {
	_TranslationsRankingJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get ranking => 'ランキング';
	@override String get daily => '日間';
	@override String get weekly => '週間';
	@override String get monthly => '月間';
	@override String get daily_answerer => '日間解答者ランキング';
	@override String get weekly_answerer => '週間解答者ランキング';
	@override String get monthly_answerer => '月間解答者ランキング';
	@override String rank({required Object number}) => '第${number}位';
	@override String user_ranking({required Object rank, required Object name}) => '${rank}位: ${name}';
	@override String daily_answer_count({required Object count}) => '解答数: ${count}';
	@override String weekly_answer_count({required Object count}) => '週間解答数: ${count}';
	@override String monthly_answer_count({required Object count}) => '月間解答数: ${count}';
}

// Path: reviews
class _TranslationsReviewsJa implements TranslationsReviewsEn {
	_TranslationsReviewsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get reviews => '復習';
	@override String get unreviewed => '未復習';
	@override String get scheduled => '予定';
	@override String get all => 'すべて';
	@override String get order => '順番';
	@override String get random_random => 'ランダム';
	@override String get scheduled_date_desc => '予定日が遠い順';
	@override String get scheduled_date_asc => '予定日が近い順';
	@override String get empty => '復習問題はありません。';
	@override String get memorize => '覚える';
	@override String get word_label => '意味を覚える';
	@override String get reversed_word_label => '単語を覚える';
	@override String get sentence_label => '読めるようになる';
	@override String get reversed_sentence_label => '話せるようになる';
	@override String get listening_sentence_label => '聞き取れるようになる';
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
	@override String scheduled_at({required Object scheduled_date}) => '${scheduled_date}に復習予定';
	@override String get delete_all_reviews_completed => '復習を全て削除しました。';
	@override String get cancel => 'キャンセル';
	@override String get confirm_deletion => '削除確認';
	@override String get execute => '実行する';
	@override String get delete_all_reviews_confirmation => '全ての復習を削除いたします。この操作は取り消せません。実行してもよろしいですか？';
}

// Path: schools
class _TranslationsSchoolsJa implements TranslationsSchoolsEn {
	_TranslationsSchoolsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

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

// Path: senses
class _TranslationsSensesJa implements TranslationsSensesEn {
	_TranslationsSensesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get senses => '意味の詳細';
	@override String get sense => '意味';
	@override String get gloss => '意味';
	@override String get add => '意味を追加する';
	@override String get show_preview => 'プレビューを見る';
	@override String get meaning_preview => '意味のプレビュー';
	@override String get destroy => '削除する';
	@override String get confirm_destroy => '削除確認';
	@override String get confirm_destroy_message => 'この意味の削除申請を行います。よろしいですか？';
}

// Path: sentenceRequests
class _TranslationsSentenceRequestsJa implements TranslationsSentenceRequestsEn {
	_TranslationsSentenceRequestsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get sentence_requests => '例文の編集履歴';
	@override String get edit_histories => '編集履歴';
	@override String get pending_edits => '審査中の編集';
	@override String get rejected_edits => '拒否された編集';
	@override String get edit_applied => '編集が適応されました。';
	@override String get addition_request_submitted => '追加リクエストが申請されました。';
	@override String get modification_request_submitted => '修正リクエストが申請されました。';
	@override String get elimination_request_submitted => '削除リクエストが申請されました。';
	@override String get already_submitted => '編集リクエストをすでに申請済みです。';
	@override String get addition => '例文の追加';
	@override String get modification => '例文の修正';
	@override String get elimination => '例文の削除';
	@override String get acceptance => '採用済';
	@override String get rejection => '却下済';
	@override String get pending => '審査中';
}

// Path: sentences
class _TranslationsSentencesJa implements TranslationsSentencesEn {
	_TranslationsSentencesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

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
	@override String get explanation => '解説';
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

// Path: sessions
class _TranslationsSessionsJa implements TranslationsSessionsEn {
	_TranslationsSessionsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

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
	@override String get okay => 'OK';
	@override String get continue_with_apple => 'Appleで続ける';
	@override String get continue_with_google => 'Googleで続ける';
	@override String get continue_with_twitter => 'Twitterで続ける';
	@override String get confirm_web_diqt => 'Web版DiQtに移動します。よろしいですか？';
	@override String get external_link => '外部リンク';
	@override String get log_out => 'ログアウトする';
	@override String get log_out_succeeded => 'ログアウトしました。';
}

// Path: shared
class _TranslationsSharedJa implements TranslationsSharedEn {
	_TranslationsSharedJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get create => '作成する';
	@override String get create_succeeded => '作成されました。';
	@override String get create_failed => '作成に失敗しました。';
	@override String get edit => '編集する';
	@override String get update => '更新する';
	@override String get update_succeeded => '更新されました。';
	@override String get update_failed => '更新に失敗しました。';
	@override String get return_confirmation => '確認';
	@override String get return_confirmation_description => '編集を破棄して戻ります。よろしいですか？';
	@override String get destroy => '削除する';
	@override String get destroy_confirmation => '削除の確認';
	@override String get destroy_confirmation_description => '本当に削除してもよろしいですか？';
	@override String get destroy_comment => '削除する理由';
	@override String get destroy_comment_placeholder => '削除する理由を入力してください。';
	@override String get destroy_succeeded => '削除しました。';
	@override String get cancel => 'キャンセルする';
	@override String get ok => 'OK';
	@override String get yes => 'はい';
	@override String get no => 'いいえ';
	@override String get reload => '再読み込みする';
	@override String get search => '検索する';
	@override String get generate => '生成する';
	@override String get send => '送信する';
	@override String get set_up => '設定する';
	@override String get share => 'シェアする';
	@override String get close => '閉じる';
	@override String get undefined => '未定義';
	@override String get details => '詳細';
	@override String get view_details => '詳細を見る';
	@override String get view_more => 'もっと見る';
	@override String please_enter({required Object name}) => '"${name}"を入力してください。';
	@override String no_more_items({required Object name}) => 'すべての${name}を読み込みました';
	@override String no_items_found({required Object name}) => '${name}がありません';
	@override String no_name_found({required Object name}) => '${name}が見つかりません';
	@override String get no_item_found => 'アイテムがありません';
	@override String get premium_recommendation => 'この機能を利用するには、プレミアムプランへの登録が必要です。';
	@override String get login_recommendation => 'この機能を利用するためには、ログインが必要です。';
	@override String get processing => '処理中...';
	@override String get done => '完了';
	@override String get download => 'ダウンロード';
	@override String get diqt_markdown => 'ディクト記法';
	@override String get diqt_markdown_supported => 'ディクト記法対応';
	@override String get required => '必須';
	@override String get dictionary_setting => '辞書設定';
	@override String get thumbnail => 'サムネイル';
	@override String get remove_thumbnail => 'サムネイルを削除する';
	@override String image_alt({required Object name}) => '${name}の画像';
	@override String get error_occurred => 'エラーが発生しました。';
	@override String get fix_error => 'エラーを修正する';
	@override String get error_fixed => 'エラーを修正しました。';
}

// Path: timeZone
class _TranslationsTimeZoneJa implements TranslationsTimeZoneEn {
	_TranslationsTimeZoneJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

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

// Path: users
class _TranslationsUsersJa implements TranslationsUsersEn {
	_TranslationsUsersJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get users => 'ユーザー';
	@override String get user => 'ユーザー';
	@override String get anonymous_user => '匿名ユーザー';
	@override String get deleted_user => '退会ユーザー';
	@override String get creating_account_succeeded => '会員登録が完了しました！ようこそDiQtへ！！';
	@override String get show => 'ユーザーページ';
	@override String get menu => 'メニュー';
	@override String get find_users => 'ユーザーを探す';
	@override String get search => '検索する';
	@override String get enter_keyword => 'キーワードを入力してください';
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
	@override String get time_zone_description => 'タイムゾーンを設定することで、時差の問題を解決し、復習通知などをより正確な時刻で受け取れるようになります。';
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
	@override String get follow => 'フォローする';
	@override String get following => 'フォロー中';
	@override String get resume => '続きから';
	@override String get status => 'ステータス';
	@override String get please_set_password => 'パスワードを設定してください。';
	@override String get please_set_email => 'メールアドレスを設定してください。';
	@override String get please_activate_email => 'メールアドレスのご本人確認を行ってください。';
	@override String get already_activated => 'すでにご本人確認済みです。';
	@override String get activation => 'ご本人様確認';
	@override String get activation_cta_text => '以下のボタンを押して、ご本人確認メールを送信してください。そして、メールの中のボタンをクリックしてください。';
	@override String get activation_description => 'これは登録したメールアドレスがあなた自身のものであることを確認するためのもので、なりすましの防止など、セキュリティのために重要な操作です。またメールアドレスのご本人確認を行うことによって、パスワードを忘れてしまった場合のパスワードリセット機能などがご利用いただけるようになります。残念ながら、たびたび、ご本人確認を行わずにログアウトしてしまい、パスワードを忘れてしまってログインできないというお問い合わせをいただきます（もちろん、その場合もご対応いたします）。';
	@override String get send_activation_email => '本人確認メールを送信する';
	@override String get activation_email_resent => 'ご本人確認メールを送信しました。メールのリンクをクリックして、ご本人確認を完了してください。';
	@override String get activated => 'ご本人確認が完了しました。';
	@override String get activation_failed => '無効なリンクです。ご本人確認できませんでした。';
	@override String get email_change => 'メールアドレス変更';
	@override String get email_change_cta_text => '新しいメールアドレスを設定し、以下のボタンを押して、メールアドレス変更メールを送信してください。そして、メールの中のボタンをクリックしてください。';
	@override String get change_email => 'メールアドレスを変更する';
	@override String get new_email => '新しいメールアドレス';
	@override String get already_taken => 'このメールアドレスはすでに使用されています。';
	@override String get email_change_email_resent => 'メールアドレス変更メールを送信しました。メールのリンクをクリックして、メールアドレス変更を完了してください。';
	@override String get email_changed => 'メールアドレスを変更しました。';
	@override String get expired => '有効期限が切れています。';
	@override String get accumulated_experience => '累積経験値';
	@override String get total_answers_count => '総合解答数';
	@override String get total_answer_days_count => '総合解答日数';
	@override String get todays_answers_count => '今日の解答数';
	@override String get weekly_answers_count => '今週の解答数';
	@override String get monthly_answers_count => '今月の解答数';
	@override String answers_count({required Object count}) => '${count}解答';
	@override String answer_days_count({required Object count}) => '${count}日';
	@override String exp_for_next_level({required Object exp}) => '次のレベルまであと${exp}EXP';
	@override String continuous_answer_days_count({required Object count}) => '${count}日連続解答中！';
	@override String continuous_goal_achievement_count({required Object count}) => '${count}日連続目標達成中！';
	@override String continuous_review_completion_count({required Object count}) => '${count}日連続復習達成中！';
	@override String get language_settings => '言語設定';
	@override String get invite => '友達を招待する';
	@override String invitation_message({required Object name}) => '${name}さんがあなたをDiQtに招待しました！✨\n新しい言語の世界へ飛び込もう！';
}

// Path: weaknesses
class _TranslationsWeaknessesJa implements TranslationsWeaknessesEn {
	_TranslationsWeaknessesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get weakness => '弱点問題';
	@override String get weaknesses => '弱点問題';
	@override String quizzes_count({required Object count}) => '${count}問';
	@override String get premium_recommendation => '弱点問題を解くには、プレミアムプランへの登録が必要です。';
	@override String get order => '並び順';
	@override String get correct_answer_rate => '正答率';
	@override String get correct_answer_rate_asc => '正答率が低い順';
	@override String get correct_answer_rate_desc => '正答率が高い順';
	@override String get incorrect_answers_count_desc => '不正解が多い順';
	@override String get incorrect_answers_count_asc => '不正解が少ない順';
	@override String get created_at_desc => '追加日が新しい順';
	@override String get created_at_asc => '追加日が古い順';
	@override String get random_random => 'ランダム';
	@override String get set_to_weakness => '問題を弱点に追加する';
	@override String get remove_from_weakness => '弱点から取り除く';
	@override String get weakness_condition => '追加条件';
	@override String weakness_condition_description({required Object number}) => '${number}回以上間違えた問題が自動で弱点に追加されます。';
	@override String get overcoming_condition => '克服条件';
	@override String overcoming_condition_description({required Object number}) => '正答率が${number}以上になると、自動で弱点から取り除かれます。';
	@override String get edit => '弱点設定を変更する';
	@override String get unsolved => '未正解';
	@override String get solved => '正解済';
	@override String get all => '全て';
	@override String added_at({required Object time_ago}) => '${time_ago}に追加';
	@override String incorrect_answers_count({required Object count}) => '不正解：${count}回';
	@override String get weakness_overcame => '弱点を克服しました。';
	@override String get new_lap => '弱点を新たに周回する';
	@override String get new_lap_description => '正解済の問題をすべて未正解に戻します。よろしいですか？';
	@override String get new_lap_started => 'すべての問題を未正解に戻しました。';
}

// Path: wordRequestComments
class _TranslationsWordRequestCommentsJa implements TranslationsWordRequestCommentsEn {
	_TranslationsWordRequestCommentsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get comment => 'コメント';
	@override String get comment_to_you => 'あなたへのコメント';
	@override String get comment_placeholder => 'コメントを入力してください';
	@override String get send => '送信する';
}

// Path: wordRequests
class _TranslationsWordRequestsJa implements TranslationsWordRequestsEn {
	_TranslationsWordRequestsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

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
	@override String get upvote => '賛成';
	@override String get downvote => '反対';
	@override String get editor_comment => '編集者のコメント';
	@override String get comments => 'コメント';
	@override String get cancel => 'リクエストを取り下げる';
	@override String get canceled => 'リクエストを取り下げました。';
	@override String get target => '編集先';
	@override String get target_already_deleted => '編集先がすでに削除されています。';
	@override String get target_not_found => '編集先が見つかりません。';
	@override String get show_heading => '編集内容';
	@override String get accepted => 'リクエストが採用されました。';
	@override String get rejected => 'リクエストが却下されました。';
	@override String get approved => 'リクエストに賛成しました。';
	@override String get disapproved => 'リクエストに反対しました。';
	@override String get vote_cancelled => 'リクエストへの投票を取り消しました。';
	@override String votes_count_to_close({required Object count}) => '決定に必要な得票数: ${count}';
	@override String edited_at({required Object time}) => '${time}前に編集';
	@override String get pending_reason => '審査理由';
	@override String get duplicating_entry => '同じ項目が既に存在しています。';
	@override String get changing_entry => '項目名が変更されようとしています。';
	@override String get pending_elimination => '項目が削除されようとしています。';
	@override String get pending_modification => '項目が修正されようとしています。';
	@override String get pending_addition => '項目が追加されようとしています。';
	@override String get unknown_reason => 'その他の理由';
	@override String get not_allowed_to_edit => '編集権限がありません。';
}

// Path: words
class _TranslationsWordsJa implements TranslationsWordsEn {
	_TranslationsWordsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get words => '項目';
	@override String get word => '項目';
	@override String get add => '項目を追加する';
	@override String get edit => '項目を編集する';
	@override String get created => '項目を作成しました。';
	@override String get create_failed => '項目の作成に失敗しました。';
	@override String get updated => '項目を更新しました。';
	@override String get update_failed => '項目の更新に失敗しました。';
	@override String get destroyed => '項目を削除しました。';
	@override String get entry => '見出し語';
	@override String get reading => '読み';
	@override String get pos_tag_id => '品詞';
	@override String get meaning => '意味';
	@override String get ipa => 'IPA（発音記号）';
	@override String get senses => '意味の詳細';
	@override String sense({required Object number}) => '意味(${number})';
	@override String get show_senses => '意味の詳細を表示する';
	@override String get search_sentence => '例文を検索する';
	@override String get search_sentence_placeholder => '例文に含まれるキーワードを入力してください';
	@override String get no_sentence => '例文が設定されていません。';
	@override String get set_sentence_with_ai => 'AIで例文を設定する';
	@override String get generate_meaning_with_ai => 'AIで意味を生成する';
	@override String get meaning_generation_keyword_placeholder => '【必須】意味を生成する見出し語を入力してください。';
	@override String get success_to_generate_meanings => '意味を生成しました。';
	@override String get failed_to_generate_meanings => '意味の生成に失敗しました。';
	@override String get generate_ipa_with_ai => 'AIで発音記号を生成する';
	@override String get ipa_generation_keyword_placeholder => '【必須】発音記号を生成する見出し語を入力してください。';
	@override String get regional_pronunciation => '地域ごとの発音を生成する';
	@override String get success_to_generate_ipa => '発音記号を生成しました。';
	@override String get failed_to_generate_ipa => '発音記号の生成に失敗しました。';
	@override String get etymologies => '語源';
	@override String get explanation => '解説';
	@override String get sentence => '例文';
	@override String get synonyms => '類義語';
	@override String get antonyms => '対義語';
	@override String get related => '関連語';
	@override String get detailed_settings => '詳細設定';
	@override String get comment => '編集者のコメント';
	@override String get comment_placeholder => 'コメントなどあればここに書いてください。';
	@override String get update => '修正する';
	@override String get diqt_markdown_support => 'ディクト記法対応';
	@override String get text_preview => 'プレビュー';
	@override String get there_is_no_text => 'テキストがありません。';
	@override String get undefined_lang_number => '言語が設定されていません。';
	@override String get diqt_notation => 'ディクト記法';
	@override String get destroy => '削除する';
	@override String get confirmation => '削除確認';
	@override String get edit_btn => '項目を編集する';
	@override String get new_btn => '項目を追加する';
	@override String get view_your_edit => '編集内容を見る';
	@override String get details => '詳細';
	@override String get not_found => '該当する単語はありません。';
	@override String get pos_tag_required => '品詞を設定してください。';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsJa {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'achievements.view_got_medals': return '獲得メダルを見る';
			case 'achievements.getting_medal': return '実績メダル獲得！！';
			case 'achievements.getting_medal_for': return ({required Object name}) => '${name}メダル獲得！！';
			case 'achievements.got_medals': return '獲得メダル';
			case 'achievements.receive_reward': return '報酬を受け取る';
			case 'achievements.praise_text': return ({required Object name}) => 'おめでとうございます！！${name}メダルを獲得しました！以下のボタンを押してメダル獲得報酬を受け取ってください！！';
			case 'achievements.tutorial_medal': return 'チュートリアルメダル';
			case 'achievements.tutorial_medal_introduction': return 'ディクトの基本的操作を達成することで手に入るメダルです。';
			case 'achievements.drill_clear_name': return '問題集クリア';
			case 'achievements.drill_clear_introduction': return '問題集を１周することで獲得できるメダルです。';
			case 'achievements.goal_achievement_name': return '目標達成';
			case 'achievements.goal_achievement_introduction': return '1日の目標を達成することで獲得できるメダルです。';
			case 'achievements.review_completion_name': return '復習達成';
			case 'achievements.review_completion_introduction': return '復習を達成することで獲得できるメダルです。';
			case 'achievements.continuous_answer_name': return '連続解答達成';
			case 'achievements.continuous_answer_introduction': return '2日連続で問題を解くことで獲得できるメダルです。';
			case 'achievements.continuous_goal_achievement_name': return '連続目標達成';
			case 'achievements.continuous_goal_achievement_introduction': return '2日連続で目標を達成することで獲得できるメダルです。';
			case 'achievements.continuous_review_completion_name': return '連続復習達成';
			case 'achievements.continuous_review_completion_introduction': return '2日連続で復習を達成することで獲得できるメダルです。';
			case 'achievements.following_name': return 'フォロー';
			case 'achievements.following_introduction': return '他のユーザーをフォローすることで獲得できるメダルです。';
			case 'achievements.cheering_name': return '応援';
			case 'achievements.cheering_introduction': return '他のユーザーを応援することで獲得できるメダルです。';
			case 'achievements.all_week_continuation_name': return '１週間連続解答';
			case 'achievements.all_week_continuation_introduction': return '１週間連続で問題を解くことで獲得できるメダルです。';
			case 'achievements.answers_medal': return '解答数メダル';
			case 'achievements.answers_medal_introduction': return '解答数に応じて獲得できるメダルです。';
			case 'achievements.answers_100_name': return '100問解答';
			case 'achievements.answers_100_introduction': return '100問解答することで獲得できるメダルです。';
			case 'achievements.answers_500_name': return '500問解答';
			case 'achievements.answers_500_introduction': return '500問解答することで獲得できるメダルです。';
			case 'achievements.answers_1000_name': return '1000問解答';
			case 'achievements.answers_1000_introduction': return '1000問解答することで獲得できるメダルです。';
			case 'achievements.answers_2000_name': return '2000問解答';
			case 'achievements.answers_2000_introduction': return '2000問解答することで獲得できるメダルです。';
			case 'achievements.answers_5000_name': return '5000問解答';
			case 'achievements.answers_5000_introduction': return '5000問解答することで獲得できるメダルです。';
			case 'achievements.answers_10000_name': return '10000問解答';
			case 'achievements.answers_10000_introduction': return '10000問解答することで獲得できるメダルです。';
			case 'achievements.answers_20000_name': return '20000問解答';
			case 'achievements.answers_20000_introduction': return '20000問解答することで獲得できるメダルです。';
			case 'achievements.answers_30000_name': return '30000問解答';
			case 'achievements.answers_30000_introduction': return '30000問解答することで獲得できるメダルです。';
			case 'achievements.answers_40000_name': return '40000問解答';
			case 'achievements.answers_40000_introduction': return '40000問解答することで獲得できるメダルです。';
			case 'achievements.answers_50000_name': return '50000問解答';
			case 'achievements.answers_50000_introduction': return '50000問解答することで獲得できるメダルです。';
			case 'achievements.answers_60000_name': return '60000問解答';
			case 'achievements.answers_60000_introduction': return '60000問解答することで獲得できるメダルです。';
			case 'achievements.answers_70000_name': return '70000問解答';
			case 'achievements.answers_70000_introduction': return '70000問解答することで獲得できるメダルです。';
			case 'achievements.answers_80000_name': return '80000問解答';
			case 'achievements.answers_80000_introduction': return '80000問解答することで獲得できるメダルです。';
			case 'achievements.answers_90000_name': return '90000問解答';
			case 'achievements.answers_90000_introduction': return '90000問解答することで獲得できるメダルです。';
			case 'achievements.answers_100000_name': return '100000問解答';
			case 'achievements.answers_100000_introduction': return '100000問解答することで獲得できるメダルです。';
			case 'achievements.answer_days_medal': return '解答日数メダル';
			case 'achievements.answer_days_medal_introduction': return '解答日数に応じて獲得できるメダルです。';
			case 'achievements.answer_days_2_name': return '2日連続解答';
			case 'achievements.answer_days_2_introduction': return '2日問題を解くことで獲得できるメダルです。';
			case 'achievements.answer_days_7_name': return '7日連続解答';
			case 'achievements.answer_days_7_introduction': return '7日問題を解くことで獲得できるメダルです。';
			case 'achievements.answer_days_14_name': return '14日連続解答';
			case 'achievements.answer_days_14_introduction': return '14日問題を解くことで獲得できるメダルです。';
			case 'achievements.answer_days_30_name': return '30日連続解答';
			case 'achievements.answer_days_30_introduction': return '30日問題を解くことで獲得できるメダルです。';
			case 'achievements.answer_days_60_name': return '60日連続解答';
			case 'achievements.answer_days_60_introduction': return '60日問題を解くことで獲得できるメダルです。';
			case 'achievements.answer_days_100_name': return '100日連続解答';
			case 'achievements.answer_days_100_introduction': return '100日問題を解くことで獲得できるメダルです。';
			case 'achievements.answer_days_200_name': return '200日連続解答';
			case 'achievements.answer_days_200_introduction': return '200日問題を解くことで獲得できるメダルです。';
			case 'achievements.answer_days_300_name': return '300日連続解答';
			case 'achievements.answer_days_300_introduction': return '300日問題を解くことで獲得できるメダルです。';
			case 'achievements.answer_days_365_name': return '365日連続解答';
			case 'achievements.answer_days_365_introduction': return '365日問題を解くことで獲得できるメダルです。';
			case 'achievements.master_medal': return 'マスターメダル';
			case 'achievements.master_medal_introduction': return '偉業を成し遂げたときに獲得できるメダルです。';
			case 'achievements.lv_100_name': return 'レベル100';
			case 'achievements.lv_100_introduction': return 'レベル100に到達することで獲得できるメダルです。';
			case 'achievements.rank_1_name': return 'ランク1位';
			case 'achievements.rank_1_introduction': return 'ランキングで1位になることで獲得できるメダルです。';
			case 'achievements.all_year_continuation_name': return '１年間連続解答';
			case 'achievements.all_year_continuation_introduction': return '１年間連続で問題を解くことで獲得できるメダルです。';
			case 'achievements.tutorial_completion_name': return 'チュートリアルクリア';
			case 'achievements.tutorial_completion_introduction': return 'チュートリアルメダルをコンプリートすることで獲得できるメダルです。';
			case 'achievements.answers_completion_name': return '解答数コンプリート';
			case 'achievements.answers_completion_introduction': return '解答数メダルをコンプリートすることで獲得できるメダルです。';
			case 'achievements.answer_days_completion_name': return '解答日数コンプリート';
			case 'achievements.answer_days_completion_introduction': return '解答日数メダルをコンプリートすることで獲得できるメダルです。';
			case 'activities.activities': return '活動';
			case 'activities.display': return '表示';
			case 'activities.all': return 'すべてユーザー';
			case 'activities.following': return 'フォロー中のユーザー';
			case 'activities.myself': return '自分';
			case 'activities.cheer': return '応援する';
			case 'activities.cheered': return '応援しました';
			case 'activities.answer_days': return ({required Object name, required Object number}) => '${name}が${number}日解答しました！';
			case 'activities.continuation_count': return ({required Object number}) => '${number}日連続で解答しました！';
			case 'activities.all_week_continuation_count': return ({required Object number}) => '${number}週間連続で解答しました！';
			case 'activities.all_month_continuation_count': return ({required Object number}) => '${number}ヶ月連続で解答しました！';
			case 'activities.all_year_continuation_count': return ({required Object number}) => '${number}年連続で解答しました！';
			case 'activities.goal_achievement': return ({required Object name, required Object number}) => '${name}が1日の目標（${number}問解答）を達成しました！';
			case 'activities.strict_goal_achievement': return ({required Object name, required Object number}) => '${name}が厳格解答モードで1日の目標（${number}問正解）を達成しました！';
			case 'activities.continuous_goal_achievement': return ({required Object number}) => '${number}日連続で目標を達成しました！';
			case 'activities.review_completion': return ({required Object name}) => '${name}が復習を達成しました！';
			case 'activities.strict_review_completion': return ({required Object name}) => '${name}が厳格復習モードで復習を達成しました！';
			case 'activities.continuous_review_completion': return ({required Object number}) => '${number}日連続で復習を達成しました！';
			case 'activities.drill_clear': return ({required Object name, required Object drill_title, required Object number}) => '${name}が「${drill_title}」を${number}周クリアしました！';
			case 'activities.strict_drill_clear': return ({required Object name, required Object drill_title, required Object number}) => '${name}が厳格解答モードで「${drill_title}」を${number}周クリアしました！';
			case 'activities.level_up': return ({required Object name, required Object number}) => '${name}がLv.${number}になりました！';
			case 'activities.achievement': return ({required Object name, required Object achievement_name}) => '${name}が${achievement_name}メダルを獲得しました！';
			case 'answer.limit_reached': return '制限に達しました';
			case 'answer.limit_reached_description': return ({required Object number}) => '無料ユーザーが解けるのは、１日に${number}問までです。プレミアム会員になって、無制限に問題を解きましょう！';
			case 'answer.daily_bonus': return ({required Object count}) => '${count}日解答';
			case 'answer.continuous_answers': return ({required Object count}) => '${count}日連続解答';
			case 'answer.continuous_goal_achievement': return ({required Object count}) => '${count}日連続目標達成';
			case 'answer.continuous_review_completion': return ({required Object count}) => '${count}日連続復習達成';
			case 'answer.goal_achievement': return '目標達成';
			case 'answer.review_completion': return '復習達成';
			case 'answer.strict_solving_mode': return '厳格解答モード';
			case 'answer.strict_reviewing_mode': return '厳格復習モード';
			case 'answer.weekly_bonus': return ({required Object count}) => '${count}週間連続解答';
			case 'answer.monthly_bonus': return ({required Object count}) => '${count}ヶ月連続解答';
			case 'answer.yearly_bonus': return ({required Object count}) => '${count}年連続解答';
			case 'answer.answers': return '問解答';
			case 'answer.answers_count': return ({required Object count}) => '${count}問解答';
			case 'answer.same_mistake_message': return ({required Object count}) => 'この間違いは${count}回目です';
			case 'answer.drill_clear': return 'ドリルクリア';
			case 'answer.drill_clear_description': return ({required Object laps_count}) => 'おめでとうございます！ドリルを全問解答しました！（${laps_count}）';
			case 'answer.strict_drill_clear_description': return ({required Object laps_count}) => 'おめでとうございます！ドリルを全問正解しました！（${laps_count}）';
			case 'answer.weakness_clear': return '弱点クリア';
			case 'answer.weakness_clear_description': return 'おめでとうございます！弱点を全問正解しました！';
			case 'answer.requesting_app_review': return 'これほどまでにご利用いただき、本当にありがとうございます！！ディクトは気に入っていただけましたでしょうか？';
			case 'answer.review_step_up': return ({required Object interval}) => '繰り上がりで${interval}に復習';
			case 'answer.review_released': return '復習が解除されました。';
			case 'answer.answers_on_normal_mode': return '解答数： ';
			case 'answer.answers_on_strict_solving_mode': return '正解数: ';
			case 'answer.view_explanation': return '解説を見る';
			case 'answer.level_up': return 'レベルアップ';
			case 'answer.level': return ({required Object level}) => 'Lv.${level}';
			case 'answerAnalyses.answer_analysis': return '解答分析';
			case 'answerAnalyses.answer_analyses': return '解答分析';
			case 'answerAnalyses.answer_histories': return '解答履歴';
			case 'answerAnalyses.premium_recommendation': return 'これらの機能を利用するには、プレミアムプランへの登録が必要です。';
			case 'answerAnalyses.order': return '表示';
			case 'answerAnalyses.correct_answer_rate_asc': return '正答率が低い順';
			case 'answerAnalyses.correct_answer_rate_desc': return '正答率が高い順';
			case 'answerAnalyses.incorrect_answer_histories_count_desc': return '間違いが多い順';
			case 'answerAnalyses.incorrect_answer_histories_count_asc': return '間違いが少ない順';
			case 'answerAnalyses.last_answered_at_desc': return '解答履歴：新しい順';
			case 'answerAnalyses.last_answered_at_asc': return '解答履歴：古い順';
			case 'answerAnalyses.analyze': return '分析する';
			case 'answerAnalyses.correct': return '正解';
			case 'answerAnalyses.incorrect': return '不正解';
			case 'answerAnalyses.last_record': return ({required Object time_ago, required Object result}) => '${time_ago}に${result}';
			case 'answerAnalyses.correct_at': return ({required Object time_ago}) => '${time_ago}に正解';
			case 'answerAnalyses.incorrect_at': return ({required Object time_ago}) => '${time_ago}に不正解';
			case 'answerAnalyses.correct_answer_rate': return '正答率';
			case 'answerAnalyses.not_yet_answered': return 'まだ解答したことがありません。';
			case 'answerAnalyses.answers_count': return ({required Object count}) => '${count}回解答';
			case 'answerAnalyses.correct_answers_count': return ({required Object count}) => '${count}回正解';
			case 'answerAnalyses.incorrect_answers_count': return ({required Object count}) => '${count}回不正解';
			case 'answerAnalyses.last_answer': return '最後の解答';
			case 'answerAnalyses.status': return '状態';
			case 'answerHistories.answer_histories': return '解答履歴';
			case 'answerHistories.todays_mistakes': return '今日間違えた問題';
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
			case 'cancellation.cancel_subscription': return '解約する';
			case 'cancellation.please_login': return 'ログインしてください';
			case 'cancellation.communication_error': return '通信エラーが発生しました。';
			case 'cancellation.confirm_cancellation': return '解約の確認';
			case 'cancellation.user_name_suffix': return ({required Object user}) => '${user}さま';
			case 'cancellation.premium_thanks': return 'これまでDiQtのプレミアムプランをご利用いただき、誠にありがとうございました...!';
			case 'cancellation.apology_message': return 'そして、今回ご期待に沿えなかったこと、大変申し訳なく思います....。';
			case 'cancellation.feedback_request': return ({required Object user}) => 'よろしければ、ぜひ今後のサービス改善のために、${user}さまがこの度プランをご解約されるにいたった理由を教えていただけないでしょうか...？';
			case 'cancellation.apology_for_trouble': return 'お手数をおかけして大変申し訳ございません...!';
			case 'cancellation.honest_feedback_request': return 'なにとぞ率直なご感想を、どうかよろしくお願いいたします...！！🙇‍♂️';
			case 'cancellation.cancellation_reason_title': return '解約理由';
			case 'cancellation.cancellation_reason_request': return '解約に至った理由を教えてください...!🙇‍♂️';
			case 'cancellation.cancellation_reason_required': return '解約理由は空欄にできません。';
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
			case 'chapters.external_reference_link': return '外部参照リンク';
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
			case 'dictionaries.keyword': return '検索内容';
			case 'dictionaries.word_segmentation': return '単語に分割する';
			case 'dictionaries.search_results': return '検索結果';
			case 'dictionaries.search_results_of': return ({required Object query}) => '『${query}』の検索結果';
			case 'dictionaries.entry_not_found': return ({required Object query}) => '"${query}"は辞書に登録されていません。';
			case 'dictionaries.keyword_not_found': return '検索内容は辞書に登録されていません。';
			case 'dictionaries.search_by_web': return 'Webで検索する';
			case 'dictionaries.search_by_another': return ({required Object name}) => '${name}で検索する';
			case 'dictionaries.edit_by_web': return 'Webで編集する';
			case 'dictionaries.add_keyword_to_dictionary': return ({required Object keyword}) => '"${keyword}"を辞書に追加する';
			case 'dictionaries.add_by_web': return 'Webで追加する';
			case 'dictionaries.register_keyword': return '検索内容を辞書に登録する';
			case 'dictionaries.open_by_web': return 'Webで開く';
			case 'dictionaries.no_permission': return '権限がありません。';
			case 'dictionaries.no_addition_permission': return '追加する権限がありません。';
			case 'dictionaries.no_modification_permission': return '修正する権限がありません。';
			case 'dictionaries.no_elimination_permission': return '削除する権限がありません。';
			case 'dictionaryMaps.please_select': return '辞書を選択してください';
			case 'dictionaryMaps.not_selected': return '辞書が選択されていません';
			case 'dictionaryMaps.enter': return ({required Object language}) => '${language}を入力してください';
			case 'dictionaryMaps.set_dictionaries': return '辞書を設定する';
			case 'dictionaryMaps.add_dictionaries': return '辞書を追加する';
			case 'dictionaryMaps.remove_dictionaries': return '辞書を削除する';
			case 'dictionaryMaps.select_dictionaries_to_use': return '追加する辞書を選択してください';
			case 'dictionaryMaps.add': return '追加する';
			case 'dictionaryMaps.select_dictionaries_to_remove': return '削除する辞書を選択してください';
			case 'dictionaryMaps.remove': return '削除する';
			case 'dictionaryMaps.set': return '設定する';
			case 'dictionaryMaps.update_success': return 'My辞書を設定しました。';
			case 'dictionaryMaps.update_failed': return 'My辞書が設定できませんでした。';
			case 'dictionaryMaps.search_menu': return '検索メニュー';
			case 'dictionaryMaps.search_by_speech': return '音声で検索する';
			case 'dictionaryMaps.start_speech_recognition': return '開始する';
			case 'dictionaryMaps.stop_speech_recognition': return '完了';
			case 'dictionaryMaps.search_by_image': return '画像で検索する';
			case 'dictionaryMaps.image_for_ocr': return '文字を読み込む画像';
			case 'dictionaryMaps.upload': return 'アップロードする';
			case 'drillLaps.resume': return '続きから';
			case 'drillLaps.view_more': return 'もっと見る';
			case 'drills.drills': return 'ドリル';
			case 'drills.private_drill': return 'このドリルは非公開です';
			case 'drills.answers': return ({required Object number}) => '${number}解答';
			case 'drills.laps_count': return ({required Object number}) => '${number}週目';
			case 'drills.clears_count': return ({required Object number}) => '${number}周クリア';
			case 'drills.unsolved': return '未解答';
			case 'drills.solved': return '解答済';
			case 'drills.all': return 'すべて';
			case 'drills.search': return '問題を検索する';
			case 'drills.pending_requests': return '審査中の編集';
			case 'drills.accepted_requests': return '承認済の編集';
			case 'drills.rejected_requests': return '拒否済の編集';
			case 'drills.create_drill': return 'ドリルを作成する';
			case 'drills.create_drill_with_csv': return 'ドリルをCSVで作成する';
			case 'drills.edit_drill': return 'ドリルを編集する';
			case 'drills.edit_drill_with_csv': return 'CSVでドリルを編集する';
			case 'drills.csv_blank': return 'CSVファイルを添付してください。';
			case 'drills.please_wait': return '作成を開始しました。10秒ほどで出来上がります。';
			case 'drills.title_placeholder': return '【必須】ドリルのタイトルを入力してください。';
			case 'drills.introduction': return '紹介';
			case 'drills.over_item_limit': return '100問を超える場合、問題の編集はこちらから行ってください。';
			case 'drills.order': return '並び順';
			case 'drills.created_at_asc': return '最初から';
			case 'drills.created_at_desc': return '最後から';
			case 'drills.random_random': return 'ランダム';
			case 'drills.edit_setting': return 'Edit settings for quizzes';
			case 'drills.owner': return '作成者';
			case 'drills.following_users': return 'フォロー中のユーザー';
			case 'drills.followed_users': return 'フォロワー';
			case 'drills.users': return 'ユーザー';
			case 'drills.settings': return '設定';
			case 'drills.edit_tags': return 'タグを編集する';
			case 'drills.open': return '開く';
			case 'drills.new_lap': return '新たに周回する';
			case 'drills.new_lap_description': return 'すべての問題を未解答に戻します。よろしいですか？';
			case 'drills.new_lap_started': return 'すべての問題を未解答に戻し、新たな周回を始めました。';
			case 'drills.require_login': return '問題を解くにはログインが必要です。';
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
			case 'experiencePoints.to_the_next_level': return ({required Object points}) => '次のレベルまであと${points}EXP';
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
			case 'inquiries.inquiry': return 'お問い合わせ';
			case 'inquiries.inquireis': return 'お問い合わせ';
			case 'inquiries.content': return 'お問い合わせ内容';
			case 'inquiries.contact_form': return 'お問い合わせフォーム';
			case 'inquiries.contact_form_placeholder': return 'ディクトについて疑問点やご質問などございましたら、なんでもお気軽にご記入ください。必要に応じて、後日メールにてご返信させていただく場合もございます。';
			case 'inquiries.contact_description': return ({required Object name}) => '${name}へは、お気軽に以下からご連絡ください。';
			case 'inquiries.inquiry_sent': return 'お問い合わせを送信しました。必要に応じて、後日メールにてご返信させていただく場合もございます。';
			case 'inquiries.sending_inquiry_failed': return 'お問い合わせの送信に失敗しました。';
			case 'lang.google_translation': return 'Google翻訳';
			case 'lang.deepl_translation': return 'DeepL翻訳';
			case 'lang.translating': return '翻訳中...';
			case 'lang.done': return '完了';
			case 'lang.translation_failed': return '翻訳できませんでした。';
			case 'lang.translation_restricted': return ({required Object number}) => '無料ユーザーが1日に翻訳できる回数は、${number}件までです。';
			case 'lang.ai_searches_restricted': return ({required Object number}) => '無料ユーザーが１日にAIに聞ける数は、${number}件までです。';
			case 'lang.deepl_not_supported': return ({required Object language}) => '${language}はDeepLが対応していない言語です。';
			case 'lang.google_not_supported': return ({required Object language}) => '${language}はGoogleが対応していない言語です。';
			case 'lang.need_to_login': return '翻訳機能を利用するにはログインが必要です。';
			case 'lang.ask_ai': return 'AIに聞く';
			case 'lang.explain_meaning': return '意味を教えてください';
			case 'lang.explain_usage': return '用法を教えてください';
			case 'lang.explain_example': return '用例を教えてください';
			case 'lang.explain_synonym': return '類義語を教えてください';
			case 'lang.explain_antonym': return '反意語を教えてください';
			case 'lang.explain_conjugation': return '活用形を教えてください';
			case 'lang.explain_etymology': return '語源を教えてください';
			case 'lang.explain_grammar': return '文中の文法や構文を解説してください';
			case 'lang.proofread_sentence': return '文章を校正してください';
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
			case 'lang.zh_Hans': return '中国語（簡体）';
			case 'lang.zh': return '中国語';
			case 'lang.zh_TW': return '中国語（繁体）';
			case 'lang.zh_Hant': return '中国語（繁体）';
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
			case 'lang.nb': return 'ノルウェー語（ブークモール）';
			case 'lang.no': return 'ノルウェー語';
			case 'lang.ny': return 'ニャンジャ語（チェワ語）';
			case 'lang.or': return 'オリヤ語';
			case 'lang.ps': return 'パシュト語';
			case 'lang.fa': return 'ペルシャ語';
			case 'lang.pl': return 'ポーランド語';
			case 'lang.prs': return 'ダリー語';
			case 'lang.pt': return 'ポルトガル語（ポルトガル、ブラジル）';
			case 'lang.pa': return 'パンジャブ語';
			case 'lang.ro': return 'ルーマニア語';
			case 'lang.ru': return 'ロシア語';
			case 'lang.sm': return 'サモア語';
			case 'lang.gd': return 'スコットランド ゲール語';
			case 'lang.sr': return 'セルビア語';
			case 'lang.sr_Cryl': return 'セルビア語（キリル）';
			case 'lang.sr_Latn': return 'セルビア語（ラテン）';
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
			case 'layouts.other_apps': return 'ディクトをもっと便利にする方法！';
			case 'layouts.other_apps_description': return 'ディクトは、アプリだけでなく、ブラウザ拡張機能や、Webサイトも提供しています。これらを併用することで、より便利に、より効率的に語彙を覚えられるようになります。';
			case 'layouts.chrome_extension': return 'Google Chrome拡張機能';
			case 'layouts.chrome_extension_description': return 'Google Chrome拡張機能をインストールすると、Webページ上の単語をクリックするだけで、単語に復習を設定できるようになります。';
			case 'layouts.free': return '無料';
			case 'layouts.app_store_url': return 'https://apps.apple.com/jp/app/diqt/id1594559036?uo=4';
			case 'layouts.play_store_url': return 'https://play.google.com/store/apps/details?id=com.booqs.booqs_mobile&hl=ja';
			case 'layouts.chrome_web_store_url': return 'https://chrome.google.com/webstore/detail/booqs-dictionary/khgjdchimekphdebkmcknjkphkbpbpkj?hl=ja&authuser=0';
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
			case 'notes.timestamp_info': return ({required Object updatedAtTimeAgo, required Object createdAtTimeAgo}) => '更新：${updatedAtTimeAgo} / 作成：${createdAtTimeAgo}';
			case 'notices.notifications': return '通知';
			case 'notices.cheered_message': return ({required Object name}) => '${name}があなたを応援しました！';
			case 'notices.followed_message': return ({required Object name}) => '${name}があなたをフォローしました！';
			case 'notices.word_request_accepted_message': return 'あなたの辞書の編集が採用されました！';
			case 'notices.word_request_commented_message': return 'あなたの辞書の編集にコメントがつきました！';
			case 'notices.word_request_upvoted_message': return ({required Object name}) => '${name}があなたの辞書の編集に賛成しました！';
			case 'notices.sentence_request_accepted_message': return 'あなたの例文の編集が採用されました！';
			case 'notices.sentence_request_commented_message': return 'あなたの例文の編集にコメントがつきました！';
			case 'notices.sentence_request_upvoted_message': return ({required Object name}) => '${name}があなたの例文の編集に賛成しました！';
			case 'notices.quiz_request_accepted_message': return 'あなたの問題の編集が採用されました！';
			case 'notices.quiz_request_commented_message': return 'あなたの問題の編集にコメントがつきました！';
			case 'notices.quiz_request_upvoted_message': return ({required Object name}) => '${name}があなたの問題の編集に賛成しました！';
			case 'notices.reply': return '返信する';
			case 'notices.achievement_acquired_message': return ({required Object name}) => '${name}メダルを獲得しました！';
			case 'notices.monthly_date_format': return 'yyyy年MM月';
			case 'notices.monthly_report': return '【月報】';
			case 'notices.monthly_ranking': return '月間ランキング';
			case 'notices.weekly_first_date_format': return 'yyyy年MM月dd日';
			case 'notices.weekly_last_date_format': return 'MM月dd日';
			case 'notices.weekly_report': return '【週報】';
			case 'notices.weekly_ranking': return '週間ランキング';
			case 'notices.ranking_position': return ({required Object rank}) => '${rank}位';
			case 'notices.answers_count': return '解答数';
			case 'notices.answer_times': return ({required Object count}) => '${count}回';
			case 'purchase.premium_plan': return 'プレミアムプラン';
			case 'purchase.premium_plan_description': return 'DiQtのすべての機能が使い放題になるプランです。';
			case 'purchase.trial_period_description': return '今なら７日間の無料体験期間つき！';
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
			case 'purchase.unlimited_answers_description': return ({required Object number}) => '無料ユーザーが1日に解答できる問題の数は${number}問ですが、プレミアム会員になれば、1日に何問でも解答できるようになります。';
			case 'purchase.unlimited_translations': return '無制限の翻訳';
			case 'purchase.unlimited_translations_description': return ({required Object number}) => '無料ユーザーが1日に翻訳できる回数は${number}回ですが、プレミアム会員になれば、1日に何回でも翻訳できるようになります。';
			case 'purchase.unlimited_ai_searches': return '無制限のAI機能';
			case 'purchase.unlimited_ai_searches_description': return ({required Object number}) => '無料ユーザーが１日にAIに聞ける数は${number}回ですが、プレミアム会員になれば、1日に何回でもAIに聞けるようになります。';
			case 'purchase.weakness_description': return 'プレミアム会員になれば、正答率が低い問題を重点的に学習できるようになります。';
			case 'purchase.note_description': return 'プレミアム会員になれば、解いた問題にメモを残すことができるようになります。';
			case 'purchase.answer_analysis_description': return 'プレミアム会員になれば、正答率や間違えた回数で解いた問題を分析できるようになります。';
			case 'purchase.answer_history_description': return 'プレミアム会員になれば、解答した問題の履歴を閲覧できるようになります。';
			case 'purchase.questions_you_got_wrong_description': return 'プレミアム会員になれば、その日に間違えた問題を確認できるようになります。';
			case 'purchase.deletion_of_all_reviews_description': return 'プレミアム会員になれば、今までに設定した復習をすべて取り消すことができるようになります。';
			case 'purchase.ad_free_description': return 'プレミアム会員になれば、アプリ内のすべての広告が表示されなくなります。';
			case 'purchase.restore': return '以前に購入された方はこちら';
			case 'purchase.restore_success': return '購入が復元されました。';
			case 'purchase.restore_error': return '購入の復元に失敗しました。';
			case 'purchase.footer_description': return '・プレミアム契約期間は開始日から起算して1ヶ月ごとの自動更新となります。\n ・２週間の無料お試し期間が終了すると、最初のお支払いが始まります。\n ・プレミアム契約期間の終了日の24時間以上前に解約しない限り契約期間が『自動更新』されます。\n ・以下をご確認の上、ご登録ください。\n';
			case 'purchase.monthly_premium_plan': return '月額プレミアムプラン';
			case 'purchase.annual_premium_plan': return '年額プレミアムプラン';
			case 'purchase.price': return '価格';
			case 'purchase.no_label': return ({required Object label}) => '${label}: なし';
			case 'purchase.auto_renewal': return '自動更新';
			case 'purchase.trial_period': return '無料お試し期間中';
			case 'purchase.subscription_store': return '契約ストア';
			case 'purchase.cancellation_date': return ({required Object date}) => '${date}に解約されます';
			case 'purchase.subscription_cancelled': return '解約済';
			case 'purchase.renewal_date': return '契約更新日';
			case 'purchase.expiry_date': return '有効期限日';
			case 'purchase.no_contract': return 'ご契約プランがありません';
			case 'purchase.subscribed_via_web': return 'Webで契約しています';
			case 'quizRequests.quiz_requests': return '問題の編集履歴';
			case 'quizRequests.edit_histories': return '編集履歴';
			case 'quizRequests.pending_edits': return '審査中の編集';
			case 'quizRequests.edit_applied': return '編集が適応されました。';
			case 'quizRequests.addition_request_submitted': return '追加リクエストが申請されました。';
			case 'quizRequests.modification_request_submitted': return '修正リクエストが申請されました。';
			case 'quizRequests.elimination_request_submitted': return '削除リクエストが申請されました。';
			case 'quizRequests.addition': return '問題の追加';
			case 'quizRequests.modification': return '問題の修正';
			case 'quizRequests.elimination': return '問題の削除';
			case 'quizRequests.acceptance': return '採用済';
			case 'quizRequests.rejection': return '却下済';
			case 'quizRequests.pending': return '審査中';
			case 'quizzes.quiz': return '問題';
			case 'quizzes.quizzes': return '問題';
			case 'quizzes.add': return '問題を追加する';
			case 'quizzes.edit': return '問題を編集する';
			case 'quizzes.answer': return '解答する';
			case 'quizzes.see_correct_answer': return '正解を見る';
			case 'quizzes.correct': return '正解';
			case 'quizzes.wrong': return '不正解';
			case 'quizzes.got_a_correct': return '正解した';
			case 'quizzes.made_a_mistake': return '間違えた';
			case 'quizzes.question': return '問題文';
			case 'quizzes.question_placeholder': return '【必須】問題文を入力してください。';
			case 'quizzes.lang_number_of_question': return '問題の言語';
			case 'quizzes.reading_out_question': return '問題の読み上げ';
			case 'quizzes.question_hidden': return '問題文の非表示';
			case 'quizzes.question_preview': return '問題のプレビュー';
			case 'quizzes.show_preview': return 'プレビューを見る';
			case 'quizzes.correct_answer': return '正解';
			case 'quizzes.correct_answer_placeholder': return '【必須】正解を入力してください。';
			case 'quizzes.lang_number_of_answer': return '答えの言語';
			case 'quizzes.reading_out_answer': return '答えの読み上げ';
			case 'quizzes.short_answer_enabled': return '答えを入力式にする';
			case 'quizzes.distractors': return '誤りの選択肢';
			case 'quizzes.distractor': return '誤りの選択肢';
			case 'quizzes.distractors_placeholder': return '【空欄可】誤りの選択肢を設定できます。';
			case 'quizzes.generate_distractors': return '誤りの選択肢を自動生成する';
			case 'quizzes.distractors_generated': return '誤りの選択肢を自動生成しました。';
			case 'quizzes.distractors_generation_failed': return '誤りの選択肢を自動生成できませんでした。';
			case 'quizzes.explanation': return '解説';
			case 'quizzes.explanation_placeholder': return '【空欄可】解説を設定できます。';
			case 'quizzes.hint': return 'ヒント';
			case 'quizzes.hint_placeholder': return '【空欄可】ヒントを設定できます。';
			case 'quizzes.source_word': return '元となった辞書の項目';
			case 'quizzes.source_sentence': return '元となった例文';
			case 'quizzes.corrected_time_ago': return ({required Object time}) => '${time}前に正解';
			case 'quizzes.incorrect_time_ago': return ({required Object time}) => '${time}前に不正解';
			case 'quizzes.correct_answer_rate': return ({required Object percent}) => '正答率${percent}%';
			case 'quizzes.question_cover_text': return '問題文を表示する';
			case 'quizzes.choices_cover_text': return '選択肢を表示する';
			case 'quizzes.choices_cover_keys': return 'タップまたはEnterキー';
			case 'quizzes.please_input_answer': return '解答を入力してください。';
			case 'quizzes.modified': return '問題を修正しました。';
			case 'quizzes.word_quiz_edit_prevention': return 'この問題は辞書の情報に基づいているため、変更するには辞書の項目の編集が必要です。';
			case 'quizzes.sentence_quiz_edit_prevention': return 'この問題は例文の情報に基づいているため、変更するには例文の編集が必要です。';
			case 'quizzes.do_not_know': return 'わからない';
			case 'ranking.ranking': return 'ランキング';
			case 'ranking.daily': return '日間';
			case 'ranking.weekly': return '週間';
			case 'ranking.monthly': return '月間';
			case 'ranking.daily_answerer': return '日間解答者ランキング';
			case 'ranking.weekly_answerer': return '週間解答者ランキング';
			case 'ranking.monthly_answerer': return '月間解答者ランキング';
			case 'ranking.rank': return ({required Object number}) => '第${number}位';
			case 'ranking.user_ranking': return ({required Object rank, required Object name}) => '${rank}位: ${name}';
			case 'ranking.daily_answer_count': return ({required Object count}) => '解答数: ${count}';
			case 'ranking.weekly_answer_count': return ({required Object count}) => '週間解答数: ${count}';
			case 'ranking.monthly_answer_count': return ({required Object count}) => '月間解答数: ${count}';
			case 'reviews.reviews': return '復習';
			case 'reviews.unreviewed': return '未復習';
			case 'reviews.scheduled': return '予定';
			case 'reviews.all': return 'すべて';
			case 'reviews.order': return '順番';
			case 'reviews.random_random': return 'ランダム';
			case 'reviews.scheduled_date_desc': return '予定日が遠い順';
			case 'reviews.scheduled_date_asc': return '予定日が近い順';
			case 'reviews.empty': return '復習問題はありません。';
			case 'reviews.memorize': return '覚える';
			case 'reviews.word_label': return '意味を覚える';
			case 'reviews.reversed_word_label': return '単語を覚える';
			case 'reviews.sentence_label': return '読めるようになる';
			case 'reviews.reversed_sentence_label': return '話せるようになる';
			case 'reviews.listening_sentence_label': return '聞き取れるようになる';
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
			case 'reviews.scheduled_at': return ({required Object scheduled_date}) => '${scheduled_date}に復習予定';
			case 'reviews.delete_all_reviews_completed': return '復習を全て削除しました。';
			case 'reviews.cancel': return 'キャンセル';
			case 'reviews.confirm_deletion': return '削除確認';
			case 'reviews.execute': return '実行する';
			case 'reviews.delete_all_reviews_confirmation': return '全ての復習を削除いたします。この操作は取り消せません。実行してもよろしいですか？';
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
			case 'senses.senses': return '意味の詳細';
			case 'senses.sense': return '意味';
			case 'senses.gloss': return '意味';
			case 'senses.add': return '意味を追加する';
			case 'senses.show_preview': return 'プレビューを見る';
			case 'senses.meaning_preview': return '意味のプレビュー';
			case 'senses.destroy': return '削除する';
			case 'senses.confirm_destroy': return '削除確認';
			case 'senses.confirm_destroy_message': return 'この意味の削除申請を行います。よろしいですか？';
			case 'sentenceRequests.sentence_requests': return '例文の編集履歴';
			case 'sentenceRequests.edit_histories': return '編集履歴';
			case 'sentenceRequests.pending_edits': return '審査中の編集';
			case 'sentenceRequests.rejected_edits': return '拒否された編集';
			case 'sentenceRequests.edit_applied': return '編集が適応されました。';
			case 'sentenceRequests.addition_request_submitted': return '追加リクエストが申請されました。';
			case 'sentenceRequests.modification_request_submitted': return '修正リクエストが申請されました。';
			case 'sentenceRequests.elimination_request_submitted': return '削除リクエストが申請されました。';
			case 'sentenceRequests.already_submitted': return '編集リクエストをすでに申請済みです。';
			case 'sentenceRequests.addition': return '例文の追加';
			case 'sentenceRequests.modification': return '例文の修正';
			case 'sentenceRequests.elimination': return '例文の削除';
			case 'sentenceRequests.acceptance': return '採用済';
			case 'sentenceRequests.rejection': return '却下済';
			case 'sentenceRequests.pending': return '審査中';
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
			case 'sentences.explanation': return '解説';
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
			case 'sessions.okay': return 'OK';
			case 'sessions.continue_with_apple': return 'Appleで続ける';
			case 'sessions.continue_with_google': return 'Googleで続ける';
			case 'sessions.continue_with_twitter': return 'Twitterで続ける';
			case 'sessions.confirm_web_diqt': return 'Web版DiQtに移動します。よろしいですか？';
			case 'sessions.external_link': return '外部リンク';
			case 'sessions.log_out': return 'ログアウトする';
			case 'sessions.log_out_succeeded': return 'ログアウトしました。';
			case 'shared.create': return '作成する';
			case 'shared.create_succeeded': return '作成されました。';
			case 'shared.create_failed': return '作成に失敗しました。';
			case 'shared.edit': return '編集する';
			case 'shared.update': return '更新する';
			case 'shared.update_succeeded': return '更新されました。';
			case 'shared.update_failed': return '更新に失敗しました。';
			case 'shared.return_confirmation': return '確認';
			case 'shared.return_confirmation_description': return '編集を破棄して戻ります。よろしいですか？';
			case 'shared.destroy': return '削除する';
			case 'shared.destroy_confirmation': return '削除の確認';
			case 'shared.destroy_confirmation_description': return '本当に削除してもよろしいですか？';
			case 'shared.destroy_comment': return '削除する理由';
			case 'shared.destroy_comment_placeholder': return '削除する理由を入力してください。';
			case 'shared.destroy_succeeded': return '削除しました。';
			case 'shared.cancel': return 'キャンセルする';
			case 'shared.ok': return 'OK';
			case 'shared.yes': return 'はい';
			case 'shared.no': return 'いいえ';
			case 'shared.reload': return '再読み込みする';
			case 'shared.search': return '検索する';
			case 'shared.generate': return '生成する';
			case 'shared.send': return '送信する';
			case 'shared.set_up': return '設定する';
			case 'shared.share': return 'シェアする';
			case 'shared.close': return '閉じる';
			case 'shared.undefined': return '未定義';
			case 'shared.details': return '詳細';
			case 'shared.view_details': return '詳細を見る';
			case 'shared.view_more': return 'もっと見る';
			case 'shared.please_enter': return ({required Object name}) => '"${name}"を入力してください。';
			case 'shared.no_more_items': return ({required Object name}) => 'すべての${name}を読み込みました';
			case 'shared.no_items_found': return ({required Object name}) => '${name}がありません';
			case 'shared.no_name_found': return ({required Object name}) => '${name}が見つかりません';
			case 'shared.no_item_found': return 'アイテムがありません';
			case 'shared.premium_recommendation': return 'この機能を利用するには、プレミアムプランへの登録が必要です。';
			case 'shared.login_recommendation': return 'この機能を利用するためには、ログインが必要です。';
			case 'shared.processing': return '処理中...';
			case 'shared.done': return '完了';
			case 'shared.download': return 'ダウンロード';
			case 'shared.diqt_markdown': return 'ディクト記法';
			case 'shared.diqt_markdown_supported': return 'ディクト記法対応';
			case 'shared.required': return '必須';
			case 'shared.dictionary_setting': return '辞書設定';
			case 'shared.thumbnail': return 'サムネイル';
			case 'shared.remove_thumbnail': return 'サムネイルを削除する';
			case 'shared.image_alt': return ({required Object name}) => '${name}の画像';
			case 'shared.error_occurred': return 'エラーが発生しました。';
			case 'shared.fix_error': return 'エラーを修正する';
			case 'shared.error_fixed': return 'エラーを修正しました。';
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
			case 'users.users': return 'ユーザー';
			case 'users.user': return 'ユーザー';
			case 'users.anonymous_user': return '匿名ユーザー';
			case 'users.deleted_user': return '退会ユーザー';
			case 'users.creating_account_succeeded': return '会員登録が完了しました！ようこそDiQtへ！！';
			case 'users.show': return 'ユーザーページ';
			case 'users.menu': return 'メニュー';
			case 'users.find_users': return 'ユーザーを探す';
			case 'users.search': return '検索する';
			case 'users.enter_keyword': return 'キーワードを入力してください';
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
			case 'users.time_zone_description': return 'タイムゾーンを設定することで、時差の問題を解決し、復習通知などをより正確な時刻で受け取れるようになります。';
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
			case 'users.follow': return 'フォローする';
			case 'users.following': return 'フォロー中';
			case 'users.resume': return '続きから';
			case 'users.status': return 'ステータス';
			case 'users.please_set_password': return 'パスワードを設定してください。';
			case 'users.please_set_email': return 'メールアドレスを設定してください。';
			case 'users.please_activate_email': return 'メールアドレスのご本人確認を行ってください。';
			case 'users.already_activated': return 'すでにご本人確認済みです。';
			case 'users.activation': return 'ご本人様確認';
			case 'users.activation_cta_text': return '以下のボタンを押して、ご本人確認メールを送信してください。そして、メールの中のボタンをクリックしてください。';
			case 'users.activation_description': return 'これは登録したメールアドレスがあなた自身のものであることを確認するためのもので、なりすましの防止など、セキュリティのために重要な操作です。またメールアドレスのご本人確認を行うことによって、パスワードを忘れてしまった場合のパスワードリセット機能などがご利用いただけるようになります。残念ながら、たびたび、ご本人確認を行わずにログアウトしてしまい、パスワードを忘れてしまってログインできないというお問い合わせをいただきます（もちろん、その場合もご対応いたします）。';
			case 'users.send_activation_email': return '本人確認メールを送信する';
			case 'users.activation_email_resent': return 'ご本人確認メールを送信しました。メールのリンクをクリックして、ご本人確認を完了してください。';
			case 'users.activated': return 'ご本人確認が完了しました。';
			case 'users.activation_failed': return '無効なリンクです。ご本人確認できませんでした。';
			case 'users.email_change': return 'メールアドレス変更';
			case 'users.email_change_cta_text': return '新しいメールアドレスを設定し、以下のボタンを押して、メールアドレス変更メールを送信してください。そして、メールの中のボタンをクリックしてください。';
			case 'users.change_email': return 'メールアドレスを変更する';
			case 'users.new_email': return '新しいメールアドレス';
			case 'users.already_taken': return 'このメールアドレスはすでに使用されています。';
			case 'users.email_change_email_resent': return 'メールアドレス変更メールを送信しました。メールのリンクをクリックして、メールアドレス変更を完了してください。';
			case 'users.email_changed': return 'メールアドレスを変更しました。';
			case 'users.expired': return '有効期限が切れています。';
			case 'users.accumulated_experience': return '累積経験値';
			case 'users.total_answers_count': return '総合解答数';
			case 'users.total_answer_days_count': return '総合解答日数';
			case 'users.todays_answers_count': return '今日の解答数';
			case 'users.weekly_answers_count': return '今週の解答数';
			case 'users.monthly_answers_count': return '今月の解答数';
			case 'users.answers_count': return ({required Object count}) => '${count}解答';
			case 'users.answer_days_count': return ({required Object count}) => '${count}日';
			case 'users.exp_for_next_level': return ({required Object exp}) => '次のレベルまであと${exp}EXP';
			case 'users.continuous_answer_days_count': return ({required Object count}) => '${count}日連続解答中！';
			case 'users.continuous_goal_achievement_count': return ({required Object count}) => '${count}日連続目標達成中！';
			case 'users.continuous_review_completion_count': return ({required Object count}) => '${count}日連続復習達成中！';
			case 'users.language_settings': return '言語設定';
			case 'users.invite': return '友達を招待する';
			case 'users.invitation_message': return ({required Object name}) => '${name}さんがあなたをDiQtに招待しました！✨\n新しい言語の世界へ飛び込もう！';
			case 'weaknesses.weakness': return '弱点問題';
			case 'weaknesses.weaknesses': return '弱点問題';
			case 'weaknesses.quizzes_count': return ({required Object count}) => '${count}問';
			case 'weaknesses.premium_recommendation': return '弱点問題を解くには、プレミアムプランへの登録が必要です。';
			case 'weaknesses.order': return '並び順';
			case 'weaknesses.correct_answer_rate': return '正答率';
			case 'weaknesses.correct_answer_rate_asc': return '正答率が低い順';
			case 'weaknesses.correct_answer_rate_desc': return '正答率が高い順';
			case 'weaknesses.incorrect_answers_count_desc': return '不正解が多い順';
			case 'weaknesses.incorrect_answers_count_asc': return '不正解が少ない順';
			case 'weaknesses.created_at_desc': return '追加日が新しい順';
			case 'weaknesses.created_at_asc': return '追加日が古い順';
			case 'weaknesses.random_random': return 'ランダム';
			case 'weaknesses.set_to_weakness': return '問題を弱点に追加する';
			case 'weaknesses.remove_from_weakness': return '弱点から取り除く';
			case 'weaknesses.weakness_condition': return '追加条件';
			case 'weaknesses.weakness_condition_description': return ({required Object number}) => '${number}回以上間違えた問題が自動で弱点に追加されます。';
			case 'weaknesses.overcoming_condition': return '克服条件';
			case 'weaknesses.overcoming_condition_description': return ({required Object number}) => '正答率が${number}以上になると、自動で弱点から取り除かれます。';
			case 'weaknesses.edit': return '弱点設定を変更する';
			case 'weaknesses.unsolved': return '未正解';
			case 'weaknesses.solved': return '正解済';
			case 'weaknesses.all': return '全て';
			case 'weaknesses.added_at': return ({required Object time_ago}) => '${time_ago}に追加';
			case 'weaknesses.incorrect_answers_count': return ({required Object count}) => '不正解：${count}回';
			case 'weaknesses.weakness_overcame': return '弱点を克服しました。';
			case 'weaknesses.new_lap': return '弱点を新たに周回する';
			case 'weaknesses.new_lap_description': return '正解済の問題をすべて未正解に戻します。よろしいですか？';
			case 'weaknesses.new_lap_started': return 'すべての問題を未正解に戻しました。';
			case 'wordRequestComments.comment': return 'コメント';
			case 'wordRequestComments.comment_to_you': return 'あなたへのコメント';
			case 'wordRequestComments.comment_placeholder': return 'コメントを入力してください';
			case 'wordRequestComments.send': return '送信する';
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
			case 'wordRequests.upvote': return '賛成';
			case 'wordRequests.downvote': return '反対';
			case 'wordRequests.editor_comment': return '編集者のコメント';
			case 'wordRequests.comments': return 'コメント';
			case 'wordRequests.cancel': return 'リクエストを取り下げる';
			case 'wordRequests.canceled': return 'リクエストを取り下げました。';
			case 'wordRequests.target': return '編集先';
			case 'wordRequests.target_already_deleted': return '編集先がすでに削除されています。';
			case 'wordRequests.target_not_found': return '編集先が見つかりません。';
			case 'wordRequests.show_heading': return '編集内容';
			case 'wordRequests.accepted': return 'リクエストが採用されました。';
			case 'wordRequests.rejected': return 'リクエストが却下されました。';
			case 'wordRequests.approved': return 'リクエストに賛成しました。';
			case 'wordRequests.disapproved': return 'リクエストに反対しました。';
			case 'wordRequests.vote_cancelled': return 'リクエストへの投票を取り消しました。';
			case 'wordRequests.votes_count_to_close': return ({required Object count}) => '決定に必要な得票数: ${count}';
			case 'wordRequests.edited_at': return ({required Object time}) => '${time}前に編集';
			case 'wordRequests.pending_reason': return '審査理由';
			case 'wordRequests.duplicating_entry': return '同じ項目が既に存在しています。';
			case 'wordRequests.changing_entry': return '項目名が変更されようとしています。';
			case 'wordRequests.pending_elimination': return '項目が削除されようとしています。';
			case 'wordRequests.pending_modification': return '項目が修正されようとしています。';
			case 'wordRequests.pending_addition': return '項目が追加されようとしています。';
			case 'wordRequests.unknown_reason': return 'その他の理由';
			case 'wordRequests.not_allowed_to_edit': return '編集権限がありません。';
			case 'words.words': return '項目';
			case 'words.word': return '項目';
			case 'words.add': return '項目を追加する';
			case 'words.edit': return '項目を編集する';
			case 'words.created': return '項目を作成しました。';
			case 'words.create_failed': return '項目の作成に失敗しました。';
			case 'words.updated': return '項目を更新しました。';
			case 'words.update_failed': return '項目の更新に失敗しました。';
			case 'words.destroyed': return '項目を削除しました。';
			case 'words.entry': return '見出し語';
			case 'words.reading': return '読み';
			case 'words.pos_tag_id': return '品詞';
			case 'words.meaning': return '意味';
			case 'words.ipa': return 'IPA（発音記号）';
			case 'words.senses': return '意味の詳細';
			case 'words.sense': return ({required Object number}) => '意味(${number})';
			case 'words.show_senses': return '意味の詳細を表示する';
			case 'words.search_sentence': return '例文を検索する';
			case 'words.search_sentence_placeholder': return '例文に含まれるキーワードを入力してください';
			case 'words.no_sentence': return '例文が設定されていません。';
			case 'words.set_sentence_with_ai': return 'AIで例文を設定する';
			case 'words.generate_meaning_with_ai': return 'AIで意味を生成する';
			case 'words.meaning_generation_keyword_placeholder': return '【必須】意味を生成する見出し語を入力してください。';
			case 'words.success_to_generate_meanings': return '意味を生成しました。';
			case 'words.failed_to_generate_meanings': return '意味の生成に失敗しました。';
			case 'words.generate_ipa_with_ai': return 'AIで発音記号を生成する';
			case 'words.ipa_generation_keyword_placeholder': return '【必須】発音記号を生成する見出し語を入力してください。';
			case 'words.regional_pronunciation': return '地域ごとの発音を生成する';
			case 'words.success_to_generate_ipa': return '発音記号を生成しました。';
			case 'words.failed_to_generate_ipa': return '発音記号の生成に失敗しました。';
			case 'words.etymologies': return '語源';
			case 'words.explanation': return '解説';
			case 'words.sentence': return '例文';
			case 'words.synonyms': return '類義語';
			case 'words.antonyms': return '対義語';
			case 'words.related': return '関連語';
			case 'words.detailed_settings': return '詳細設定';
			case 'words.comment': return '編集者のコメント';
			case 'words.comment_placeholder': return 'コメントなどあればここに書いてください。';
			case 'words.update': return '修正する';
			case 'words.diqt_markdown_support': return 'ディクト記法対応';
			case 'words.text_preview': return 'プレビュー';
			case 'words.there_is_no_text': return 'テキストがありません。';
			case 'words.undefined_lang_number': return '言語が設定されていません。';
			case 'words.diqt_notation': return 'ディクト記法';
			case 'words.destroy': return '削除する';
			case 'words.confirmation': return '削除確認';
			case 'words.edit_btn': return '項目を編集する';
			case 'words.new_btn': return '項目を追加する';
			case 'words.view_your_edit': return '編集内容を見る';
			case 'words.details': return '詳細';
			case 'words.not_found': return '該当する単語はありません。';
			case 'words.pos_tag_required': return '品詞を設定してください。';
			default: return null;
		}
	}
}

