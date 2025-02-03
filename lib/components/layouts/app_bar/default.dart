import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDefault({
    super.key,
    this.title,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.centerTitle = true, 
  });
  final String? title;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;

// AppBarの高さを設定する
  double toolbarHeight(bottom) {
    if (bottom == null) {
      return kToolbarHeight;
    } else {
      return kToolbarHeight + bottom.preferredSize.height;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title == null ? null : Text('$title'),
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: const Color.fromRGBO(76, 175, 80, 1),
      foregroundColor: Colors.white,
      actionsIconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
      ),
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight(bottom));
}
