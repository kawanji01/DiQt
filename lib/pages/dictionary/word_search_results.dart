import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/dictionary/word_list_view.dart';
import 'package:booqs_mobile/components/dictionary/word_search_results_action.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// NOTE: 引数を dictionary ではなく dictionaryId にしているのは、DiQtMarkdownの辞書リンクからでも遷移できるようにするため。
class DictionaryWordSearchResultsPage extends ConsumerStatefulWidget {
  const DictionaryWordSearchResultsPage({Key? key}) : super(key: key);

  static Future push(
      BuildContext context, int dictionaryId, String keyword) async {
    return Navigator.of(context).pushNamed(dictionaryWordSearchResultsPage,
        arguments: {'dictionaryId': dictionaryId, 'keyword': keyword});
  }

  @override
  DictionaryWordSearchResultsPageState createState() =>
      DictionaryWordSearchResultsPageState();
}

class DictionaryWordSearchResultsPageState
    extends ConsumerState<DictionaryWordSearchResultsPage> {
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

    Widget actions() {
      return future.when(
          data: (dictionary) {
            if (dictionary == null) {
              return Container();
            }
            return DictionaryWordSearchResultsAction(
              keyword: keyword,
              dictionary: dictionary,
            );
          },
          error: (e, str) => Container(),
          loading: () => Container());
    }

    Widget dictionary() {
      return future.when(
          data: (dictionary) {
            if (dictionary == null) return Container();
            return Text(dictionary.typeName(),
                style: const TextStyle(fontSize: 12, color: Colors.black54));
          },
          error: (e, str) => Text('$e'),
          loading: () => Container());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t.dictionaries.search_results_of(query: keyword)),
        actions: [
          actions(),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: ResponsiveValues.horizontalMargin(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                dictionary(),
                const SizedBox(height: 24),
                DictionaryWordListView(
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
