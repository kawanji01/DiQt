import 'package:booqs_mobile/widgets/chapter/activity_list_view.dart';
import 'package:flutter/material.dart';

class ChapterActivities extends StatelessWidget {
  const ChapterActivities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 48),
        child: const ChapterActivityListView(),
      ),
    );
  }
}
