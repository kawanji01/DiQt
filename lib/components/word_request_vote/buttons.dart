import 'package:booqs_mobile/components/word_request_vote/downvote_button.dart';
import 'package:booqs_mobile/components/word_request_vote/upvote_button.dart';
import 'package:booqs_mobile/data/remote/word_request_votes.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:booqs_mobile/models/word_request_vote.dart';
import 'package:booqs_mobile/notifications/closing_pending_request.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class WordRequestVoteButtons extends StatefulWidget {
  const WordRequestVoteButtons(
      {super.key, required this.wordRequest, required this.wordRequestVote});
  final WordRequest wordRequest;
  final WordRequestVote? wordRequestVote;

  @override
  State<WordRequestVoteButtons> createState() => _WordRequestVoteButtonsState();
}

class _WordRequestVoteButtonsState extends State<WordRequestVoteButtons> {
  late WordRequest _wordRequest;
  WordRequestVote? _vote;
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
    _wordRequest = widget.wordRequest;
    _vote = widget.wordRequestVote;
  }

  Future<void> _destroy(int voteId) async {
    setState(() => _isRequesting = true);
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteWordRequestVotes.destroy(voteId);
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
    _wordRequest = WordRequest.fromJson(resMap['word_request']);
    setState(() {
      _vote;
      _wordRequest;
    });
  }

  Future<void> _create({required bool upvoted}) async {
    setState(() => _isRequesting = true);
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteWordRequestVotes.create(
        wordRequestId: _wordRequest.id, upvoted: upvoted);
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
    _vote = WordRequestVote.fromJson(resMap['word_request_vote']);
    _wordRequest = WordRequest.fromJson(resMap['word_request']);
    setState(() {
      _vote;
      _wordRequest;
    });
    if (_wordRequest.closed()) {
      ClosingPendingRequestNotification(closed: true).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_wordRequest.closed()) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.wordRequests
              .votes_count_to_close(count: _wordRequest.votesCountToClose ?? 0),
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
              child: WordRequestVoteUpvoteButton(
                  wordRequest: _wordRequest, upvoted: _vote?.upvoted),
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
              child: WordRequestVoteDownvoteButton(
                  wordRequest: _wordRequest, upvoted: _vote?.upvoted),
            ),
          ],
        ),
      ],
    );
  }
}
