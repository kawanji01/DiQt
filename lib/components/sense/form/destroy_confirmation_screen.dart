import 'package:booqs_mobile/data/remote/senses.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sense.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SenseFormDestroyConfirmationScreen extends StatefulWidget {
  const SenseFormDestroyConfirmationScreen({super.key, required this.sense});
  final Sense sense;

  @override
  State<SenseFormDestroyConfirmationScreen> createState() =>
      _SenseFormDestroyConfirmationScreenState();
}

class _SenseFormDestroyConfirmationScreenState
    extends State<SenseFormDestroyConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    final Sense sense = widget.sense;
    final int wordId = sense.wordId;

    Future submit() async {
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteSenses.destroy(sense.id);
      EasyLoading.dismiss();
      if (!context.mounted) return;
      if (resMap == null) return;
      final snackBar = SnackBar(content: Text(resMap['message']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      WordShowPage.pushReplacement(context, wordId);
    }

    final submitButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        minimumSize: const Size(double.infinity,
            40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
      ),
      onPressed: () {
        submit();
      },
      icon: const Icon(Icons.delete, color: Colors.white),
      label: Text(
        t.senses.destroy,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
      ),
    );

    return Container(
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.senses.confirm_destroy,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          const SizedBox(height: 16),
          Text(t.senses.confirm_destroy_message,
              style: TextStyle(fontSize: 16, color: Colors.black87)),
          const SizedBox(height: 32),
          submitButton
        ],
      )),
    );
  }
}
