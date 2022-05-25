import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/user/item_list_view.dart';
import 'package:booqs_mobile/widgets/user/search_form.dart';
import 'package:flutter/material.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({Key? key}) : super(key: key);

  //
  static Future push(BuildContext context, String keyword) async {
    return Navigator.of(context)
        .pushNamed(userSearchPage, arguments: {'keyword': keyword});
  }

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final String keyword = arguments['keyword'];

    Widget _results() {
      if (keyword == '') return Container();

      return UserItemListView(keyword: keyword);
    }

    Widget _page() {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              UserSearchForm(keyword: keyword),
              _results(),
              const SizedBox(height: 120),
            ],
          ));
    }

    // 最終的なアウトプット
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザーを探す'),
      ),
      body: SingleChildScrollView(
        child: _page(),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
