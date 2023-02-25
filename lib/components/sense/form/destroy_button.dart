import 'package:booqs_mobile/components/sense/form/destroy_confirmation_screen.dart';
import 'package:booqs_mobile/models/sense.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:flutter/material.dart';

class SenseFormDestroyButton extends StatelessWidget {
  const SenseFormDestroyButton({Key? key, required this.sense})
      : super(key: key);
  final Sense sense;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () {
          final Widget screen =
              SenseFormDestroyConfirmationScreen(sense: sense);
          Dialogs.slideFromBottomFade(screen);
        },
        icon: const Icon(
          Icons.delete,
          size: 18,
          color: Colors.red,
        ),
        label: const Text('削除する',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.normal)),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 0),
        ),
      ),
    );
  }
}
