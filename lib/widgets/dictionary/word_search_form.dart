import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/word_search_results.dart';
import 'package:booqs_mobile/utils/word_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DictionaryWordSearchForm extends StatefulWidget {
  const DictionaryWordSearchForm({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  State<DictionaryWordSearchForm> createState() =>
      _DictionaryWordSearchFormState();
}

class _DictionaryWordSearchFormState extends State<DictionaryWordSearchForm> {
  final _formKey = GlobalKey<FormState>();
  final _wordSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Dictionary _dictionary = widget.dictionary;
    final int _dictionaryId = _dictionary.id;

    void _search() {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      final String keyword = _wordSearchController.text;
      DictionaryWordSearchResultsPage.push(context, _dictionaryId, keyword);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _wordSearchController,
                decoration: InputDecoration(
                  labelText: 'キーワード',
                  hintText: '調べたい単語・熟語を入力',
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
                      _wordSearchController.clear();
                    },
                  ),
                )),
            suggestionsCallback: (pattern) {
              return WordTypeahead.getSuggestions(pattern, _dictionaryId);
            },
            itemBuilder: (context, String suggestion) {
              // 候補をタップしたときに検索画面に遷移する。参考： https://stackoverflow.com/questions/68375774/use-the-typeaheadformfield-inside-a-form-flutter
              return ListTile(
                title: Text(suggestion),
                onTap: () {
                  _wordSearchController.text = suggestion;
                  _search();
                  //_goToWordSearchPage(suggestion);
                },
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
              _wordSearchController.text = "$suggestion";
            },
            validator: (value) {
              if (value!.isEmpty) {
                return '入力してください。';
              }
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 40),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity,
                    48), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
              ),
              onPressed: _search,
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
