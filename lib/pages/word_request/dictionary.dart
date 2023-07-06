import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/error/scaffold_404.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/word_request/dictionary/screen.dart';
import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordRequestDictionaryPage extends ConsumerStatefulWidget {
  const WordRequestDictionaryPage({super.key});

  static Future push(
      BuildContext context, int dictionaryId, String type) async {
    return Navigator.of(context).pushNamed(
      wordRequestDictionaryPage,
      arguments: {
        'dictionaryId': dictionaryId,
        'type': type,
      },
    );
  }

  @override
  WordRequestDictionaryPageState createState() =>
      WordRequestDictionaryPageState();
}

class WordRequestDictionaryPageState
    extends ConsumerState<WordRequestDictionaryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int? dictionaryId = args['dictionaryId'];
    final String? type = args['type'];
    if (dictionaryId == null || type == null) {
      return ErrorScaffold404(appBarTitle: t.wordRequests.edit_histories);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t.wordRequests.edit_histories),
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            HapticFeedback.mediumImpact();
            ref.invalidate(asyncDictionaryFamily(dictionaryId));
          },
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: ResponsiveValues.horizontalMargin(context)),
            child: ref.watch(asyncDictionaryFamily(dictionaryId)).when(
                data: (dictionary) {
                  if (dictionary == null) {
                    return const Text('Dictionary does not exist.');
                  }
                  return WordRequestDictionaryScreen(
                      dictionary: dictionary, type: type);
                },
                error: (e, str) => Text('error:$e'),
                loading: () => const LoadingSpinner()),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
