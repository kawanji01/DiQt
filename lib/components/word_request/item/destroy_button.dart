import 'package:booqs_mobile/components/button/small_outline_red_button.dart';
import 'package:booqs_mobile/components/shared/delete_confirmation.dart';
import 'package:booqs_mobile/data/remote/word_requests.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:booqs_mobile/pages/word_request/show.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class WordRequestItemDestroyButton extends StatefulWidget {
  const WordRequestItemDestroyButton({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  State<WordRequestItemDestroyButton> createState() =>
      _WordRequestItemDestroyButtonState();
}

class _WordRequestItemDestroyButtonState
    extends State<WordRequestItemDestroyButton> {
  Future<void> _destroy() async {
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteWordRequests.destroy(widget.wordRequest.id);
    EasyLoading.dismiss();
    if (!mounted) return;
    Navigator.of(context).pop();
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorSnackBar(context, resMap);
      return;
    }
    final SnackBar snackBar = SnackBar(
      content: Text('${resMap['message']}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    WordRequestShowPage.pushReplacement(context, widget.wordRequest.id);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.wordRequest.closed()) return Container();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: InkWell(
        onTap: () {
          final Widget screen = SharedDeleteConfirmation(
            onDeletePressed: _destroy,
          );
          Dialogs.slideFromBottomFade(screen);
        },
        child: SmallOutlineRedButton(
            icon: Icons.delete, label: t.wordRequests.cancel),
      ),
    );
  }
}
