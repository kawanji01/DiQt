import 'package:booqs_mobile/components/lang/deepl_translation_results.dart';
import 'package:booqs_mobile/components/lang/google_tranlsation_button.dart';
import 'package:booqs_mobile/components/lang/google_translation_results.dart';
import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/langs.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LangSmallTranslationButtons extends ConsumerStatefulWidget {
  const LangSmallTranslationButtons({
    Key? key,
    required this.original,
    required this.sourceLangNumber,
    required this.targetLangNumber,
  }) : super(key: key);
  final String original;
  final int sourceLangNumber;
  final int targetLangNumber;

  @override
  LangSmallTranslationButtonsState createState() =>
      LangSmallTranslationButtonsState();
}

class LangSmallTranslationButtonsState
    extends ConsumerState<LangSmallTranslationButtons> {
  String? _translationByGoogle;
  String? _translationByDeepl;
  bool _googleTranslating = false;
  bool _deeplTranslating = false;

  // Google翻訳
  Future<void> _googleTranslate() async {
    setState(() => _googleTranslating = true);
    final Map? resMap = await RemoteLangs.googleTranslation(
      original: widget.original,
      sourceLangNumber: widget.sourceLangNumber,
      targetLangNumber: widget.targetLangNumber,
    );
    ref.read(todaysTranslationsCountProvider.notifier).state += 1;
    setState(() {
      _translationByGoogle = resMap == null ? null : resMap['translation'];
    });
  }

  // DeepL翻訳
  Future<void> _deeplTranslate() async {
    setState(() => _deeplTranslating = true);
    final Map? resMap = await RemoteLangs.deeplTranslation(
        original: widget.original,
        sourceLangNumber: widget.sourceLangNumber,
        targetLangNumber: widget.targetLangNumber);
    ref.read(todaysTranslationsCountProvider.notifier).state += 1;

    setState(() {
      _translationByDeepl = resMap == null ? null : resMap['translation'];
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
    // 原文がユーザーの母語なら翻訳ボタンを表示しない。
    if (widget.targetLangNumber == widget.sourceLangNumber) {
      return Container();
    }

    // 無料ユーザーが翻訳上限を超えたかどうかを判定
    final bool translationsLimited =
        ref.watch(premiumEnabledProvider) == false &&
            ref.watch(todaysTranslationsCountProvider) >=
                translationsCountLimitForFreeUsers;

    Widget googleButton() {
      return LangTranslationButton(
        label: t.lang.google_translation,
        isTranslating: _googleTranslating,
        translation: _translationByGoogle,
        translationLmited: translationsLimited,
        translate: _googleTranslate,
        moveToPremiumPlan: _moveToPremiumPlan,
      );
    }

    Widget deeplButton() {
      return LangTranslationButton(
        label: t.lang.deepl_translation,
        isTranslating: _deeplTranslating,
        translation: _translationByDeepl,
        translationLmited: translationsLimited,
        translate: _deeplTranslate,
        moveToPremiumPlan: _moveToPremiumPlan,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            googleButton(),
            const Text(
              ' / ',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            deeplButton()
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LangGoogleTranslationResults(
              sourceLangNumber: widget.sourceLangNumber,
              targetLangNumber: widget.targetLangNumber,
              results: _translationByGoogle,
            ),
            LangDeeplTranslationResults(
              sourceLangNumber: widget.sourceLangNumber,
              targetLangNumber: widget.targetLangNumber,
              results: _translationByDeepl,
            ),
          ],
        ),
      ],
    );
  }
}
