import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/note/order_select_form.dart';
import 'package:booqs_mobile/components/note/quiz_list_view.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteIndexPage extends ConsumerWidget {
  const NoteIndexPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(noteIndexPage);
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(noteIndexPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return Container();
    return Scaffold(
      appBar: const EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Row(children: [
                const Icon(
                  Icons.note_alt_outlined,
                  color: Colors.black,
                  size: 36.0,
                ),
                const SizedBox(width: 4),
                Text('${t.notes.notes}(${user.notesCount})',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold))
              ]),
              const NoteOrderSelectForm(),
              const SizedBox(height: 32),
              const NoteQuizListView(),
              const SizedBox(height: 240),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
