import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/weaknesses.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:booqs_mobile/widgets/button/small_outline_green_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessSettingButton extends ConsumerStatefulWidget {
  const WeaknessSettingButton(
      {Key? key, required this.quizId, required this.weakness})
      : super(key: key);
  final Weakness? weakness;
  final int quizId;

  @override
  _WeaknessSettingButtonState createState() => _WeaknessSettingButtonState();
}

class _WeaknessSettingButtonState extends ConsumerState<WeaknessSettingButton> {
  Weakness? _weakness;
  @override
  void initState() {
    super.initState();
    setState(() {
      _weakness = widget.weakness;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _create() async {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) {
        const snackBar = SnackBar(content: Text('苦手な問題を設定するにはログインが必要です。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return UserMyPage.push(context);
      }
      final Map? resMap = await RemoteWeaknesses.create(widget.quizId);
      if (resMap == null) return;
      final Weakness weakness = Weakness.fromJson(resMap['weakness']);
      final User user = User.fromJson(resMap['user']);
      ref.watch(currentUserProvider.notifier).state = user;
      setState(() {
        _weakness = weakness;
      });
    }

    Future<void> _destroy() async {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return;

      final Map? resMap = await RemoteWeaknesses.destroy(_weakness!.id);
      if (resMap == null) return;
      final User user = User.fromJson(resMap['user']);
      ref.watch(currentUserProvider.notifier).state = user;
      setState(() {
        _weakness = null;
      });
    }

    if (_weakness == null) {
      return InkWell(
        onTap: () {
          _create();
        },
        child: const SmallOutlineGreenButton(
          label: '苦手な問題に追加する',
          icon: Icons.check_circle_outline,
        ),
      );
    }

    return InkWell(
      onTap: () {
        _destroy();
      },
      child: const SmallGreenButton(
        label: '苦手な問題から取り除く',
        icon: Icons.check_circle_outline,
      ),
    );
  }
}
