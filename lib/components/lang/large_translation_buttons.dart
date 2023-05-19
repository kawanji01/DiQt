import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/lang/small_translation_over_limit.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/langs.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LangLargeTranslationButtons extends ConsumerStatefulWidget {
  const LangLargeTranslationButtons({
    Key? key,
    required this.original,
    required this.sourceLangNumber,
  }) : super(key: key);
  final String original;
  final int sourceLangNumber;

  @override
  LangLargeTranslationButtonsState createState() =>
      LangLargeTranslationButtonsState();
}

class LangLargeTranslationButtonsState
    extends ConsumerState<LangLargeTranslationButtons> {
  String? _translationByGoogle;
  String? _translationByDeepl;
  bool _googleTranslating = false;
  bool _googleTranlsationDone = false;
  bool _deeplTranslating = false;
  bool _deeplTranslationDone = false;

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) {
      return const Text('not Logged in');
    }
    // 同じ言語なら翻訳を表示しない。
    if (user.langNumber == widget.sourceLangNumber) {
      return Container();
    }
    // 翻訳上限を超えた場合
    if (user.premium == false && user.todaysTranslationsCount > 9) {
      return const LangSmallTranslationOverLimit();
    }

    final int targetLangNumber = user.langNumber;

    const TextStyle styleText = TextStyle(fontSize: 14, color: Colors.black87);
    final String sourceLanguage =
        LanguageService.getLanguageFromNumber(widget.sourceLangNumber);
    final String targetLanguage =
        LanguageService.getLanguageFromNumber(targetLangNumber);
    final String translationInfo = '$sourceLanguage - $targetLanguage';

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
          onTap: () async {
            setState(() {
              _googleTranslating = true;
            });
            final Map? resMap = await RemoteLangs.googleTranslation(
                widget.original,
                widget.sourceLangNumber,
                targetLangNumber,
                user);
            setState(() {
              _translationByGoogle =
                  resMap == null ? null : resMap['translation'];
              _googleTranslating = false;
              _googleTranlsationDone = true;
            });
          },
          child: MediumGreenButton(
              label: t.lang.google_translation,
              fontSize: 16,
              icon: Icons.translate));
    }

    Widget deeplButton() {
      if (_deeplTranslationDone) {
        return Container();
      }
      if (_deeplTranslating) {
        return loadingSpinner();
      }
      return InkWell(
          onTap: () async {
            setState(() {
              _deeplTranslating = true;
            });
            final Map? resMap = await RemoteLangs.deeplTranslation(
                widget.original,
                widget.sourceLangNumber,
                targetLangNumber,
                user);
            setState(() {
              _translationByDeepl =
                  resMap == null ? null : resMap['translation'];
              _deeplTranslating = false;
              _deeplTranslationDone = true;
            });
          },
          child: MediumGreenButton(
              label: t.lang.deepl_translation,
              fontSize: 16,
              icon: Icons.translate));
    }

    Widget googleResults() {
      if (_translationByGoogle == null) {
        return Container();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            '${t.lang.google_translation} ($translationInfo)：',
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          Text('$_translationByGoogle', style: styleText),
        ],
      );
    }

    Widget deeplResults() {
      if (_translationByDeepl == null) {
        return Container();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            '${t.lang.deepl_translation} ($translationInfo)：',
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          Text('$_translationByDeepl', style: styleText),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        googleButton(),
        googleResults(),
        const SizedBox(height: 16),
        deeplButton(),
        deeplResults()
      ],
    );
  }
}
