import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          CircularProgressIndicator(
            semanticsLabel: 'Linear progress indicator',
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
