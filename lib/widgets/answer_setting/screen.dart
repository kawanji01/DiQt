import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/remote/answer_settings.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/widgets/answer_setting/answer.dart';
import 'package:booqs_mobile/widgets/answer_setting/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 解答設定用
final questionCoveredProvider = StateProvider<bool>((ref) => false);
final choicesCoveredProvider = StateProvider<bool>((ref) => false);
final seEnabledProvider = StateProvider<bool>((ref) => false);
// 復習設定用
final initialIntervalProvider = StateProvider<int>((ref) => 1);
final intervalStepUpConditionProvider = StateProvider<int>((ref) => 1);
final reviewDeleteConditionProvider = StateProvider<int>((ref) => 9);
final reviewNotificationEnabledProvider = StateProvider<bool>((ref) => true);
final reviewNotificationTimerProvider = StateProvider<int>((ref) => 6);

class AnswerSettingScreen extends ConsumerStatefulWidget {
  const AnswerSettingScreen({Key? key}) : super(key: key);

  @override
  _AnswerSettingScreenState createState() => _AnswerSettingScreenState();
}

class _AnswerSettingScreenState extends ConsumerState<AnswerSettingScreen> {
  final TextEditingController _dailyGoalController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _dailyGoalController.dispose();
  }
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AnswerSetting? _answerSetting = ref.watch(answerSettingProvider);
    if (_answerSetting == null) return Container();

    _dailyGoalController.text = '${_answerSetting.dailyGoal}';
    // 初期値の設定
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // 解答設定
      ref.read(questionCoveredProvider.notifier).state =
          _answerSetting.questionCovered;
      ref.read(choicesCoveredProvider.notifier).state =
          _answerSetting.choicesCovered;
      ref.read(seEnabledProvider.notifier).state = _answerSetting.seEnabled;
      // 復習設定
      ref.read(initialIntervalProvider.notifier).state =
          _answerSetting.initialInterval;
      ref.read(intervalStepUpConditionProvider.notifier).state =
          _answerSetting.intervalStepUpCondition;
      ref.read(reviewDeleteConditionProvider.notifier).state =
          _answerSetting.reviewDeleteCondition;
      ref.read(reviewNotificationEnabledProvider.notifier).state =
          _answerSetting.reviewNotificationEnabled;
      ref.read(reviewNotificationTimerProvider.notifier).state =
          _answerSetting.reviewNotificationTimer;
    });

    Future<void> _update() async {
      Map<String, dynamic> params = _answerSetting.toJson();
      params['daily_goal'] = _dailyGoalController.text;
      params['question_covered'] = ref.watch(questionCoveredProvider);
      params['choices_covered'] = ref.watch(choicesCoveredProvider);
      params['se_enabled'] = ref.watch(seEnabledProvider);
      params['initial_interval'] = ref.watch(initialIntervalProvider);
      params['interval_step_up_condition'] =
          ref.watch(intervalStepUpConditionProvider);
      params['review_delete_condition'] =
          ref.watch(reviewDeleteConditionProvider);
      params['review_notification_enabled'] =
          ref.watch(reviewNotificationEnabledProvider);
      params['review_notification_timer'] =
          ref.watch(reviewNotificationTimerProvider);

      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteAnswerSettings.update(params);
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
      EasyLoading.dismiss();
      Navigator.of(context).pop();
      //print('dailyGoal:${_answerSetting.initialInterval}');
    }

    Widget _submitButton() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.only(bottom: 32),
          color: Colors.white,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
            ),
            onPressed: () => {_update()},
            icon: const Icon(Icons.settings, color: Colors.white),
            label: const Text(
              '更新する',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      height: 600,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                AnswerSettingAnswer(
                  dailyGoalController: _dailyGoalController,
                ),
                const SizedBox(height: 48),
                const AnswerSettingReview(),
                const SizedBox(height: 200),
              ],
            ),
          ),
          _submitButton(),
        ],
      ),
    );
  }
}
