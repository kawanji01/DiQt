import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/error/scaffold_404.dart';
import 'package:booqs_mobile/components/sentence_request/show_screen.dart';
import 'package:booqs_mobile/data/provider/sentence_request.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceRequestShowPage extends ConsumerWidget {
  const SentenceRequestShowPage({super.key});

  static Future push(BuildContext context, int sentenceRequestId) async {
    return Navigator.of(context).pushNamed(
      sentenceRequestShowPage,
      arguments: {
        'sentenceRequestId': sentenceRequestId,
      },
    );
  }

  static Future pushReplacement(
      BuildContext context, int sentenceRequestId) async {
    return Navigator.of(context)
        .pushReplacementNamed(sentenceRequestShowPage, arguments: {
      'sentenceRequestId': sentenceRequestId,
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int? sentenceRequestId = args['sentenceRequestId'];
    if (sentenceRequestId == null) {
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
              ref.invalidate(asyncSentenceRequestFamily(sentenceRequestId));
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: ResponsiveValues.horizontalMargin(context)),
              child: SentenceRequestShowScreen(
                  sentenceRequestId: sentenceRequestId),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
