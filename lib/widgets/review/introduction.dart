import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/pages/answer_setting/edit.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewIntroduction extends ConsumerWidget {
  const ReviewIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    Future<void> _moveToAnswerSetting() async {
      final String? publicUid =
          ref.watch(currentUserProvider.select((user) => user?.publicUid));
      if (publicUid == null) return;

      // 外部リンクダイアログを表示
      await showDialog(
          context: context,
          builder: (context) {
            // ./locale/ を取り除いたpathを指定する
            return ExternalLinkDialog(
                redirectPath: 'users/$publicUid/answer_setting');
          });
    }

    final settingButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        primary: const Color(0xfff3f3f4),
      ),
      onPressed: () => {
        //AnswerSettingEdit.pushModal(context)
        _moveToAnswerSetting()
      },
      icon: const Icon(
        Icons.settings,
        color: Colors.black54,
      ),
      label: const Text(
        ' 解答・復習設定',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        settingButton,
      ],
    );
  }
}
