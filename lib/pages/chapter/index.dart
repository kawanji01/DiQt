import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';

class ChapterIndexPage extends StatelessWidget {
  const ChapterIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) {
    return Navigator.of(context).pushNamed(chapterIndexPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('問題集'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Container(),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
