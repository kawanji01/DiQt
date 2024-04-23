import 'package:flutter/material.dart';

// ステータスを残したまま、AppBarを消す ref: https://hondakenya.work/flutter-only-statusbar/
class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmptyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }

  @override
  Size get preferredSize => const Size(0.0, 0.0);
}
