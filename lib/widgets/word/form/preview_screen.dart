import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/widgets/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/widgets/sentence/item.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordFormPreviewScreen extends ConsumerWidget {
  const WordFormPreviewScreen(
      {Key? key,
      required this.entry,
      required this.meaning,
      required this.explanation,
      required this.sentenceId,
      required this.dictionary})
      : super(key: key);
  final String entry;
  final String meaning;
  final String explanation;
  final String sentenceId;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget _sentence(Sentence? sentence) {
      if (sentence == null) {
        return Container();
      }
      return SentenceItem(sentence: sentence);
    }

    Widget _sentencePreview() {
      if (sentenceId == '') {
        return Container();
      }
      final int sentenceIdInt = int.parse(sentenceId);
      final future = ref.watch(asyncSentenceFamily(sentenceIdInt));
      return future.when(
        loading: () => const LoadingSpinner(),
        error: (err, stack) => Text('Error: $err'),
        data: (Sentence? data) => _sentence(data),
      );
    }

    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

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
          const Text('項目のプレビュー',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 16,
          ),
          const SharedItemLabel(text: '項目'),
          const SizedBox(
            height: 16,
          ),
          Text(entry,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 32,
          ),
          const SharedItemLabel(text: '意味'),
          const SizedBox(
            height: 16,
          ),
          Text(meaning,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 32,
          ),
          const SharedItemLabel(text: '解説'),
          const SizedBox(
            height: 16,
          ),
          MarkdownWithDictLink(
            text: explanation,
            dictionaryId: dictionary.id,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontColor: Colors.black87,
            selectable: true,
          ),
          const SizedBox(
            height: 40,
          ),
          _sentencePreview(),
          const SizedBox(
            height: 64,
          ),
        ],
      )),
    );
  }
}
