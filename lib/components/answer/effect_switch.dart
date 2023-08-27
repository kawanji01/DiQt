import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/remote/answer_settings.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerEffectSwitch extends ConsumerStatefulWidget {
  const AnswerEffectSwitch({super.key});

  @override
  ConsumerState<AnswerEffectSwitch> createState() => AnswerEffectSwitchState();
}

class AnswerEffectSwitchState extends ConsumerState<AnswerEffectSwitch> {
  bool _isRequesting = false;

  @override
  Widget build(BuildContext context) {
    final int settingId = ref.watch(answerSettingProvider)!.id;

    Future<void> switchEffect() async {
      setState(() => _isRequesting = true);
      EasyLoading.show(status: 'loading...');
      final Map resMap = await RemoteAnswerSettings.switchEffect(settingId);
      EasyLoading.dismiss();
      setState(() => _isRequesting = false);
      if (!mounted) return;
      if (ErrorHandler.isErrorMap(resMap)) {
        final snackBar = SnackBar(content: Text(t.shared.update_failed));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      final AnswerSetting answerSetting =
          AnswerSetting.fromJson(resMap['answer_setting']);
      ref.read(answerSettingProvider.notifier).state = answerSetting;
    }

    return SwitchListTile(
        title: Text(t.answerSettings.effect_enabled,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        value: ref.watch(effectEnabledProvider),
        onChanged: (bool value) {
          if (_isRequesting) return;
          switchEffect();
        },
        secondary: const Icon(Icons.wysiwyg));
  }
}
