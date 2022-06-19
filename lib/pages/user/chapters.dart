import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/chapter/card_list.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserChaptersPage extends ConsumerStatefulWidget {
  const UserChaptersPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userChaptersPage);
  }

  @override
  _UserChaptersPageState createState() => _UserChaptersPageState();
}

class _UserChaptersPageState extends ConsumerState<UserChaptersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) {
        return;
      }
      ref.refresh(asyncUserChaptersProvider(user.publicUid));
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) {
      return Container();
    }

    final future = ref.watch(asyncUserChaptersProvider(user.publicUid));
    // 最終的なアウトプット
    return Scaffold(
      appBar: AppBar(
        title: const Text('参加中の教室'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: future.when(
            loading: () => const LoadingSpinner(),
            error: (err, stack) => Text('Error: $err'),
            data: (data) => ChapterCardList(chapters: data),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
