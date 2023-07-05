import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/guideline.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/dictionary/drill_part.dart';
import 'package:booqs_mobile/components/dictionary/introduction.dart';
import 'package:booqs_mobile/components/dictionary/sentence_part.dart';
import 'package:booqs_mobile/components/dictionary/word_part.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryShowPage extends ConsumerStatefulWidget {
  const DictionaryShowPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, int dictionaryId) async {
    return Navigator.of(context).pushNamed(dictionaryShowPage,
        arguments: {'dictionaryId': dictionaryId});
  }

  @override
  DictionaryShowPageState createState() => DictionaryShowPageState();
}

class DictionaryShowPageState extends ConsumerState<DictionaryShowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int dictionaryId = arguments['dictionaryId'];
      ref.invalidate(asyncDictionaryFamily(dictionaryId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int dictionaryId = arguments['dictionaryId'];
    final Dictionary? dictionary = ref.watch(dictionaryProvider);
    final future = ref.watch(asyncDictionaryFamily(dictionaryId));

    Widget title() {
      return future.when(
        data: (date) => Text('${date?.typeName()}'),
        error: (err, stack) => Text('Error: $err'),
        loading: () => Text('${dictionary?.typeName()}'),
      );
    }

    Widget page(Dictionary? dictionary) {
      if (dictionary == null) return const LoadingSpinner();

      return Column(
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
          const SizedBox(height: 120),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: title(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: future.when(
            data: (date) => page(date),
            error: (err, stack) => Text('Error: $err'),
            loading: () => page(dictionary),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
