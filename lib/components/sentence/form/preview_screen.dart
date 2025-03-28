import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceFormPreviewScreen extends ConsumerWidget {
  const SentenceFormPreviewScreen(
      {super.key,
      required this.original,
      required this.translation,
      required this.explanation,
      required this.dictionary});
  final String original;
  final String translation;
  final String explanation;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

    Widget translationPreview() {
      if (dictionary.bilingual()) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SharedItemLabel(text: t.sentences.translation),
            const SizedBox(
              height: 16,
            ),
            Text(translation,
                style: const TextStyle(fontSize: 16, color: Colors.black87)),
            const SizedBox(
              height: 32,
            ),
          ],
        );
      }
      return Container();
    }

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          Text(t.words.text_preview,
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 16,
          ),
          SharedItemLabel(text: t.sentences.original),
          const SizedBox(
            height: 16,
          ),
          TextWithDictLink(
            text: original,
            langNumber: dictionary.langNumberOfEntry,
            dictionaryId: dictionary.id,
            autoLinkEnabled: true,
            crossAxisAlignment: CrossAxisAlignment.start,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontColor: Colors.black87,
            selectable: true,
          ),
          const SizedBox(
            height: 32,
          ),
          translationPreview(),

          /* TextWithDictLink(
            text: explanation,
            langNumber: dictionary.langNumberOfEntry,
            dictionaryId: dictionary.id,
            autoLinkEnabled: false,
            crossAxisAlignment: CrossAxisAlignment.start,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontColor: Colors.black87,
            selectable: true,
          ), */
          const SizedBox(
            height: 64,
          ),
        ],
      )),
    );
  }
}
