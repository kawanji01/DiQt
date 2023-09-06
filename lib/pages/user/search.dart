import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/user/item_list_view.dart';
import 'package:booqs_mobile/components/user/search_form.dart';
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

    Widget results() {
      if (keyword == '') return Container();

      return UserItemListView(keyword: keyword);
    }

    // 最終的なアウトプット
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザーを探す'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Column(
            children: [
              const SizedBox(height: 40),
              UserSearchForm(keyword: keyword),
              results(),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
