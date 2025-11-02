import 'package:booqs_mobile/components/shared/review_onboarding.dart';
import 'package:booqs_mobile/consts/images.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/safe_google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeWalkthrough1 extends ConsumerWidget {
  const HomeWalkthrough1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final String langCode = ref.watch(localeProvider.notifier).langCode;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => FullScreenImageDialog(
                  imageUrl: '$imagesUrl/onboarding/walkthrough_1.png',
                ),
              );
            },
            child: Image.network(
              '$imagesUrl/onboarding/walkthrough_1.png',
              fit: BoxFit.contain,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.error_outline, size: 50),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          child: Text(
            t.home.welcome_description_1,
            style: SafeGoogleFonts.mPlusRounded1c(
              context: context,
              textStyle: Theme.of(context).textTheme.headlineSmall,
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
