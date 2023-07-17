import 'package:booqs_mobile/components/member_map/item_list_view.dart';
import 'package:booqs_mobile/data/provider/school.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/school.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchoolMembers extends ConsumerWidget {
  const SchoolMembers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 48),
          child: const MemberMapItemListView()),
    );
  }
}
