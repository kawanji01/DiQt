import 'package:booqs_mobile/components/button/small_outline_green_button.dart';
import 'package:booqs_mobile/components/user/activation_screen.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRequiredAction extends ConsumerWidget {
  const UserRequiredAction({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? currentUser = ref.watch(currentUserProvider);
    if (user.id != currentUser?.id) {
      return Container();
    }
    if (user.email == null || user.email == '') {
      return InkWell(
          onTap: () {
            UserEditPage.push(context);
          },
          child: SmallOutlineGreenButton(
            icon: Icons.mail,
            label: t.users.please_set_email,
          ));
    } else if (user.activated == false) {
      return InkWell(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
              ),
              builder: (context) => UserActivationScreen(user: user),
            );
          },
          child: SmallOutlineGreenButton(
            icon: Icons.verified_user,
            label: t.users.please_activate_email,
          ));
    } else {
      return Container();
    }
  }
}
