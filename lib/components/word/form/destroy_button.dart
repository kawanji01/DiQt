import 'package:booqs_mobile/components/shared/delete_confirmation_screen.dart';
import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/dictionary/show.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class WordFormDestroyButton extends StatefulWidget {
  const WordFormDestroyButton({super.key, required this.word});
  final Word word;

  @override
  State<WordFormDestroyButton> createState() => WordFormDestroyButtonState();
}

class WordFormDestroyButtonState extends State<WordFormDestroyButton> {
  Future<void> _submit() async {
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteWords.destroy(widget.word.id);
    EasyLoading.dismiss();
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorToast(context, resMap);
      return;
    }
    Toasts.showSimple(context, '${resMap['message']}');

    if (resMap['word'] == null) {
      DictionaryShowPage.push(context, widget.word.dictionaryId);
    } else {
      WordShowPage.push(context, widget.word.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () {
          final Widget screen = SharedDeleteConfirmationScreen(
            onDeletePressed: _submit,
          );
          Dialogs.slideFromBottomFade(screen);
        },
        icon: const Icon(
          Icons.delete,
          size: 18,
          color: Colors.red,
        ),
        label: Text(t.shared.destroy,
            style: const TextStyle(
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
