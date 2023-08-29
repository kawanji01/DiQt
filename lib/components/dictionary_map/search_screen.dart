import 'package:booqs_mobile/components/dictionary_map/radio_list.dart';
import 'package:booqs_mobile/components/dictionary_map/search_form.dart';
import 'package:booqs_mobile/components/user/lang_init_screen.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryMapSearchScreen extends ConsumerStatefulWidget {
  const DictionaryMapSearchScreen({super.key});

  @override
  ConsumerState<DictionaryMapSearchScreen> createState() =>
      _DictionaryMapSearchScreenState();
}

class _DictionaryMapSearchScreenState
    extends ConsumerState<DictionaryMapSearchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return;

      if (user.langInitialized == false) {
        const screen = UserLangInitScreen();
        Dialogs.slideFromBottomFade(screen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('DictionaryMapSearchScreen'),
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          const DictionaryMapSearchForm(),
          // FlutterでRenderFlex overflowedのエラーが発生するとき、それは通常、フレックスボックス（Row、Column、Flex）内のウィジェットが利用可能なスペースを超えて拡大しようとしたときに発生する。
          // この場合、画面からはみ出すフレックスボックスの小要素をExpandedをwrapすると解決できる。
          Expanded(
            child: GestureDetector(
              onTap: () {
                // キーボードを閉じる
                FocusScopeNode currentFocus = FocusScope.of(context);
                // フォーカスがすでにない状況でunfocus()を呼び出すと、エラーが発生する可能性がある
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: const DictionaryMapRadioList(),
            ),
          ),
        ],
      ),
    );
  }
}
