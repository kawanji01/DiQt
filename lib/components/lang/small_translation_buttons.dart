import 'package:booqs_mobile/data/remote/langs.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/language.dart';
import 'package:flutter/material.dart';

class LangSmallTranslationButtons extends StatefulWidget {
  const LangSmallTranslationButtons(
      {Key? key,
      required this.original,
      required this.sourceLangNumber,
      required this.targetLangNumber})
      : super(key: key);
  final String original;
  final int sourceLangNumber;
  final int targetLangNumber;

  @override
  State<LangSmallTranslationButtons> createState() =>
      _LangSmallTranslationButtonsState();
}

class _LangSmallTranslationButtonsState
    extends State<LangSmallTranslationButtons> {
  String? _translationByGoogle;
  String? _translationByDeepl;
  bool _googleTranslating = false;
  bool _deeplTranslating = false;

  @override
  Widget build(BuildContext context) {
    const TextStyle styleText = TextStyle(fontSize: 14, color: Colors.black87);
    final String sourceLanguage =
        LanguageService.getLanguageFromNumber(widget.sourceLangNumber);
    final String targetLanguage =
        LanguageService.getLanguageFromNumber(widget.targetLangNumber);
    final String translationInfo = '$sourceLanguage - $targetLanguage';

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
        onPressed: () async {
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
          });
        },
        child: Text(t.lang.google_translation,
            style: const TextStyle(color: Colors.green)),
      );
    }

    Widget deeplButton() {
      if (_deeplTranslating) {
        if (_translationByDeepl == null) {
          return Text(
            t.lang.translating,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          );
        }
        return Text(
          t.lang.done,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
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
        onPressed: () async {
          setState(() {
            _deeplTranslating = true;
          });
          final Map? resMap = await RemoteLangs.deeplTranslation(
              widget.original,
              widget.sourceLangNumber,
              widget.targetLangNumber);
          setState(() {
            _translationByDeepl = resMap == null ? null : resMap['translation'];
          });
        },
        child: Text(t.lang.deepl_translation,
            style: const TextStyle(color: Colors.green)),
      );
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
          children: [googleResults(), deeplResults()],
        ),
      ],
    );
  }
}
