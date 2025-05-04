import 'package:booqs_mobile/components/lang/small_translation_buttons.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceItemOriginal extends ConsumerWidget {
  const SentenceItemOriginal({super.key, required this.sentence});
  final Sentence sentence;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget translationButton() {
      final int localeNumber = ref.watch(localeProvider.notifier).langNumber;
      if (sentence.langNumberOfTranslation == localeNumber) {
        return Container();
      }
      return LangSmallTranslationButtons(
          original: sentence.original,
          sourceLangNumber: sentence.langNumberOfOriginal,
          targetLangNumber: localeNumber);
    }

    return Column(
      children: [
        TextWithDictLink(
          text: sentence.original,
          langNumber: sentence.langNumberOfOriginal,
          autoLinkEnabled: true,
          crossAxisAlignment:
              rightToLeftScriptsNumbers.contains(sentence.langNumberOfOriginal)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          dictionaryId: sentence.dictionaryId,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontColor: Colors.black87,
          selectable: true,
          textDirection:
              rightToLeftScriptsNumbers.contains(sentence.langNumberOfOriginal)
                  ? TextDirection.rtl
                  : TextDirection.ltr,
        ),
        translationButton(),
      ],
    );
  }
}
