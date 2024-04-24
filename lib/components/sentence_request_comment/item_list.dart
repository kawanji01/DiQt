import 'package:booqs_mobile/components/sentence_request_comment/item.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/sentence_request.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceRequestCommentItemList extends ConsumerWidget {
  const SentenceRequestCommentItemList(
      {super.key, required this.sentenceRequest});
  final SentenceRequest sentenceRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(asyncSentenceRequestCommentsFamily(sentenceRequest.id))
        .when(
          // これをfalseにしないと、削除時に最後の項目が削除され、中間部の削除ができなくなる。
          skipLoadingOnRefresh: false,
          data: (sentenceRequestComments) {
            final int commentsCount = sentenceRequestComments.length;
            return Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${t.wordRequests.comments}($commentsCount)',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                // スプレッド演算子(...)でListを展開する
                ...sentenceRequestComments
                    .map((sentenceRequestComment) => SentenceRequestCommentItem(
                          sentenceRequestComment: sentenceRequestComment,
                        )),
                const SizedBox(height: 140),
              ],
            );
          },
          error: (err, str) => Text(err.toString()),
          loading: () => const LoadingSpinner(),
        );
  }
}
