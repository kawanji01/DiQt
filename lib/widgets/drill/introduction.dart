import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/pages/answer_setting/edit.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillIntroduction extends ConsumerWidget {
  const DrillIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Drill? drill = ref.watch(drillProvider);
    if (drill == null) return Container();

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

    final title = Text(
      drill.title,
      style: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
    );

    final image = Image(image: NetworkImage(drill.imageUrl));

    final settingButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        primary: const Color(0xfff3f3f4),
      ),
      onPressed: () => {
        _moveToAnswerSetting()
        //AnswerSettingEdit.pushModal(context)
      },
      icon: const Icon(
        Icons.settings,
        color: Colors.black54,
      ),
      label: const Text(
        ' 解答設定',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),
      ),
    );

    return Column(
      children: [
        title,
        const SizedBox(height: 8),
        image,
        const SizedBox(height: 16),
        settingButton,
      ],
    );
  }
}
