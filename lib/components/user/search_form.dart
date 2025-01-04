import 'package:booqs_mobile/pages/user/search.dart';
import 'package:flutter/material.dart';

class UserSearchForm extends StatefulWidget {
  const UserSearchForm({super.key, required this.keyword});
  final String keyword;

  @override
  State<UserSearchForm> createState() => _UserSearchFormState();
}

class _UserSearchFormState extends State<UserSearchForm> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _searchController.text = widget.keyword;

    void search() {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      final String keyword = _searchController.text;
      UserSearchPage.push(context, keyword);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'キーワードを入力してください',
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
                  _searchController.clear();
                },
              ),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
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
