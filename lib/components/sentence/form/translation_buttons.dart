import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/langs.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceFormTranslationButtons extends ConsumerStatefulWidget {
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
  SentenceFormTranslationButtonsState createState() =>
      SentenceFormTranslationButtonsState();
}

class SentenceFormTranslationButtonsState
    extends ConsumerState<SentenceFormTranslationButtons> {
  bool _isRequesting = false;
  bool _isGoogleTranslating = false;
  bool _isDeeplTranslating = false;

  // Google翻訳
  Future _translateByGoogle(User user) async {
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
        widget.targetLangNumber,
        user);
    EasyLoading.dismiss();
    // リクエストロック終了
    setState(() {
      _isRequesting = false;
      _isGoogleTranslating = false;
    });
    if (!mounted) return;
    if (resMap == null) {
      final snackBar = SnackBar(content: Text(t.lang.translation_failed));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final String translation = resMap['translation'] ?? '';
      widget.translationController.text = translation;
    }
  }

  // DeepL翻訳
  Future _translateByDeepL(User user) async {
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
        widget.targetLangNumber,
        user);
    EasyLoading.dismiss();
    // リクエストロック終了
    setState(() {
      _isRequesting = false;
      _isDeeplTranslating = false;
    });
    if (resMap == null) {
      if (!mounted) return;
      final snackBar = SnackBar(content: Text(t.lang.translation_failed));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final String translation = resMap['translation'] ?? '';
      widget.translationController.text = translation;
    }
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle styleText = TextStyle(fontSize: 14, color: Colors.black87);
    const TextStyle buttonStyleText = TextStyle(color: Colors.green);
    final User? user = ref.watch(currentUserProvider);
    if (user == null) {
      return Container();
    }

    Widget googleButton() {
      if (_isGoogleTranslating) {
        return Text(
          t.lang.translating,
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
                _translateByGoogle(user);
              },
        child: Text(t.lang.google_translation, style: buttonStyleText),
      );
    }

    Widget deeplButton() {
      if (_isDeeplTranslating) {
        return Text(
          t.lang.translating,
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
                _translateByDeepL(user);
              },
        child: Text(t.lang.deepl_translation, style: buttonStyleText),
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
