import 'package:booqs_mobile/widgets/dictionary/item_list.dart';
import 'package:booqs_mobile/widgets/word/search_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeSearchScreen extends ConsumerStatefulWidget {
  const HomeSearchScreen({Key? key}) : super(key: key);

  @override
  _HomeSearchScreenState createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends ConsumerState<HomeSearchScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed. きちんと破棄しよう。
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          WordSearchForm(searchController: searchController),
          const DictionaryRadioList(),
        ],
      ),
    );
  }
}
