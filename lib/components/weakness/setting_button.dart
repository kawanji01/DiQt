import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/weaknesses.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/components/button/small_outline_green_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessSettingButton extends ConsumerStatefulWidget {
  const WeaknessSettingButton(
      {Key? key, required this.quizId, required this.weakness})
      : super(key: key);
  final Weakness? weakness;
  final int quizId;

  @override
  WeaknessSettingButtonState createState() => WeaknessSettingButtonState();
}

class WeaknessSettingButtonState extends ConsumerState<WeaknessSettingButton> {
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
    Future<void> create() async {
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteWeaknesses.create(widget.quizId);
      EasyLoading.dismiss();

      if (resMap == null) return;
      final Weakness weakness = Weakness.fromJson(resMap['weakness']);
      final User user = User.fromJson(resMap['user']);
      ref.watch(currentUserProvider.notifier).update(user);
      setState(() {
        _weakness = weakness;
      });
    }

    Future<void> destroy() async {
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteWeaknesses.destroy(_weakness!.id);
      EasyLoading.dismiss();
      if (resMap == null) return;
      final User user = User.fromJson(resMap['user']);
      ref.watch(currentUserProvider.notifier).update(user);
      setState(() {
        _weakness = null;
      });
    }

    if (_weakness == null) {
      return InkWell(
        onTap: () {
          create();
        },
        child: SmallOutlineGreenButton(
          label: t.weaknesses.set_to_weakness,
          icon: Icons.check_circle_outline,
        ),
      );
    }

    return InkWell(
      onTap: () {
        destroy();
      },
      child: SmallGreenButton(
        label: t.weaknesses.remove_from_weakness,
        icon: Icons.check_circle_outline,
      ),
    );
  }
}
