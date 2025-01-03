import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        hintColor: Colors.green,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
      ),
      child: const Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            CircularProgressIndicator(
              semanticsLabel: 'Linear progress indicator',
              color: Colors.green,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
