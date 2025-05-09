import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/remote/answer_settings.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/answer_setting/answer_setting.dart';
import 'package:booqs_mobile/components/answer_setting/review_setting.dart';
import 'package:booqs_mobile/components/answer_setting/weakness_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingScreen extends ConsumerStatefulWidget {
  const AnswerSettingScreen({super.key, required this.primary});
  final String primary;

  @override
  AnswerSettingScreenState createState() => AnswerSettingScreenState();
}

class AnswerSettingScreenState extends ConsumerState<AnswerSettingScreen> {
  final TextEditingController _dailyGoalController = TextEditingController();
  bool _isRequesting = false;

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
      setState(() => _isRequesting = true);
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
      final Map resMap = await RemoteAnswerSettings.update(params);
      EasyLoading.dismiss();
      setState(() => _isRequesting = false);
      if (!context.mounted) return;
      if (ErrorHandler.isErrorMap(resMap)) {
        return ErrorHandler.showErrorSnackBar(context, resMap);
      }
      AnswerSetting answerSetting =
          AnswerSetting.fromJson(resMap['answer_setting']);
      ref.read(answerSettingProvider.notifier).state = answerSetting;
      final snackBar =
          SnackBar(content: Text(t.answerSettings.update_succeeded));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            child: SizedBox(
              height: 56,
              child: InkWell(
                  onTap: _isRequesting
                      ? null
                      : () {
                          update();
                        },
                  child: MediumGreenButton(
                    label: t.shared.update,
                    icon: Icons.settings,
                    fontSize: 18,
                  )),
            )),
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
