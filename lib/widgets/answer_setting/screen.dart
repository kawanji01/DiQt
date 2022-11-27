import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/remote/answer_settings.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/answer_setting/answer_setting.dart';
import 'package:booqs_mobile/widgets/answer_setting/review_setting.dart';
import 'package:booqs_mobile/widgets/answer_setting/weakness_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingScreen extends ConsumerStatefulWidget {
  const AnswerSettingScreen({Key? key, required this.primary})
      : super(key: key);
  final String primary;

  @override
  AnswerSettingScreenState createState() => AnswerSettingScreenState();
}

class AnswerSettingScreenState extends ConsumerState<AnswerSettingScreen> {
  final TextEditingController _dailyGoalController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _dailyGoalController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AnswerSetting? answerSetting = ref.watch(answerSettingProvider);
    if (answerSetting == null) return Container();

    _dailyGoalController.text = '${answerSetting.dailyGoal}';

    Future<void> update() async {
      Map<String, dynamic> params = {
        'daily_goal': _dailyGoalController.text,
        'question_covered': ref.watch(questionCoveredProvider),
        'choices_covered': ref.watch(choicesCoveredProvider),
        'strict_solving_mode': ref.watch(strictSolvingModeProvider),
        'se_enabled': ref.watch(seEnabledProvider),
        'effect_enabled': ref.watch(effectEnabledProvider),
        'initial_interval': ref.watch(initialIntervalProvider),
        'interval_step_up_condition':
            ref.watch(intervalStepUpConditionProvider),
        'review_delete_condition': ref.watch(reviewDeleteConditionProvider),
        'review_notification_enabled':
            ref.watch(reviewNotificationEnabledProvider),
        'review_notification_timer': ref.watch(reviewNotificationTimerProvider),
        'strict_reviewing_mode': ref.watch(strictReviewingModeProvider),
        'weakness_condition': ref.watch(weaknessConditionProvider),
        'overcoming_condition': ref.watch(overcomingConditionProvider),
      };

      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteAnswerSettings.update(params);
      EasyLoading.dismiss();
      if (!mounted) return;
      if (resMap == null) {
        const snackBar = SnackBar(content: Text('設定が更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        AnswerSetting answerSetting =
            AnswerSetting.fromJson(resMap['answer_setting']);
        ref.read(answerSettingProvider.notifier).state = answerSetting;
        const snackBar = SnackBar(content: Text('設定を更新しました。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      Navigator.of(context).pop();
    }

    Widget submitButton() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context),
          ),
          padding: const EdgeInsets.only(bottom: 32),
          color: Colors.white,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
            ),
            onPressed: () => {update()},
            icon: const Icon(Icons.settings, color: Colors.white),
            label: const Text(
              '更新する',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      );
    }

    // primaryに応じて、設定を並べ替える
    Widget column() {
      final String primary = widget.primary;
      switch (primary) {
        case 'AnswerSetting':
          return Column(
            children: [
              const SizedBox(height: 24),
              AnswerSettingAnswerSetting(
                dailyGoalController: _dailyGoalController,
              ),
              const SizedBox(height: 48),
              const AnswerSettingReviewSetting(),
              const SizedBox(height: 48),
              const AnswerSettingWeaknessSetting(),
              const SizedBox(height: 200),
            ],
          );
        case 'reviewSetting':
          return Column(
            children: [
              const SizedBox(height: 24),
              const AnswerSettingReviewSetting(),
              const SizedBox(height: 48),
              AnswerSettingAnswerSetting(
                dailyGoalController: _dailyGoalController,
              ),
              const SizedBox(height: 48),
              const AnswerSettingWeaknessSetting(),
              const SizedBox(height: 200),
            ],
          );
        case 'weaknessSetting':
          return Column(
            children: [
              const SizedBox(height: 24),
              const AnswerSettingWeaknessSetting(),
              const SizedBox(height: 48),
              AnswerSettingAnswerSetting(
                dailyGoalController: _dailyGoalController,
              ),
              const SizedBox(height: 48),
              const AnswerSettingReviewSetting(),
              const SizedBox(height: 200),
            ],
          );
        default:
          return Column(
            children: [
              const SizedBox(height: 24),
              AnswerSettingAnswerSetting(
                dailyGoalController: _dailyGoalController,
              ),
              const SizedBox(height: 48),
              const AnswerSettingReviewSetting(),
              const SizedBox(height: 48),
              const AnswerSettingWeaknessSetting(),
              const SizedBox(height: 200),
            ],
          );
      }
    }

    return SizedBox(
      width: double.infinity,
      height: ResponsiveValues.dialogHeight(context),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveValues.horizontalMargin(context)),
              child: column(),
            ),
          ),
          submitButton(),
        ],
      ),
    );
  }
}
