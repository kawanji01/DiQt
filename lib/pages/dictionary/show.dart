import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/dictionary/drill_part.dart';
import 'package:booqs_mobile/widgets/dictionary/introduction.dart';
import 'package:booqs_mobile/widgets/dictionary/sentence_part.dart';
import 'package:booqs_mobile/widgets/dictionary/word_part.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryShowPage extends ConsumerStatefulWidget {
  const DictionaryShowPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, int dictionaryId) async {
    return Navigator.of(context).pushNamed(dictionaryShowPage,
        arguments: {'dictionaryId': dictionaryId});
  }

  @override
  _DictionaryShowPageState createState() => _DictionaryShowPageState();
}

class _DictionaryShowPageState extends ConsumerState<DictionaryShowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int dictionaryId = arguments['dictionaryId'];
      ref.refresh(asyncDictionaryFamily(dictionaryId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int dictionaryId = arguments['dictionaryId'];
    final future = ref.watch(asyncDictionaryFamily(dictionaryId));

    Widget _title() {
      return future.when(
        loading: () => const Text(''),
        error: (err, stack) => Text('Error: $err'),
        data: (dictionary) => Text('${dictionary?.title}'),
      );
    }

    Widget _page(Dictionary? dictionary) {
      if (dictionary == null) return const Text('Dictionary does not exist.');

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
          const SizedBox(height: 120),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: future.when(
            loading: () => const LoadingSpinner(),
            error: (err, stack) => Text('Error: $err'),
            data: (dictionary) => _page(dictionary),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
