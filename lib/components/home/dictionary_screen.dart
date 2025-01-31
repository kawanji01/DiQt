import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/dictionary_map/search_screen.dart';
import 'package:booqs_mobile/components/dictionary_map/setting_dictionary_button.dart';
import 'package:booqs_mobile/components/layouts/drawer_menu.dart';
import 'package:booqs_mobile/components/user/lang_init_screen.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDictionaryScreen extends ConsumerStatefulWidget {
  const HomeDictionaryScreen({super.key});

  @override
  ConsumerState<HomeDictionaryScreen> createState() =>
      _HomeDictionaryScreenState();
}

class _HomeDictionaryScreenState extends ConsumerState<HomeDictionaryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return;

      if (user.langInitialized == false) {
        // すでに言語設定画面が表示されている場合は表示しない
        final isUserLangInitScreenActive =
            ModalRoute.of(context)?.settings.name == 'UserLangInitScreen';
        if (isUserLangInitScreenActive) return;
        // 言語設定画面を表示
        const screen = UserLangInitScreen();
        Dialogs.slideFromBottomFade(screen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String dictionary = t.layouts.dictionary;

    return Scaffold(
        // drawarを表示するためにtrueにする
        appBar:
            AppBarDefault(title: dictionary, automaticallyImplyLeading: true),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context),
          ),
          // child: const DictionaryMapSearchScreen(),
          child: Column(
            children: [
              // メインコンテンツ（スクロール可能）
              const Expanded(
                child: DictionaryMapSearchScreen(),
              ),
              // 設定ボタン
              const DictionaryMapSettingButton(),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavbar(),
        drawer: const DrawerMenu(),
        );
  }
}
