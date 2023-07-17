import 'package:booqs_mobile/components/shared/cache_network_image.dart';
import 'package:booqs_mobile/consts/images.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/school.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/school.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchoolDrawer extends ConsumerWidget {
  const SchoolDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) {
      return Container();
    }
    final School? school = ref.watch(schoolProvider);
    if (school == null) {
      return Container();
    }

    // drawerのheader
    final Widget header = DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
      child: SharedCacheNetworkImage(url: school.thumbnailUrl ?? diqtNoImage),
    );

    Widget tile(School school) {
      return ListTile(
        title: Text(school.name, style: const TextStyle(fontSize: 16)),
        onTap: () {
          ref.read(schoolProvider.notifier).state = school;
          ref.invalidate(asyncSchoolProvider);
          ref.invalidate(asynSchoolChaptersProvider);
          Navigator.of(context).pop();
        },
      );
    }

    List<Widget> drawerList(List<School> schools) {
      List<Widget> list = [];
      for (var school in schools) {
        list.add(tile(school));
      }
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
        children: ref.watch(asyncUserSchoolsProvider(user.publicUid)).when(
              data: (schools) => drawerList(schools),
              loading: () => [header, const LoadingSpinner()],
              error: (err, stack) => [header, Text('Error: $err')],
            ),
      ),
    );
  }
}
