import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/answer_setting/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingEdit extends ConsumerStatefulWidget {
  const AnswerSettingEdit({Key? key}) : super(key: key);

  // モーダルによる画面遷移
  static Future pushModal(BuildContext context) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            // 画面遷移のログを送信するために、settings.nameを設定する。
            settings: const RouteSettings(name: answerSettingEdit),
            builder: (BuildContext context) {
              return const AnswerSettingEdit();
            },
            fullscreenDialog: true));
  }

  @override
  _AnswerSettingEditState createState() => _AnswerSettingEditState();
}

class _AnswerSettingEditState extends ConsumerState<AnswerSettingEdit> {
  /* @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.refresh(asyncCurrentUserProvider);
    });
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    /*  final future = ref.watch(asyncCurrentUserProvider); */

    return Scaffold(
      appBar: AppBar(
        title: const Text('解答・復習設定'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            child: const AnswerSettingScreen()),
      ),
    );
  }
}
