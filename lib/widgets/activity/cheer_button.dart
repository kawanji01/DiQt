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

    Widget _cheerBtn() {
      final text = RichText(
          text: const TextSpan(children: [
        WidgetSpan(
          child: Icon(
            Icons.favorite,
            color: Colors.green,
            size: 18.0,
          ),
        ),
        TextSpan(
            text: ' 応援する！',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold))
      ]));

      return InkWell(
        onTap: () {
          setState(() {
            _tapped = true;
          });
          _createCheer();
        },
        child: SmallOutlineGreenButton(
          richText: text,
        ),
      );
    }

    Widget _cheeredBtn() {
      final text = RichText(
          text: const TextSpan(children: [
        WidgetSpan(
          child: Icon(
            Icons.favorite,
            color: Colors.white,
            size: 18.0,
          ),
        ),
        TextSpan(
            text: ' 応援しました！',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))
      ]));
      return SmallGreenButton(
        richText: text,
      );
    }

    Widget _button() {
      // 楽観的UI
      if (_cheer != null || _tapped == true) {
        return _cheeredBtn();
      }
      return _cheerBtn();
    }

    return _button();
  }
}
