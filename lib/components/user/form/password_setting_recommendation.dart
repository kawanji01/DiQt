import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFormPasswordSettingRecommendation extends ConsumerWidget {
  const UserFormPasswordSettingRecommendation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return Container();
    if (user.passwordBeingSet == false) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 48),
        child: Text(t.users.recommend_setting_password,
            style: const TextStyle(color: Colors.red, fontSize: 14)),
      );
    }
    return Container();
  }
}
