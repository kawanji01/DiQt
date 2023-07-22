import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/request_comment/item_list_view.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/request_comments.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestCommentListScreen extends ConsumerStatefulWidget {
  const RequestCommentListScreen(
      {super.key, this.wordRequest, this.sentenceRequest, this.quizRequest});
  final WordRequest? wordRequest;
  final SentenceRequest? sentenceRequest;
  final QuizRequest? quizRequest;

  @override
  RequestCommentListScreenState createState() =>
      RequestCommentListScreenState();
}

class RequestCommentListScreenState
    extends ConsumerState<RequestCommentListScreen> {
  bool _isRequesting = false;
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int? wordRequestId = widget.wordRequest?.id;
    final int? sentenceRequestId = widget.sentenceRequest?.id;
    final int? quizRequestId = widget.quizRequest?.id;

    Future<void> create() async {
      setState(() => _isRequesting = true);
      final Map<String, dynamic> params = {
        'content': _contentController.text,
        'user_id': ref.watch(currentUserProvider)?.id,
        'word_request_id': wordRequestId,
        'sentence_request_id': sentenceRequestId,
        'quiz_request_id': quizRequestId,
      };

      EasyLoading.show(status: 'loading...');
      final Map resMap = await RemoteRequestComments.create(params);
      EasyLoading.dismiss();
      setState(() => _isRequesting = false);
      if (!mounted) return;
      if (ErrorHandler.isErrorMap(resMap)) {
        return ErrorHandler.showErrorSnackBar(context, resMap);
      }
      final snackBar = SnackBar(content: Text(t.shared.create_succeeded));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
    }

    return SizedBox(
      width: double.infinity,
      height: ResponsiveValues.dialogHeight(context),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveValues.horizontalMargin(context)),
                child: RequestCommentItemListView(
                  wordRequest: widget.wordRequest,
                  sentenceRequest: widget.sentenceRequest,
                  quizRequest: widget.quizRequest,
                )),
          ),
          // submitButton(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ResponsiveValues.horizontalMargin(context),
                ),
                padding: const EdgeInsets.only(bottom: 32),
                color: Colors.white,
                child: SizedBox(
                  height: 56,
                  child: InkWell(
                      onTap: _isRequesting
                          ? null
                          : () {
                              create();
                            },
                      child: MediumGreenButton(
                        label: t.shared.update,
                        icon: Icons.settings,
                        fontSize: 18,
                      )),
                )),
          ),
        ],
      ),
    );
  }
}
