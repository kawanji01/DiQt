import 'package:booqs_mobile/components/button/small_outline_red_button.dart';
import 'package:booqs_mobile/components/shared/delete_confirmation.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/quiz_requests.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/pages/quiz_request/show.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizRequestItemDestroyButton extends ConsumerStatefulWidget {
  const QuizRequestItemDestroyButton({super.key, required this.quizRequest});
  final QuizRequest quizRequest;

  @override
  QuizRequestItemDestroyButtonState createState() =>
      QuizRequestItemDestroyButtonState();
}

class QuizRequestItemDestroyButtonState
    extends ConsumerState<QuizRequestItemDestroyButton> {
  Future<void> _destroy() async {
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteQuizRequests.destroy(widget.quizRequest.id);
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
    QuizRequestShowPage.pushReplacement(context, widget.quizRequest.id);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.quizRequest.closed()) return Container();

    final int? userId = widget.quizRequest.user?.id;
    final int? currentUserId = ref.watch(currentUserProvider)?.id;
    if (userId != currentUserId) return Container();

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
