import 'package:booqs_mobile/components/lang/small_translation_buttons.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceItemOriginal extends ConsumerWidget {
  const SentenceItemOriginal({super.key, required this.sentence});
  final Sentence sentence;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);

    Widget translationButton() {
      if (user == null) {
        return Container();
      }
      if (sentence.langNumberOfTranslation == user.langNumber) {
        return Container();
      }
      return LangSmallTranslationButtons(
        original: sentence.original,
        sourceLangNumber: sentence.langNumberOfOriginal,
      );
    }

    return Column(
      children: [
        TextWithDictLink(
          text: sentence.original,
          langNumber: sentence.langNumberOfOriginal,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          dictionaryId: sentence.dictionaryId,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontColor: Colors.black87,
          selectable: true,
        ),
        translationButton()
      ],
    );
  }
}
