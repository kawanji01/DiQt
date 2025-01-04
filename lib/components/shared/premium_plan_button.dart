import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PremiumPlanButton extends StatelessWidget {
  const PremiumPlanButton({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    if (user.premium == true) return Container();

    return SizedBox(
      height: 40,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 40),
        ),
        onPressed: () async {
          await PremiumPlanPage.push(context);
        },
        icon: const FaIcon(
          FontAwesomeIcons.crown,
          size: 18,
          color: Colors.white,
        ),
        label: Text(
          t.purchase.premium_plan,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
