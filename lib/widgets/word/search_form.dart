import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/word_search_results.dart';
import 'package:booqs_mobile/utils/word_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class WordSearchForm extends ConsumerWidget {
  const WordSearchForm({Key? key, required this.searchController})
      : super(key: key);
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final int dictionaryId = ref.watch(dictionaryIdProvider);

    Future moveToSearchResults(keyword) async {
      await DictionaryWordSearchResultsPage.push(
          context, dictionaryId, keyword);
    }

    void search() {
      if (!formKey.currentState!.validate()) {
        return;
      }
      moveToSearchResults(searchController.text);
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: '単語・熟語を入力してください',
                  // design ref: https://qiita.com/OzWay_Jin/items/60c90ff297aec4ac743c
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                    },
                  ),
                )),
            suggestionsCallback: (pattern) {
              return WordTypeahead.getSuggestions(pattern, dictionaryId);
            },
            itemBuilder: (context, String suggestion) {
              // 候補をタップしたときに検索画面に遷移する。参考： https://stackoverflow.com/questions/68375774/use-the-typeaheadformfield-inside-a-form-flutter
              return ListTile(
                title: Text(suggestion),
                onTap: () {
                  searchController.text = suggestion;
                  moveToSearchResults(suggestion);
                },
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
              searchController.text = "$suggestion";
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'キーワードを入力してください。';
              }
              return null;
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 40),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity,
                    48), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
              ),
              onPressed: search,
              icon: const Icon(Icons.search, color: Colors.white),
              label: const Text(
                '検索する',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
