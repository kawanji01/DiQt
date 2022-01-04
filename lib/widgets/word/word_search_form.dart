import 'package:booqs_mobile/pages/word/search_results.dart';
import 'package:booqs_mobile/utils/word_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class WordSearchForm extends StatelessWidget {
  const WordSearchForm(
      {Key? key, required this.searchController, required this.focusNode})
      : super(key: key);
  final TextEditingController searchController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    String _selectedEntry;
    Future _goToWordSearchPage(keyword) async {
      await WordSearchResultsPage.push(context, keyword);
    }

    void _search() {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _goToWordSearchPage(searchController.text);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                  controller: searchController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: '検索ワード',
                    hintText: '調べたい単語・熟語を入力してください',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                      },
                    ),
                  )),
              suggestionsCallback: (pattern) {
                return WordTypeahead.getSuggestions(pattern, 1);
              },
              itemBuilder: (context, String suggestion) {
                // 候補をタップしたときに検索画面に遷移する。参考： https://stackoverflow.com/questions/68375774/use-the-typeaheadformfield-inside-a-form-flutter
                return ListTile(
                  title: Text(suggestion),
                  onTap: () {
                    searchController.text = suggestion;
                    _goToWordSearchPage(suggestion);
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
                  return '入力してください。';
                }
              },
              onSaved: (value) => {_selectedEntry = value!}),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 40),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity,
                    40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
              ),
              onPressed: _search,
              icon: const Icon(Icons.search, color: Colors.white),
              label: const Text(
                '辞書を引く',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
