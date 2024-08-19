import 'package:booqs_mobile/components/custom_section/show_screen.dart';
import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/data/provider/custom_sections.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/custom_section.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSectionShowPage extends ConsumerWidget {
  const CustomSectionShowPage({Key? key}) : super(key: key);

  // メモ：遷移の処理は、いちいち描き直す必要はないので、createStateの上に置く。
  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(customSectionShowPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomSection? customSection = ref.watch(customSectionProvider);
    if (customSection == null) {
      return Scaffold(
        appBar: const AppBarDefault(
          title: '404 not found',
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 32),
            child: Text(t.errors.http_status_404),
          ),
        ),
        bottomNavigationBar: const BottomNavbar(),
      );
    }

    return Scaffold(
      appBar: const AppBarDefault(),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context),
        ),
        child: CustomSectionShowScreen(customSection: customSection),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
