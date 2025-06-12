import 'package:booqs_mobile/components/ad/modal_bottom_banner.dart';
import 'package:booqs_mobile/components/dictionary/drill_part.dart';
import 'package:booqs_mobile/components/dictionary/introduction.dart';
import 'package:booqs_mobile/components/dictionary/sentence_part.dart';
import 'package:booqs_mobile/components/dictionary/word_part.dart';
import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/guideline.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryShowScreen extends ConsumerWidget {
  const DictionaryShowScreen({super.key, required this.dictionary});
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        HapticFeedback.mediumImpact();
        // 更新したい処理を書く
        ref.invalidate(asyncDictionaryFamily(dictionary.id));
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 24),
              DictionaryIntroduction(dictionary: dictionary),
              DictionaryWordPart(dictionary: dictionary),
              const SizedBox(height: 64),
              DictionarySentencePart(dictionary: dictionary),
              const SizedBox(height: 64),
              DictionaryDrillPart(
                dictionary: dictionary,
              ),
              const SizedBox(height: 64),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity,
                      40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
                ),
                onPressed: () => {
                  ref.read(dictionaryProvider.notifier).state = dictionary,
                  DictionaryGuidelinePage.push(context),
                },
                icon: const Icon(Icons.policy_outlined, color: Colors.white),
                label: Text(
                  t.dictionaries.guideline,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
              const AdModalBottomBanner(),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
