import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/for_normal.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/for_school.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavbar extends ConsumerWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(asyncCurrentUserProvider).when(
          data: ((user) {
            final bool schoolParticipation = user?.schoolParticipation ?? false;
            if (schoolParticipation) {
              return const BottomNavbarForSchool();
            }
            return const BottomNavbarForNormal();
          }),
          error: (err, stack) => const BottomNavbarForNormal(),
          loading: () => const BottomNavbarForNormal(),
        );
  }
}
