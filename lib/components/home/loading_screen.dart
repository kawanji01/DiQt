import 'package:flutter/material.dart';

class HomeLoadingScreen extends StatelessWidget {
  const HomeLoadingScreen({super.key, this.error});
  final String? error;

  @override
  Widget build(BuildContext context) {
    Widget content() {
      if (error == null) {
        return const CircularProgressIndicator(
          color: Colors.white,
        );
      }
      return Text('$error',
          style: const TextStyle(color: Colors.white, fontSize: 24));
    }

    //
    return Scaffold(
      body: Container(
        color: Colors.green, // 背景色を緑に設定
        child: Center(
          child: content(),
        ),
      ),
    );
  }
}
