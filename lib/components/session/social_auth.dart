import 'package:booqs_mobile/components/session/apple_button.dart';
import 'package:booqs_mobile/components/session/divider.dart';
import 'package:booqs_mobile/components/session/google_button.dart';
import 'package:booqs_mobile/components/session/twitter_button.dart';
import 'package:booqs_mobile/utils/env_handler.dart';
import 'package:flutter/material.dart';

class SessionSocialAuth extends StatelessWidget {
  const SessionSocialAuth({super.key});

  @override
  Widget build(BuildContext context) {
    if (EnvHandler.isDesktop()) return Container();

    return const Column(
      children: [
        SessionDivider(),
        SizedBox(height: 24),
        SessionGoogleButton(),
        SizedBox(height: 24),
        SessionAppleButton(),
        SizedBox(height: 24),
        SessionTwitterButton(),
      ],
    );
  }
}
