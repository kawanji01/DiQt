import 'package:booqs_mobile/pages/dictionary/search_en_ja.dart';
import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();

    Future _goToSearchEnJaPage(keyword) async {
      //await Navigator.of(context).pushNamed(searchEnJaPage);
      await SearchEnJaPage.push(context, keyword);
    }

    void _search() {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _goToSearchEnJaPage(_nameController.text);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            focusNode: focusNode,
            decoration: const InputDecoration(
              labelText: '検索ワード',
              hintText: '調べたい単語・熟語を入力してください',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return '入力してください。';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              _search();
            },
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
