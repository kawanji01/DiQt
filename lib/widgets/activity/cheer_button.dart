import 'package:booqs_mobile/data/remote/cheers.dart';
import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/cheer.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:booqs_mobile/widgets/button/small_outline_green_button.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';

class ActivityCheerButton extends StatefulWidget {
  const ActivityCheerButton({Key? key, required this.activity, this.cheer})
      : super(key: key);
  final Activity activity;
  final Cheer? cheer;

  @override
  State<ActivityCheerButton> createState() => _ActivityCheerButtonState();
}

class _ActivityCheerButtonState extends State<ActivityCheerButton> {
  Activity? _activity;
  Cheer? _cheer;
  bool _tapped = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _activity = widget.activity;
      _cheer = widget.cheer;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_activity == null) return const LoadingSpinner();

    Future<void> _createCheer() async {
      final Map? resMap = await RemoteCheers.create(_activity!.id);
      if (resMap == null) return;
      final Cheer cheer = Cheer.fromJson(resMap['cheer']);
      setState(() {
        _cheer = cheer;
      });
    }

    Widget _button() {
      // 楽観的UI
      if (_cheer != null || _tapped == true) {
        return const SmallGreenButton(
          label: '応援しました！',
          icon: Icons.favorite,
        );
      }
      return InkWell(
        onTap: () {
          setState(() {
            _tapped = true;
          });
          _createCheer();
        },
        child: const SmallOutlineGreenButton(
          label: '応援する！',
          icon: Icons.favorite,
        ),
      );
    }

    return _button();
  }
}
