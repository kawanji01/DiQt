import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const <Widget>[
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
