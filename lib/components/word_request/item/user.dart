import 'package:booqs_mobile/components/user/icon.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';

class WordRequestItemUser extends StatelessWidget {
  const WordRequestItemUser({super.key, required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    final String name = user?.name ?? t.users.deleted_user;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserIcon(
              user: user,
              widthPercent: 6,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
    );
  }
}
