import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/widgets/answer_setting/screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillIntroduction extends ConsumerWidget {
  const DrillIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Drill? drill = ref.watch(drillProvider);
    if (drill == null) return Container();

    Future<void> _moveToAnswerSetting() async {
      // bottomSheetを表示するときにインタラクションも消しておく
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        // 丸み ref: https://www.codegrepper.com/code-examples/whatever/showmodalbottomsheet+rounded+corners
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        // showModalBottomSheetで表示される中身
        builder: (context) => const AnswerSettingScreen(
          primary: 'answerSetting',
        ),
      );
      //print('end');
      ref.refresh(asyncDrillUnsolvedQuizzesProvider);
    }

    final title = Text(
      drill.title,
      style: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
    );

    final image = CachedNetworkImage(
      imageUrl: drill.imageUrl,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );

    final settingButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        primary: const Color(0xfff3f3f4),
      ),
      onPressed: () => {
        _moveToAnswerSetting()
        //AnswerSettingEdit.pushModal(context)
      },
      icon: const Icon(
        Icons.settings,
        color: Colors.black54,
      ),
      label: const Text(
        ' 解答設定',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),
      ),
    );

    return Column(
      children: [
        title,
        const SizedBox(height: 8),
        image,
        const SizedBox(height: 16),
        settingButton,
      ],
    );
  }
}
