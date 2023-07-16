import 'package:booqs_mobile/components/school/activity_list_view.dart';
import 'package:flutter/material.dart';

class SchoolActivities extends StatelessWidget {
  const SchoolActivities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 48),
        child: const SchoolActivityListView(),
      ),
    );
  }
}
