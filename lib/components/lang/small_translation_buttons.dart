import 'package:booqs_mobile/components/lang/deepl_translation_results.dart';
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
  }) : super(key: key);
  final String original;
  final int sourceLangNumber;

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
  Future<void> _googleTranslate(User user) async {
    setState(() => _googleTranslating = true);
    final Map? resMap = await RemoteLangs.googleTranslation(
        widget.original, widget.sourceLangNumber, user.langNumber, user);
    ref.read(todaysTranslationsCountProvider.notifier).state += 1;
    setState(() {
      _translationByGoogle = resMap == null ? null : resMap['translation'];
    });
  }

  // DeepL翻訳
  Future<void> _deeplTranslate(User user) async {
    setState(() => _deeplTranslating = true);
    final Map? resMap = await RemoteLangs.deeplTranslation(
        widget.original, widget.sourceLangNumber, user.langNumber, user);
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
    final User? user = ref.watch(currentUserProvider);
    if (user == null) {
      return const Text('not Logged in');
    }
    // 原文がユーザーの母語なら翻訳ボタンを表示しない。
    if (user.langNumber == widget.sourceLangNumber) {
      return Container();
    }

    // 無料ユーザーが翻訳上限を超えたかどうかを判定
    final bool translationsLimited = user.premium == false &&
        ref.watch(todaysTranslationsCountProvider) >=
            translationsCountLimitForFreeUsers;

    const TextStyle styleText = TextStyle(fontSize: 14, color: Colors.black87);

    Widget googleButton() {
      if (_googleTranslating) {
        if (_translationByGoogle == null) {
          return Text(
            t.lang.translating,
            style: styleText,
          );
        }
        return Text(
          t.lang.done,
          style: styleText,
        );
      }
      return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () =>
            translationsLimited ? _moveToPremiumPlan() : _googleTranslate(user),
        child: Text(t.lang.google_translation,
            style: const TextStyle(color: Colors.green)),
      );
    }

    Widget deeplButton() {
      if (_deeplTranslating) {
        if (_translationByDeepl == null) {
          return Text(
            t.lang.translating,
            style: styleText,
          );
        }
        return Text(
          t.lang.done,
          style: styleText,
        );
      }
      return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () async =>
            translationsLimited ? _moveToPremiumPlan() : _deeplTranslate(user),
        child: Text(t.lang.deepl_translation,
            style: const TextStyle(color: Colors.green)),
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
              style: styleText,
            ),
            deeplButton()
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LangGoogleTranslationResults(
              sourceLangNumber: widget.sourceLangNumber,
              targetLangNumber: user.langNumber,
              results: _translationByGoogle,
            ),
            LangDeeplTranslationResults(
              sourceLangNumber: widget.sourceLangNumber,
              targetLangNumber: user.langNumber,
              results: _translationByDeepl,
            ),
          ],
        ),
      ],
    );
  }
}
