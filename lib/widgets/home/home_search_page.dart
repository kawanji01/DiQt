import 'dart:convert';

import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/dictionary.dart';
import 'package:booqs_mobile/widgets/word/word_search_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeSearchPage extends StatefulWidget {
  const HomeSearchPage({Key? key}) : super(key: key);

  @override
  _HomeSearchPageState createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  List<Dictionary> _dictionaries = [];

  // floatingButtonを押した時にフォームにフォーカスさせるための処理 / https://flutter.dev/docs/cookbook/forms/focus
  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.
  late FocusNode searchFocusNode;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchFocusNode = FocusNode();
    _loadDictionaries();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed. きちんと破棄しよう。
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  // async create list
  Future _loadDictionaries() async {
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/api/v1/mobile/dictionaries');
    var res =
        await http.get(url, headers: {"Content-Type": "application/json"});
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map<String, dynamic> resMap = json.decode(res.body);
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    resMap['data'].forEach((e) => _dictionaries.add(Dictionary.fromJson(e)));
    setState(() {
      _dictionaries;
    });
  }

  Future _goToDictionaryPage(Dictionary dictionary) async {
    await DictionaryPage.push(context, dictionary);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildListRow(BuildContext context, int index) {
      final dictionary = _dictionaries[index];

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

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          WordSearchForm(
              searchController: searchController, focusNode: searchFocusNode),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: _buildListRow,
              separatorBuilder: (context, index) => const Divider(),
              itemCount: _dictionaries.length,
            ),
          ),
        ],
      ),
    );
  }
}
