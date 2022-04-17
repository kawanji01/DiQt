import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingScreen extends ConsumerWidget {
  const AnswerSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AnswerSetting? answerSetting = ref.watch(answerSettingProvider);
    if (answerSetting == null) return Container();

    return Container();
  }
}
