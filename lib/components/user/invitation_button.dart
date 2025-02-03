import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class UserInvitationButton extends ConsumerWidget {
  const UserInvitationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);

    if (user == null) {
      return IconButton(
        //iconSize: 28,
        icon: const Icon(Icons.person_add_alt_1),
        onPressed: () {},
      );
    }

    final String locale = ref.watch(localeProvider);
    final String url =
        '${DiQtURL.root(locale: locale)}/users/${user.publicUid}';
    final String sharedText =
        '${t.users.invitation_message(name: user.name)}\n$url';

    void shareText(String text, String subject) async {
      await Share.share(text, subject: subject);
    }

    return IconButton(
      // iconSize: 28,
      icon: const Icon(Icons.person_add_alt_1),
      onPressed: () => {shareText(sharedText, 'DiQt')},
    );
  }
}
