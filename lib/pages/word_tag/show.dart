import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/word_tag/show_screen.dart';
import 'package:booqs_mobile/data/provider/word_tag.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordTagShowPage extends ConsumerStatefulWidget {
  const WordTagShowPage({super.key});

  // メモ：遷移の処理は、いちいち描き直す必要はないので、createStateの上に置く。
  static Future push(BuildContext context, int wordTagId) async {
    return Navigator.of(context)
        .pushNamed(wordTagShowPage, arguments: {'wordTagId': wordTagId});
  }

  @override
  WordShowPageState createState() => WordShowPageState();
}

class WordShowPageState extends ConsumerState<WordTagShowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int wordId = arguments['wordTagId'];
      ref.invalidate(asyncWordTagFamily(wordId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int wordTagId = arguments['wordTagId'];
    final future = ref.watch(asyncWordTagFamily(wordTagId));

    return Scaffold(
      appBar: AppBarDefault(
        title: future.when(
          data: (wordTag) => wordTag?.name ?? '',
          error: (err, stack) => 'Error',
          loading: () => '',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          HapticFeedback.mediumImpact();
          ref.invalidate(asyncWordTagFamily(wordTagId));
        },
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: ResponsiveValues.horizontalMargin(context)),
            child: future.when(
              data: (wordTag) => WordTagShowScreen(wordTag: wordTag),
              error: (err, stack) => Text('Error: $err'),
              loading: () => LoadingSpinner(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
