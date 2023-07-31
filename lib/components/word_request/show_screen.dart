import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/word_request/list_item.dart';
import 'package:booqs_mobile/data/provider/word_request.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordRequestShowScreen extends ConsumerWidget {
  const WordRequestShowScreen({super.key, required this.wordRequestId});
  final int wordRequestId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(asyncWordRequestFamily(wordRequestId)).when(
        data: (wordRequest) {
          if (wordRequest == null) {
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
                WordRequestListItem(
                  wordRequest: wordRequest,
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
