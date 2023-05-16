import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/data/remote/langs.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/language.dart';
import 'package:flutter/material.dart';

class LangLargeTranslationButtons extends StatefulWidget {
  const LangLargeTranslationButtons(
      {Key? key,
      required this.original,
      required this.sourceLangNumber,
      required this.targetLangNumber})
      : super(key: key);
  final String original;
  final int sourceLangNumber;
  final int targetLangNumber;

  @override
  State<LangLargeTranslationButtons> createState() =>
      _LangLargeTranslationButtonsState();
}

class _LangLargeTranslationButtonsState
    extends State<LangLargeTranslationButtons> {
  String? _translationByGoogle;
  String? _translationByDeepl;
  bool _googleTranslating = false;
  bool _googleTranlsationDone = false;
  bool _deeplTranslating = false;
  bool _deeplTranslationDone = false;

  @override
  Widget build(BuildContext context) {
    const TextStyle styleText = TextStyle(fontSize: 14, color: Colors.black87);
    final String sourceLanguage =
        LanguageService.getLanguageFromNumber(widget.sourceLangNumber);
    final String targetLanguage =
        LanguageService.getLanguageFromNumber(widget.targetLangNumber);
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
                widget.targetLangNumber);
            setState(() {
              _translationByGoogle =
                  resMap == null ? null : resMap['translation'];
              _googleTranslating = false;
              _googleTranlsationDone = true;
            });
          },
          child: MediumGreenButton(
              label: t.lang.google_translation, icon: Icons.translate));
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
                widget.targetLangNumber);
            setState(() {
              _translationByDeepl =
                  resMap == null ? null : resMap['translation'];
              _deeplTranslating = false;
              _deeplTranslationDone = true;
            });
          },
          child: MediumGreenButton(
              label: t.lang.deepl_translation, icon: Icons.translate));
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
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
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
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
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
