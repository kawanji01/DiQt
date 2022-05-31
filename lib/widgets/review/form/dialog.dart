import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/widgets/review/form/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewFormDialog extends ConsumerStatefulWidget {
  const ReviewFormDialog({Key? key, this.review}) : super(key: key);

  final Review? review;
  @override
  _ReviewFormDialogState createState() => _ReviewFormDialogState();
}

class _ReviewFormDialogState extends ConsumerState<ReviewFormDialog> {
  Review? _review;
  int _dropdownValue = 0;

  @override
  void initState() {
    super.initState();
    _review = widget.review;
    if (_review != null) {
      _dropdownValue = _review!.intervalSetting ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool _premiumEnabled = ref.watch(premiumEnabledProvider);
    // 復習設定を作成するか更新する
    Future _update() async {
      final String? token = await LocalUserInfo.authToken();
      // ログインしていないユーザーはマイページにリダイレクト
      if (token == null) {
        const snackBar = SnackBar(content: Text('復習を設定するためには、ログインが必要です。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
        return;
      }
      EasyLoading.show(status: 'loading...');
      Map? resMap;
      // reviews#update
      resMap = await RemoteReviews.update(context, _review!.id, _dropdownValue);
      EasyLoading.dismiss();
      if (resMap == null) return;

      final Review review = Review.fromJson(resMap['review']);
      await Toasts.reviewSetting(context, resMap['message']);
      // ダイアログを閉じて、reviewを返り値にする。
      Navigator.of(context).pop(review);
    }

    //
    Future _change(int? newValue) async {
      if (newValue == null) return;

      if (_premiumEnabled == false) {
        const snackBar =
            SnackBar(content: Text('復習設定を変更するにはプレミアムプランへの登録が必要です。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return PremiumPlanPage.push(context);
      }
      setState(() {
        _dropdownValue = newValue;
      });
    }

    // ドロップダウンボタンの生成
    Widget _buildDropDown() {
      return Container(
        margin: const EdgeInsets.only(top: 24),
        height: 48,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black87)),
        child: DropdownButton<int>(
          value: _dropdownValue,
          //icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          onChanged: (int? newValue) {
            _change(newValue);
          },
          items: <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(ReviewHelper.intervalSetting(value),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            );
          }).toList(),
        ),
      );
    }

    // ダイアログの中身を生成する
    Widget _buildReviewDialog() {
      return Column(
        // アラートが縦に伸びてしまうのを防ぐ、
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ReviewFormStatus(review: _review!),
          _buildDropDown(),
          const SizedBox(height: 8),
        ],
      );
    }

    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      content: _buildReviewDialog(),
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
          width: MediaQuery.of(context).size.width,
          height: 48,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity,
                  48), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
            ),
            onPressed: () => _update(),
            icon: const Icon(Icons.update, color: Colors.white),
            label: const Text(
              '設定する',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
