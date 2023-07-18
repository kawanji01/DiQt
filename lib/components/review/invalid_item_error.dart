import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/data/provider/review.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewInvalidItemError extends ConsumerStatefulWidget {
  const ReviewInvalidItemError({super.key});

  @override
  ReviewInvalidItemErrorState createState() => ReviewInvalidItemErrorState();
}

class ReviewInvalidItemErrorState
    extends ConsumerState<ReviewInvalidItemError> {
  bool _isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          t.shared.error_occurred,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
        const SizedBox(
          height: 24,
        ),
        InkWell(
          onTap: _isProcessing
              ? null
              : () async {
                  setState(() {
                    _isProcessing = true;
                  });
                  EasyLoading.show(status: 'loading...');
                  await RemoteReviews.destroyInvalidItems();
                  EasyLoading.dismiss();
                  ref.invalidate(asyncUnsolvedReviewsProvider);
                  final snackBar =
                      SnackBar(content: Text(t.shared.error_fixed));
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
          child: MediumGreenButton(
            label: t.shared.fix_error,
            fontSize: 16,
            icon: Icons.refresh,
          ),
        ),
      ],
    );
  }
}
