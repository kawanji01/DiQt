import 'package:booqs_mobile/data/provider/chapter.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterSchoolDrawer extends ConsumerWidget {
  const ChapterSchoolDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) {
      return Container();
    }
    final future = ref.watch(asyncUserSchoolsProvider(user.publicUid));

    // drawerのheader
    const Widget header = DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: Text(
        '教室',
        style: TextStyle(
            color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );

    Widget tile(Chapter school) {
      return ListTile(
        title: Text(school.title, style: const TextStyle(fontSize: 16)),
        onTap: () {
          ref.read(schoolUidProvider.notifier).state = school.publicUid;
          ref.invalidate(asyncSchoolProvider);
          Navigator.of(context).pop();
        },
      );
    }

    List<Widget> drawerList(data) {
      List<Widget> list = [];
      data.forEach((school) => list.add(tile(school)));
      list.insert(0, header);
      return list;
    }

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: future.when(
          loading: () => [header, const LoadingSpinner()],
          error: (err, stack) => [header, Text('Error: $err')],
          data: (data) => drawerList(data),
        ),
      ),
    );
  }
}
