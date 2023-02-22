import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/components/review/bulk_deletion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewBulkDeletionButton extends ConsumerWidget {
  const ReviewBulkDeletionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isPremium = ref.watch(premiumEnabledProvider);

    final RichText richText = RichText(
        text: const TextSpan(children: [
      WidgetSpan(
        child: Icon(
          Icons.delete,
          color: Colors.red,
          size: 18.0,
        ),
      ),
      TextSpan(
          text: 'すべての復習を削除する',
          style: TextStyle(
              color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold))
    ]));

    return InkWell(
      onTap: () {
        if (isPremium) {
          Dialogs.slideFromBottomFade(const ReviewBulkDeletionScreen());
        } else {
          const snackBar =
              SnackBar(content: Text('復習の全削除機能を利用するためには、プレミアムプランへの登録が必要です。'));
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
