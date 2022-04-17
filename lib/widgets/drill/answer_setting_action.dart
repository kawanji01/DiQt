import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillAnswerSettingAction extends ConsumerWidget {
  const DrillAnswerSettingAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Drill? drill = ref.watch(drillProvider);
    final User? user = ref.watch(currentUserProvider);
    if (drill == null) return Container();
    if (user == null) return Container();

    Future _moveToAnswerSetting() async {
      // 外部リンクダイアログを表示
      await showDialog(
          context: context,
          builder: (context) {
            // ./locale/ を取り除いたpathを指定する
            return ExternalLinkDialog(
                redirectPath: 'users/${user.publicUid}/answer_setting');
          });
    }

    Future _moveToReviews() async {
      // 外部リンクダイアログを表示
      await showDialog(
          context: context,
          builder: (context) {
            // ./locale/ を取り除いたpathを指定する
            return ExternalLinkDialog(
                redirectPath: 'drills/${drill.publicUid}/unsolved');
          });
    }

    Future _pushPopup(value) async {
      switch (value) {
        case 0:
          await _moveToAnswerSetting();
          break;
        case 1:
          await _moveToReviews();
          break;
      }
    }

    Widget _settingButton() {
      // PopupMenuButton 参考： https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
      return PopupMenuButton(
        onSelected: (newValue) {
          _pushPopup(newValue);
        },
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem(
            child: Text(
              '解答・復習設定',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            value: 0,
          ),
          const PopupMenuItem(
            child: Text(
              'Webで解く',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            value: 1,
          ),
        ],
      );
    }

    return _settingButton();
  }
}
