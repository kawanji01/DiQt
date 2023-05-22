import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 解答設定のプロバイダー
final answerSettingProvider = StateProvider<AnswerSetting?>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.answerSetting;
});

//// 解答設定用 ////
// 問題文を隠す設定
final questionCoveredProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting?.questionCovered ?? false)));
// 選択肢を隠す設定
final choicesCoveredProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting?.choicesCovered ?? false)));
// 厳格解答モード
final strictSolvingModeProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting?.strictSolvingMode ?? false)));
// 効果音設定
final seEnabledProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider.select((setting) => setting?.seEnabled ?? false)));
// 解答時の報酬モーダルの表示設定（OFFでモーダルからポップアップに変更する）
final effectEnabledProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting?.effectEnabled ?? false)));
//

//// 復習設定用 ////
// 自動復習の初期設定
final initialIntervalProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider.select((setting) => setting?.initialInterval ?? 1)));
// 復習間隔を伸張する条件設定
final intervalStepUpConditionProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting?.intervalStepUpCondition ?? 1)));
// 復習設定を解除する条件設定
final reviewDeleteConditionProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting?.reviewDeleteCondition ?? 9)));
// 通知のON/OFF設定
final reviewNotificationEnabledProvider = StateProvider<bool>((ref) =>
    ref.watch(answerSettingProvider
        .select((setting) => setting?.reviewNotificationEnabled ?? true)));
// 通知を送る時間帯の設定
final reviewNotificationTimerProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting?.reviewNotificationTimer ?? 6)));
// 厳格復習モード
final strictReviewingModeProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting?.strictReviewingMode ?? false)));

// 弱点分析設定用
// 弱点に自動設定する条件
final weaknessConditionProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting?.weaknessCondition ?? 2)));
// 弱点を克服する条件
final overcomingConditionProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting?.overcomingCondition ?? 80)));
