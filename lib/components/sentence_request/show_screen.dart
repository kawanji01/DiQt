import 'package:booqs_mobile/components/sentence_request/list_item.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/sentence_request.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceRequestShowScreen extends ConsumerWidget {
  const SentenceRequestShowScreen({super.key, required this.sentenceRequestId});
  final int sentenceRequestId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(asyncSentenceRequestFamily(sentenceRequestId)).when(
        data: (sentenceRequest) {
          if (sentenceRequest == null) {
            return const LoadingSpinner();
          }
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveValues.horizontalMargin(context)),
              child: Column(children: <Widget>[
                const SizedBox(
                  height: 24,
                ),
                SentenceRequestListItem(
                  sentenceRequest: sentenceRequest,
                  isShow: true,
                ),
                const SizedBox(
                  height: 24,
                ),
              ]),
            ),
          );
        },
        error: (e, str) => const LoadingSpinner(),
        loading: () => const LoadingSpinner());
  }
}
