import 'package:booqs_mobile/data/remote/langs.dart';
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

    Widget _googleButton() {
      if (_googleTranslating) {
        if (_translationByGoogle == null) {
          return const Text(
            '翻訳中...',
            style: styleText,
          );
        }
        return const Text(
          '完了',
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
        child: const Text('Google翻訳', style: TextStyle(color: Colors.green)),
      );
    }

    Widget _deeplButton() {
      if (_deeplTranslating) {
        if (_translationByDeepl == null) {
          return const Text(
            '翻訳中...',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          );
        }
        return const Text(
          '完了',
          style: TextStyle(fontSize: 14, color: Colors.black87),
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
        child: const Text('DeepL翻訳', style: TextStyle(color: Colors.green)),
      );
    }

    Widget _googleResults() {
      if (_translationByGoogle == null) {
        return Container();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Google翻訳：',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          Text('$_translationByGoogle', style: styleText),
        ],
      );
    }

    Widget _deeplResults() {
      if (_translationByDeepl == null) {
        return Container();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            'DeepL翻訳：',
            style: TextStyle(
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
            _googleButton(),
            const Text(
              ' / ',
              style: styleText,
            ),
            _deeplButton()
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_googleResults(), _deeplResults()],
        ),
      ],
    );
  }
}
