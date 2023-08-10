import 'package:booqs_mobile/components/quiz_request_vote/downvote_button.dart';
import 'package:booqs_mobile/components/quiz_request_vote/upvote_button.dart';
import 'package:booqs_mobile/data/remote/quiz_request_vote.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/models/quiz_request_vote.dart';
import 'package:booqs_mobile/notifications/closing_pending_request.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class QuizRequestVoteButtons extends StatefulWidget {
  const QuizRequestVoteButtons(
      {super.key, required this.quizRequest, required this.quizRequestVote});
  final QuizRequest quizRequest;
  final QuizRequestVote? quizRequestVote;

  @override
  State<QuizRequestVoteButtons> createState() => QuizRequestVoteButtonsState();
}

class QuizRequestVoteButtonsState extends State<QuizRequestVoteButtons> {
  late QuizRequest _quizRequest;
  QuizRequestVote? _vote;
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
    _quizRequest = widget.quizRequest;
    _vote = widget.quizRequestVote;
  }

  Future<void> _destroy(int voteId) async {
    setState(() => _isRequesting = true);
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteQuizRequestVotes.destroy(voteId);
    EasyLoading.dismiss();
    setState(() => _isRequesting = false);
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      return ErrorHandler.showErrorSnackBar(context, resMap,
          serverSideMessage: true);
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(content: Text(resMap['message']));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    _vote = null;
    _quizRequest = QuizRequest.fromJson(resMap['quiz_request']);
    setState(() {
      _vote;
      _quizRequest;
    });
  }

  Future<void> _create({required bool upvoted}) async {
    setState(() => _isRequesting = true);
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteQuizRequestVotes.create(
        quizRequestId: _quizRequest.id, upvoted: upvoted);
    EasyLoading.dismiss();
    setState(() => _isRequesting = false);
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      return ErrorHandler.showErrorSnackBar(context, resMap,
          serverSideMessage: true);
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(content: Text(resMap['message']));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    _vote = QuizRequestVote.fromJson(resMap['quiz_request_vote']);
    _quizRequest = QuizRequest.fromJson(resMap['quiz_request']);
    setState(() {
      _vote;
      _quizRequest;
    });
    if (_quizRequest.closed()) {
      ClosingPendingRequestNotification(closed: true).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget decisionCondtion() {
      if (_quizRequest.closed()) {
        return Container();
      }
      return Text(
        t.wordRequests
            .votes_count_to_close(count: _quizRequest.votesCountToClose ?? 0),
        style: const TextStyle(fontSize: 14, color: Colors.black54),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        decisionCondtion(),
        const SizedBox(height: 4),
        Row(
          children: [
            InkWell(
              onTap: () {
                if (_isRequesting) return;
                if (_vote?.upvoted == true) {
                  _destroy(_vote!.id);
                } else {
                  _create(upvoted: true);
                }
              },
              child: QuizRequestVoteUpvoteButton(
                  quizRequest: _quizRequest, upvoted: _vote?.upvoted),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {
                if (_isRequesting) return;
                if (_vote?.upvoted == false) {
                  _destroy(_vote!.id);
                } else {
                  _create(upvoted: false);
                }
              },
              child: QuizRequestVoteDownvoteButton(
                  quizRequest: _quizRequest, upvoted: _vote?.upvoted),
            ),
          ],
        ),
      ],
    );
  }
}
