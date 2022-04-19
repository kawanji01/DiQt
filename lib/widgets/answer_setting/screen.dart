import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingScreen extends ConsumerStatefulWidget {
  const AnswerSettingScreen({Key? key}) : super(key: key);

  @override
  _AnswerSettingScreenState createState() => _AnswerSettingScreenState();
}

class _AnswerSettingScreenState extends ConsumerState<AnswerSettingScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AnswerSetting? answerSetting = ref.watch(answerSettingProvider);
    if (answerSetting == null) return Container();
    /* int dailyGoal = answerSetting.dailyGoal;
    bool choicesCovered = answerSetting.choicesCovered;
    bool questionCovered = answerSetting.questionCovered;
    bool seEnabled = answerSetting.seEnabled;
    int intervalStepUpCondition = answerSetting.intervalStepUpCondition;
    int initialInterval = answerSetting.initialInterval;
    int reviewDeleteCondition = answerSetting.reviewDeleteCondition;
    int reviewNotificationTimer = answerSetting.reviewNotificationTimer; */

    final dailyGoalForm = TextField(
      decoration: const InputDecoration(labelText: "Enter your number"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ], // Only numbers can be entered
    );

    return Column(
      children: [],
    );
  }
}
