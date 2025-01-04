import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/components/review/bulk_deletion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewBulkDeletionButton extends ConsumerWidget {
  const ReviewBulkDeletionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isPremium = ref.watch(premiumEnabledProvider);

    final RichText richText = RichText(
        text: TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.delete,
          color: Colors.red,
          size: 18.0,
        ),
      ),
      TextSpan(
          text: t.reviews.cancel_all_schedules,
          style: const TextStyle(
              color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold))
    ]));

    return InkWell(
      onTap: () {
        if (isPremium) {
          Dialogs.slideFromBottomFade(const ReviewBulkDeletionScreen());
        } else {
          final snackBar =
              SnackBar(content: Text(t.purchase.this_is_premium_plan_feature));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          PremiumPlanPage.push(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        child: richText,
      ),
    );
  }
}
