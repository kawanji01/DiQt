import 'package:booqs_mobile/components/achievement/got_medal.dart';
import 'package:booqs_mobile/components/achievement/locked_medal.dart';
import 'package:booqs_mobile/models/achievement.dart';
import 'package:flutter/material.dart';

class AchievementTile extends StatelessWidget {
  const AchievementTile(
      {super.key,
      required this.achievements,
      required this.gotMedalIds,
      required this.width});
  final List<Achievement> achievements;
  final List<int> gotMedalIds;
  final double width;

  Widget _medal(Achievement? achievement) {
    if (achievement == null) {
      return Container();
    }
    if (gotMedalIds.contains(achievement.id)) {
      return AchievementGotMedal(achievement: achievement, width: width);
    }
    return AchievementLockedMedal(
      achievement: achievement,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> medalWidgetList = <Widget>[];
    for (Achievement? achievement in achievements) {
      medalWidgetList.add(_medal(achievement));
    }
    return Wrap(alignment: WrapAlignment.center, children: medalWidgetList);
  }
}
