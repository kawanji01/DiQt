import 'package:booqs_mobile/data/remote/relationships.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/relationship.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RelationshipFollowButton extends ConsumerStatefulWidget {
  const RelationshipFollowButton(
      {super.key, required this.user, required this.relationship});
  final User user;
  final Relationship? relationship;

  @override
  RelationshipFollowButtonState createState() =>
      RelationshipFollowButtonState();
}

class RelationshipFollowButtonState
    extends ConsumerState<RelationshipFollowButton> {
  Relationship? _relationship;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _relationship = widget.relationship;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = widget.user;

    // フォロー
    Future<void> follow() async {
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteRelationships.create(user.publicUid);
      EasyLoading.dismiss();
      if (resMap == null) return;
      final Relationship relationship =
          Relationship.fromJson(resMap['relationship']);
      setState(() {
        _relationship = relationship;
      });
    }

    // フォロー解除
    Future<void> remove() async {
      if (_relationship == null) return;
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteRelationships.destroy(_relationship!);
      EasyLoading.dismiss();
      if (resMap == null) return;
      setState(() {
        _relationship = null;
      });
    }

    if (_relationship == null) {
      return InkWell(
        onTap: () {
          follow();
        },
        child: SmallOutlineGrayButton(
          label: t.users.follow,
          icon: Icons.person_add,
        ),
      );
    }

    return InkWell(
      onTap: () {
        remove();
      },
      child: SmallGreenButton(label: t.users.following, icon: Icons.person),
    );
  }
}
