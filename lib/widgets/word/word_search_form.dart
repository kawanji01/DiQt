import 'package:booqs_mobile/pages/word/search_results.dart';
import 'package:booqs_mobile/utils/word_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class WordSearchForm extends StatelessWidget {
  const WordSearchForm({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    //final _nameController = TextEditingController();

    final _typeAheadController = TextEditingController();
    String _selectedEntry;

    Future _goToWordSearchPage(keyword) async {
      await WordSearchResultsPage.push(context, keyword);
    }

    void _search() {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _goToWordSearchPage(_typeAheadController.text);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _typeAheadController,
                decoration: const InputDecoration(
                  labelText: '検索ワード',
                  hintText: '調べたい単語・熟語を入力してください',
                )),
            suggestionsCallback: (pattern) {
              return WordTypeahead.getSuggestions(pattern, 1);
            },
            itemBuilder: (context, String suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
              _typeAheadController.text = "$suggestion";
            },
            validator: (value) {
              if (value!.isEmpty) {
                return '入力してください。';
              }
            },
            onSaved: (value) => _selectedEntry = value!,
          ),
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
