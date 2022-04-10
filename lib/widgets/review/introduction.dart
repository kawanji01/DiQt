import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewIntroduction extends ConsumerWidget {
  const ReviewIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget _introduction() {
      return const Text('復習すべき問題はありません',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black87));
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 64.0, left: 24, right: 24),
      child: _introduction(),
    );
  }
}
