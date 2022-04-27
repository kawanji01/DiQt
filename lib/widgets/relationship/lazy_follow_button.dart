import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/relationships.dart';
import 'package:booqs_mobile/models/relationship.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:booqs_mobile/widgets/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RelationshipLazyFollowButton extends ConsumerStatefulWidget {
  const RelationshipLazyFollowButton({Key? key, required this.user})
      : super(key: key);
  final User user;

  @override
  _RelationShipLazyFollowButtonState createState() =>
      _RelationShipLazyFollowButtonState();
}

class _RelationShipLazyFollowButtonState
    extends ConsumerState<RelationshipLazyFollowButton> {
  User? _user;
  User? _currentUser;
  Relationship? _relationship;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _user = widget.user;
      _currentUser = ref.watch(currentUserProvider);
      if (_user == null || _currentUser == null) return;
      _loadRelationship(_user!, _currentUser!);
    });
  }

  // relashionshipを取得する
  Future<void> _loadRelationship(User user, User currentUser) async {
    final Map? resMap = await RemoteRelationships.find(_user!.publicUid);
    if (resMap == null) return;
    final Relationship relationship =
        Relationship.fromJson(resMap['relationship']);
    setState(() {
      _user = user;
      _currentUser = currentUser;
      _relationship = relationship;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null || _currentUser == null) return Container();

    // フォロー
    Future<void> _follow() async {
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteRelationships.create(_user!.publicUid);
      EasyLoading.dismiss();
      if (resMap == null) return;

      final Relationship relationship =
          Relationship.fromJson(resMap['relationship']);
      setState(() {
        _relationship = relationship;
      });
    }

    // フォロー解除
    Future<void> _remove() async {
      if (_relationship == null) return;
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteRelationships.destroy(_relationship!);
      EasyLoading.dismiss();
      if (resMap == null) return;
      setState(() {
        _relationship = null;
      });
    }

    Widget _followButton() {
      final richText = RichText(
          text: const TextSpan(children: [
        WidgetSpan(
          child: Icon(
            Icons.person_add,
            color: Colors.black87,
            size: 18.0,
          ),
        ),
        TextSpan(
            text: ' フォローする',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold))
      ]));
      return InkWell(
        onTap: () {
          _follow();
        },
        child: SmallOutlineGrayButton(
          richText: richText,
        ),
      );
    }

    Widget _removeButton(relationship) {
      final richText = RichText(
          text: const TextSpan(children: [
        WidgetSpan(
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 18.0,
          ),
        ),
        TextSpan(
            text: ' フォロー中',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))
      ]));
      return InkWell(
        onTap: () {
          _remove();
        },
        child: SmallGreenButton(
          richText: richText,
        ),
      );
    }

    if (_relationship == null) {
      return _followButton();
    }

    return _removeButton(_relationship);
  }
}
