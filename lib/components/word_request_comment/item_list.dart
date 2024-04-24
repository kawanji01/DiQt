import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/word_request_comment/item.dart';
import 'package:booqs_mobile/data/provider/word_request.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordRequestCommentItemList extends ConsumerWidget {
  const WordRequestCommentItemList({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(asyncWordRequestCommentsFamily(wordRequest.id)).when(
          // これをfalseにしないと、削除時に最後の項目が削除され、中間部の削除ができなくなる。
          skipLoadingOnRefresh: false,
          data: (wordRequestComments) {
            final int commentsCount = wordRequestComments.length;
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
                ...wordRequestComments
                    .map((wordRequestComment) => WordRequestCommentItem(
                          wordRequestComment: wordRequestComment,
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
