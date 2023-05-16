import 'package:booqs_mobile/components/lang/small_translation_over_limit.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/langs.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/language.dart';
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
              widget.original, widget.sourceLangNumber, targetLangNumber, user);
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
              widget.original, widget.sourceLangNumber, targetLangNumber, user);
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
