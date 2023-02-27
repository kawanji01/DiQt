import 'package:booqs_mobile/models/sense.dart';
import 'package:booqs_mobile/utils/diqt_browser_dialog.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class SenseSenseRequestsButton extends StatelessWidget {
  const SenseSenseRequestsButton({Key? key, required this.sense})
      : super(key: key);
  final Sense sense;

  @override
  Widget build(BuildContext context) {
    Widget acceptedSenseRequestsButton() {
      final String redirectPath = 'senses/${sense.id}/accepted_sense_requests';
      return InkWell(
          onTap: () {
            DiQtBrowserDialog.open(context, redirectPath);
          },
          child: SmallOutlineGrayButton(
            icon: Icons.history,
            label: '意味の改善履歴（${sense.acceptedSenseRequestsCount}）',
          ));
    }

    Widget pendingSenseRequestsButton() {
      if (sense.pendingSenseRequestsCount == 0) return Container();

      final String redirectPath = 'senses/${sense.id}/pending_sense_requests';
      return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: () {
          DiQtBrowserDialog.open(context, redirectPath);
        },
        child: Text(
          '${sense.pendingSenseRequestsCount}件の審査中の編集',
          style: const TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [acceptedSenseRequestsButton(), pendingSenseRequestsButton()],
    );
  }
}
