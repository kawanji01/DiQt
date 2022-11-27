import 'package:booqs_mobile/data/remote/langs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SentenceFormTranslationButtons extends StatefulWidget {
  const SentenceFormTranslationButtons(
      {Key? key,
      required this.originalController,
      required this.translationController,
      required this.sourceLangNumber,
      required this.targetLangNumber})
      : super(key: key);
  final TextEditingController originalController;
  final TextEditingController translationController;
  final int sourceLangNumber;
  final int targetLangNumber;

  @override
  State<SentenceFormTranslationButtons> createState() =>
      _SentenceFormTranslationButtonsState();
}

class _SentenceFormTranslationButtonsState
    extends State<SentenceFormTranslationButtons> {
  bool _isRequesting = false;
  bool _isGoogleTranslating = false;
  bool _isDeeplTranslating = false;

  // Google翻訳
  Future _translateByGoogle() async {
    // リクエストロック開始
    setState(() {
      _isRequesting = true;
      _isGoogleTranslating = true;
    });
    // 画面全体にローディングを表示
    EasyLoading.show(status: 'loading...');
    final Map? resMap = await RemoteLangs.googleTranslation(
        widget.originalController.text,
        widget.sourceLangNumber,
        widget.targetLangNumber);
    EasyLoading.dismiss();
    // リクエストロック終了
    setState(() {
      _isRequesting = false;
      _isGoogleTranslating = false;
    });
    if (!mounted) return;
    if (resMap == null) {
      const snackBar = SnackBar(content: Text('翻訳できませんでした。'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final String translation = resMap['translation'] ?? '';
      widget.translationController.text = translation;
    }
  }

  // DeepL翻訳
  Future _translateByDeepL() async {
    // リクエストロック開始
    setState(() {
      _isRequesting = true;
      _isDeeplTranslating = true;
    });
    // 画面全体にローディングを表示
    EasyLoading.show(status: 'loading...');
    final Map? resMap = await RemoteLangs.deeplTranslation(
        widget.originalController.text,
        widget.sourceLangNumber,
        widget.targetLangNumber);
    EasyLoading.dismiss();
    // リクエストロック終了
    setState(() {
      _isRequesting = false;
      _isDeeplTranslating = false;
    });
    if (resMap == null) {
      if (!mounted) return;
      const snackBar = SnackBar(content: Text('翻訳できませんでした。'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final String translation = resMap['translation'] ?? '';
      widget.translationController.text = translation;
    }
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle styleText = TextStyle(fontSize: 14, color: Colors.black87);

    Widget googleButton() {
      if (_isGoogleTranslating) {
        return const Text(
          '翻訳中...',
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
        onPressed: _isRequesting
            ? null
            : () async {
                _translateByGoogle();
              },
        child: const Text('Google翻訳', style: TextStyle(color: Colors.green)),
      );
    }

    Widget deeplButton() {
      if (_isDeeplTranslating) {
        return const Text(
          '翻訳中...',
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
        onPressed: _isRequesting
            ? null
            : () async {
                _translateByDeepL();
              },
        child: const Text('DeepL翻訳', style: TextStyle(color: Colors.green)),
      );
    }

    return Row(
      children: [
        googleButton(),
        const Text(
          ' / ',
          style: styleText,
        ),
        deeplButton(),
      ],
    );
  }
}
