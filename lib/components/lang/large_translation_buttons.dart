import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/lang/translation_results.dart';
import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/langs.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LangLargeTranslationButtons extends ConsumerStatefulWidget {
  const LangLargeTranslationButtons({
    super.key,
    required this.original,
    required this.sourceLangNumber,
    required this.targetLangNumber,
  });
  final String original;
  final int sourceLangNumber;
  final int targetLangNumber;

  @override
  LangLargeTranslationButtonsState createState() =>
      LangLargeTranslationButtonsState();
}

class LangLargeTranslationButtonsState
    extends ConsumerState<LangLargeTranslationButtons> {
  String? _translationByGoogle;
  bool _googleTranslating = false;
  bool _googleTranlsationDone = false;

  // 翻訳
  Future<void> _googleTranslate(User user) async {
    setState(() => _googleTranslating = true);
    final Map? resMap = await RemoteLangs.googleTranslation(
      original: widget.original,
      sourceLangNumber: widget.sourceLangNumber,
      targetLangNumber: widget.targetLangNumber,
    );

    ref.read(todaysTranslationsCountProvider.notifier).state += 1;
    setState(() {
      _translationByGoogle = resMap == null ? null : resMap['translation'];
      _googleTranslating = false;
      _googleTranlsationDone = true;
    });
  }

  // プレミアムプランページに遷移
  void _moveToPremiumPlan() {
    final snackBar = SnackBar(
        content: Text(t.lang.translation_restricted(
            number: translationsCountLimitForFreeUsers)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    PremiumPlanPage.push(context);
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) {
      return const Text('not Logged in');
    }

    // 無料ユーザーが翻訳上限を超えたかどうかを判定
    final bool translationsLimited = user.premium == false &&
        ref.watch(todaysTranslationsCountProvider) >=
            translationsCountLimitForFreeUsers;

    Widget loadingSpinner() {
      return const Center(
        child: CircularProgressIndicator(
          semanticsLabel: 'Linear progress indicator',
        ),
      );
    }

    Widget googleButton() {
      if (_googleTranlsationDone) {
        return Container();
      }
      if (_googleTranslating) {
        return loadingSpinner();
      }

      return InkWell(
          onTap: () => translationsLimited
              ? _moveToPremiumPlan()
              : _googleTranslate(user),
          child: MediumGreenButton(
              label: t.lang.translation_action,
              fontSize: 16,
              icon: Icons.translate));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        googleButton(),
        LangTranslationResults(
          label: t.lang.translation_result,
          sourceLangNumber: widget.sourceLangNumber,
          targetLangNumber: widget.targetLangNumber,
          results: _translationByGoogle,
        ),
      ],
    );
  }
}
