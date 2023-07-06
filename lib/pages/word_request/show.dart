import 'package:booqs_mobile/components/error/scaffold_404.dart';
import 'package:booqs_mobile/components/word_request/show_screen.dart';
import 'package:booqs_mobile/data/provider/word_request.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordRequestShowPage extends ConsumerWidget {
  const WordRequestShowPage({super.key});

  static Future push(BuildContext context, int wordRequestId) async {
    return Navigator.of(context).pushNamed(
      wordRequestShowPage,
      arguments: {
        'wordRequestId': wordRequestId,
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int? wordRequestId = args['wordRequestId'];
    if (wordRequestId == null) {
      return ErrorScaffold404(appBarTitle: t.wordRequests.edit_histories);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(t.wordRequests.edit_histories),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          // キーボードが出てきた時に隠れないようにする
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: () async {
              HapticFeedback.mediumImpact();
              ref.invalidate(asyncWordRequestFamily(wordRequestId));
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: ResponsiveValues.horizontalMargin(context)),
              child: WordRequestShowScreen(wordRequestId: wordRequestId),
            ),
          ),
        ),
      ),
    );
  }
}
