import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 解答設定のプロバイダー
final answerSettingProvider = StateProvider<AnswerSetting?>((ref) => null);

// 解答設定用
final questionCoveredProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? false : setting.questionCovered)));
final choicesCoveredProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? false : setting.choicesCovered)));
final seEnabledProvider = StateProvider<bool>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting == null ? false : setting.seEnabled)));

// 復習設定用
final initialIntervalProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting == null ? 1 : setting.initialInterval)));

final intervalStepUpConditionProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? 1 : setting.intervalStepUpCondition)));

final reviewDeleteConditionProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? 9 : setting.reviewDeleteCondition)));

final reviewNotificationEnabledProvider = StateProvider<bool>((ref) =>
    ref.watch(answerSettingProvider.select((setting) =>
        setting == null ? true : setting.reviewNotificationEnabled)));

final reviewNotificationTimerProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? 6 : setting.reviewNotificationTimer)));

// 弱点分析設定用
final weaknessConditionProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider
        .select((setting) => setting == null ? 2 : setting.weaknessCondition)));

final overcomingConditionProvider = StateProvider<int>((ref) => ref.watch(
    answerSettingProvider.select(
        (setting) => setting == null ? 80 : setting.overcomingCondition)));
