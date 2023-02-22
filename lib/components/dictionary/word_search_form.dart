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
  void dispose() {
    _wordSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Dictionary dictionary = widget.dictionary;
    final int dictionaryId = dictionary.id;

    void search() {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      final String keyword = _wordSearchController.text;
      DictionaryWordSearchResultsPage.push(context, dictionaryId, keyword);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _wordSearchController,
                decoration: InputDecoration(
                  labelText: '単語や熟語を入力してください',
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
              return WordTypeahead.getSuggestions(pattern, dictionaryId);
            },
            itemBuilder: (context, String suggestion) {
              // 候補をタップしたときに検索画面に遷移する。参考： https://stackoverflow.com/questions/68375774/use-the-typeaheadformfield-inside-a-form-flutter
              return ListTile(
                title: Text(suggestion),
                onTap: () {
                  _wordSearchController.text = suggestion;
                  search();
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
              return null;
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 40),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
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
