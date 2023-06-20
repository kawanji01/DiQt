import 'package:booqs_mobile/components/shared/premium_recommendation.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/note.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/note/order_select_form.dart';
import 'package:booqs_mobile/components/note/quiz_list_view.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteIndexPage extends ConsumerWidget {
  const NoteIndexPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(noteIndexPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return Container();

    Widget notes() {
      if (ref.watch(premiumEnabledProvider) == false) {
        return Container(
          margin: const EdgeInsets.only(top: 48),
          child: SharedPremiumRecommendation(
              description: t.shared.premium_recommendation),
        );
      }
      return NoteQuizListView(
        // UniqueKeyを設定することで、noteOrderProvider を変更するたびに initState を発火させ、 NoteQuizListView全体を再描画する。
        key: UniqueKey(),
        order: ref.watch(noteOrderProvider),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${t.notes.notes}(${user.notesCount})'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Column(
            children: [
              const NoteOrderSelectForm(),
              const SizedBox(height: 32),
              notes(),
              const SizedBox(height: 240),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
