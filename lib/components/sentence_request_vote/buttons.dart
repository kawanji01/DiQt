import 'package:booqs_mobile/components/sentence_request_vote/downvote_button.dart';
import 'package:booqs_mobile/components/sentence_request_vote/upvote_button.dart';
import 'package:booqs_mobile/data/remote/sentence_request_votes.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/models/sentence_request_vote.dart';
import 'package:booqs_mobile/notifications/closing_pending_request.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SentenceRequestVoteButtons extends StatefulWidget {
  const SentenceRequestVoteButtons(
      {super.key,
      required this.sentenceRequest,
      required this.sentenceRequestVote});
  final SentenceRequest sentenceRequest;
  final SentenceRequestVote? sentenceRequestVote;

  @override
  State<SentenceRequestVoteButtons> createState() =>
      SentenceRequestVoteButtonsState();
}

class SentenceRequestVoteButtonsState
    extends State<SentenceRequestVoteButtons> {
  late SentenceRequest _sentenceRequest;
  SentenceRequestVote? _vote;
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
    _sentenceRequest = widget.sentenceRequest;
    _vote = widget.sentenceRequestVote;
  }

  Future<void> _destroy(int voteId) async {
    setState(() => _isRequesting = true);
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteSentenceRequestVotes.destroy(voteId);
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
    _sentenceRequest = SentenceRequest.fromJson(resMap['sentence_request']);
    setState(() {
      _vote;
      _sentenceRequest;
    });
  }

  Future<void> _create({required bool upvoted}) async {
    setState(() => _isRequesting = true);
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteSentenceRequestVotes.create(
        sentenceRequestId: _sentenceRequest.id, upvoted: upvoted);
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
    _vote = SentenceRequestVote.fromJson(resMap['sentence_request_vote']);
    _sentenceRequest = SentenceRequest.fromJson(resMap['sentence_request']);
    setState(() {
      _vote;
      _sentenceRequest;
    });
    if (_sentenceRequest.closed()) {
      ClosingPendingRequestNotification(closed: true).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_sentenceRequest.closed()) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.wordRequests.votes_count_to_close(
              count: _sentenceRequest.votesCountToClose ?? 0),
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
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
              child: SentenceRequestVoteUpvoteButton(
                  sentenceRequest: _sentenceRequest, upvoted: _vote?.upvoted),
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
              child: SentenceRequestVoteDownvoteButton(
                  sentenceRequest: _sentenceRequest, upvoted: _vote?.upvoted),
            ),
          ],
        ),
      ],
    );
  }
}
