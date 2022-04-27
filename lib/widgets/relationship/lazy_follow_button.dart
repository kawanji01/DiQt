import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/relationships.dart';
import 'package:booqs_mobile/models/relationship.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/relationship/follow_button.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RelationshipLazyFollowButton extends ConsumerStatefulWidget {
  const RelationshipLazyFollowButton({Key? key, required this.user})
      : super(key: key);
  final User user;

  @override
  _RelationshipLazyFollowButtonState createState() =>
      _RelationshipLazyFollowButtonState();
}

class _RelationshipLazyFollowButtonState
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
    final Relationship? relationship = resMap['relationship'] == null
        ? null
        : Relationship.fromJson(resMap['relationship']);
    // 画面間を素早く行き来すると発生するエラーの解決 ref: https://blog.mrym.tv/2019/12/traps-on-calling-setstate-inside-initstate/
    if (mounted) {
      setState(() {
        _user = user;
        _currentUser = currentUser;
        _relationship = relationship;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null || _currentUser == null) return const LoadingSpinner();
    // 自分ならフォローボタンを表示しない
    if (_user?.id == _currentUser?.id) return Container();

    return RelationshipFollowButton(
      user: _user!,
      relationship: _relationship,
    );
  }
}
