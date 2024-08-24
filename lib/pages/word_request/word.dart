import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/error/scaffold_404.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/word_request/word/screen.dart';
import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordRequestWordPage extends ConsumerStatefulWidget {
  const WordRequestWordPage({super.key});

  static Future push(BuildContext context, int wordId, String type) async {
    return Navigator.of(context).pushNamed(
      wordRequestWordPage,
      arguments: {
        'wordId': wordId,
        'type': type,
      },
    );
  }

  static Future pushReplacement(
      BuildContext context, int wordId, String type) async {
    return Navigator.of(context).pushReplacementNamed(
      wordRequestWordPage,
      arguments: {
        'wordId': wordId,
        'type': type,
      },
    );
  }

  @override
  WordRequestWordPageState createState() => WordRequestWordPageState();
}

class WordRequestWordPageState extends ConsumerState<WordRequestWordPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int? wordId = args['wordId'];
    final String? type = args['type'];
    if (wordId == null || type == null) {
      return ErrorScaffold404(appBarTitle: t.wordRequests.edit_histories);
    }

    return Scaffold(
      appBar: AppBarDefault(
        title: t.wordRequests.edit_histories,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          HapticFeedback.mediumImpact();
          ref.invalidate(asyncWordFamily(wordId));
        },
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: ResponsiveValues.horizontalMargin(context)),
            child: ref.watch(asyncWordFamily(wordId)).when(
                data: (word) {
                  if (word == null) {
                    return const Text('Word does not exist.');
                  }
                  return WordRequestWordScreen(word: word, type: type);
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
