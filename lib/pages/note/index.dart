import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/note/introduction.dart';
import 'package:booqs_mobile/widgets/note/order_select_form.dart';
import 'package:booqs_mobile/widgets/note/quiz_list_view.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';

class NoteIndexPage extends StatefulWidget {
  const NoteIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(noteIndexPage);
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(noteIndexPage);
  }

  @override
  State<NoteIndexPage> createState() => _NoteIndexPageState();
}

class _NoteIndexPageState extends State<NoteIndexPage> {
  @override
  Widget build(BuildContext context) {
    final _body = SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: ResponsiveValues.horizontalMargin(context)),
        child: Column(
          children: const [
            SizedBox(height: 32),
            NoteIntroduction(),
            NoteOrderSelectForm(),
            SizedBox(height: 32),
            NoteQuizListView(),
            SizedBox(height: 240),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: const EmptyAppBar(),
      body: _body,
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
