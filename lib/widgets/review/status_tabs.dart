import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewStatusTabs extends ConsumerWidget {
  const ReviewStatusTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    final int unsolvedReviewsCount =
        user == null ? 0 : user.unsolvedReviewsCount;
    final int reviewsCount = user == null ? 0 : user.reviewsCount;
    final int solvedReviewsCount =
        user == null ? 0 : reviewsCount - unsolvedReviewsCount;

    Widget _unsolved() {
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '未解答\n($unsolvedReviewsCount)',
            style: const TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      );
      return InkWell(
        onTap: () {
          print("");
        },
        child: Container(alignment: Alignment.center, child: text),
      );
    }

    Widget _solved() {
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '予定\n($solvedReviewsCount)',
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      );
      return InkWell(
        onTap: () {
          // 外部リンクダイアログを表示
          showDialog(
              context: context,
              builder: (context) {
                return const ExternalLinkDialog(
                    redirectPath: 'reviews/scheduled');
              });
        },
        child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(width: 0.5, color: Colors.black54),
                right: BorderSide(width: 0.5, color: Colors.black54),
              ),
            ),
            child: text),
      );
    }

    Widget _all() {
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'すべて\n($reviewsCount)',
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      );
      return InkWell(
        onTap: () {
          // 外部リンクダイアログを表示
          showDialog(
              context: context,
              builder: (context) {
                return const ExternalLinkDialog(redirectPath: 'reviews/all');
              });
        },
        child: Container(alignment: Alignment.center, child: text),
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _unsolved(),
        ),
        Expanded(flex: 1, child: _solved()),
        Expanded(flex: 1, child: _all()),
      ],
    );
  }
}
