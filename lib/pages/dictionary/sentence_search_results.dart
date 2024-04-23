import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/dictionary/sentence_list_view.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionarySentenceSearchResultsPage extends ConsumerStatefulWidget {
  const DictionarySentenceSearchResultsPage({Key? key}) : super(key: key);

  static Future push(
      BuildContext context, int dictionaryId, String keyword) async {
    return Navigator.of(context).pushNamed(dictionarySentenceSearchResultsPage,
        arguments: {'dictionaryId': dictionaryId, 'keyword': keyword});
  }

  @override
  DictionarySentenceSearchResultsPageState createState() =>
      DictionarySentenceSearchResultsPageState();
}

class DictionarySentenceSearchResultsPageState
    extends ConsumerState<DictionarySentenceSearchResultsPage> {
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
    final String keyword = arguments['keyword'];
    final future = ref.watch(asyncDictionaryFamily(dictionaryId));

    Widget dictionaryName(Dictionary? dictionary) {
      if (dictionary == null) return const Text('Dictionary does not exist.');
      return DictionaryName(dictionary: dictionary, linked: true);
    }

    Widget heading() {
      return future.when(
        loading: () => const LoadingSpinner(),
        error: (err, stack) => Text('Error: $err'),
        data: (dictionary) => dictionaryName(dictionary),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('$keywordの検索結果'),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: ResponsiveValues.horizontalMargin(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                heading(),
                DictionarySentenceListView(
                  dictionaryId: dictionaryId,
                  keyword: keyword,
                ),
              ],
            )),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
