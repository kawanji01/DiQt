import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewSettingAction extends ConsumerWidget {
  const ReviewSettingAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? currentUser = ref.watch(currentUserProvider);

    Future _moveToReviews() async {
      // 外部リンクダイアログを表示
      await showDialog(
          context: context,
          builder: (context) {
            // ./locale/ を取り除いたpathを指定する
            return const ExternalLinkDialog(redirectPath: 'reviews');
          });
    }

    Future _pushPopup(value) async {
      switch (value) {
        case 0:
          //_moveToAccountSetting();
          await _moveToReviews();
          break;
      }
    }

    Widget _settingButton() {
      if (currentUser == null) return Container();

      // PopupMenuButton 参考： https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
      return PopupMenuButton(
        onSelected: (newValue) {
          _pushPopup(newValue);
        },
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem(
            child: Text(
              'Webで解く',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            value: 0,
          ),
          /* const PopupMenuItem(
            child: Text(
              '解答設定',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            value: 1,
          ) */
        ],
      );
    }

    return _settingButton();
  }
}
