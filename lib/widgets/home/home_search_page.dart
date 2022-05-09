import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/dictionary.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/word/search_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeSearchPage extends ConsumerStatefulWidget {
  const HomeSearchPage({Key? key}) : super(key: key);

  @override
  _HomeSearchPageState createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends ConsumerState<HomeSearchPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed. きちんと破棄しよう。
    //searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future _goToDictionaryPage(Dictionary dictionary) async {
    ref.read(dictionaryProvider.notifier).state = dictionary;
    await DictionaryPage.push(context);
  }

  @override
  Widget build(BuildContext context) {
    final future = ref.watch(asyncDictionariesProvider);

    Widget _buildListRow(List<Dictionary> dictionaries, int index) {
      final dictionary = dictionaries[index];

      return ListTile(
        title: Text(dictionary.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () => _goToDictionaryPage(dictionary),
            ),
          ],
        ),
      );
    }

    Widget _dictionaryList(data) {
      final List<Dictionary>? dictionaries = data;
      if (dictionaries == null) return Container();

      return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => _buildListRow(dictionaries, index),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: dictionaries.length,
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          WordSearchForm(searchController: searchController),
          Expanded(
            child: future.when(
              data: (data) => _dictionaryList(data),
              error: (err, stack) => Text('Error: $err'),
              loading: () => const LoadingSpinner(),
            ),
          ),
        ],
      ),
    );
  }
}
