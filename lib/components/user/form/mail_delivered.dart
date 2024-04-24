import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFormMailDelivered extends ConsumerWidget {
  const UserFormMailDelivered({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
        title: Text(t.users.mail_delivered,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        value: ref.watch(userMailDeliveredProvider),
        onChanged: (bool value) {
          ref.read(userMailDeliveredProvider.notifier).state = value;
        },
        secondary: const Icon(Icons.mail));
  }
}
