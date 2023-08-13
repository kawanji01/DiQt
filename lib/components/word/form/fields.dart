import 'package:booqs_mobile/components/form/editor_comment.dart';
import 'package:booqs_mobile/components/sentence/setting/setting.dart';
import 'package:booqs_mobile/components/word/form/entry.dart';
import 'package:booqs_mobile/components/word/form/meaning.dart';
import 'package:booqs_mobile/components/word/form/senses.dart';
import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordFormFields extends ConsumerWidget {
  const WordFormFields(
      {Key? key,
      required this.word,
      required this.dictionary,
      required this.commentController})
      : super(key: key);
  final Word? word;
  final Dictionary dictionary;
  final TextEditingController commentController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, TextEditingController> wordControllerMap =
        ref.watch(wordControllerMapProvider);
    final TextEditingController entryController =
        wordControllerMap['entry'] ?? TextEditingController();
    final TextEditingController readingController =
        wordControllerMap['reading'] ?? TextEditingController();
    final TextEditingController meaningController =
        wordControllerMap['meaning'] ?? TextEditingController();
    final TextEditingController posTagIdController =
        wordControllerMap['pos_tag_id'] ?? TextEditingController();
    final TextEditingController sentenceIdController =
        wordControllerMap['sentence_id'] ?? TextEditingController();
    final TextEditingController ipaController =
        wordControllerMap['ipa'] ?? TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 項目フォーム
        WordFormEntry(
          entryController: entryController,
          ipaController: ipaController,
          readingController: readingController,
          posTagIdController: posTagIdController,
          dictionary: dictionary,
        ),
        const SizedBox(height: 48),
        WordFormMeaning(
          meaningController: meaningController,
          entryController: entryController,
          posTagIdController: posTagIdController,
          dictionary: dictionary,
        ),
        const SizedBox(height: 48),

        // 例文設定
        SentenceSetting(
          sentenceIdController: sentenceIdController,
          entry: entryController.text,
          dictionary: dictionary,
          posTagIdController: posTagIdController,
        ),

        const SizedBox(height: 48),
        WordFormSenses(
          word: word,
        ),
        const SizedBox(height: 48),
        FormEditorComment(
          commentController: commentController,
        ),

        const SizedBox(height: 48),
      ],
    );
  }
}
