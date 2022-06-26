import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 解答設定のプロバイダー
final answerSettingProvider = StateProvider<AnswerSetting?>((ref) => null);

//// 解答設定用 ////
// 問題文を隠す設定
final questionCoveredProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? false : setting.questionCovered)));
// 選択肢を隠す設定
final choicesCoveredProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? false : setting.choicesCovered)));
// 厳格解答モード
final strictSolvingModeProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? false : setting.strictSolvingMode)));
// 効果音設定
final seEnabledProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting == null ? false : setting.seEnabled)));
// 解答時の報酬モーダルの表示設定（OFFでモーダルからポップアップに変更する）
final effectEnabledProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting == null ? false : setting.effectEnabled)));
//

//// 復習設定用 ////
// 自動復習の初期設定
final initialIntervalProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting == null ? 1 : setting.initialInterval)));
// 復習間隔を伸張する条件設定
final intervalStepUpConditionProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? 1 : setting.intervalStepUpCondition)));
// 復習設定を解除する条件設定
final reviewDeleteConditionProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? 9 : setting.reviewDeleteCondition)));
// 通知のON/OFF設定
final reviewNotificationEnabledProvider = StateProvider<bool>((ref) =>
    ref.watch(answerSettingProvider.select((setting) =>
        setting == null ? true : setting.reviewNotificationEnabled)));
// 通知を送る時間帯の設定
final reviewNotificationTimerProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? 6 : setting.reviewNotificationTimer)));
// 厳格復習モード
final strictReviewingModeProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? false : setting.strictReviewingMode)));

// 弱点分析設定用
// 弱点に自動設定する条件
final weaknessConditionProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting == null ? 2 : setting.weaknessCondition)));
// 弱点を克服する条件
final overcomingConditionProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? 80 : setting.overcomingCondition)));
