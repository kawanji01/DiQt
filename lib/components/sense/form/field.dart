import 'package:booqs_mobile/components/sense/form/destroy_button.dart';
import 'package:booqs_mobile/components/sense/form/gloss.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/data/provider/sense.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SenseFormField extends ConsumerStatefulWidget {
  const SenseFormField(
      {super.key,
      required this.senseControllerMap,
      required this.number,
      required this.last});
  final Map<String, TextEditingController> senseControllerMap;
  final int number;
  final bool last;

  @override
  SenseFormFieldState createState() => SenseFormFieldState();
}

class SenseFormFieldState extends ConsumerState<SenseFormField> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController senseIdController =
        widget.senseControllerMap['id']!;
    final TextEditingController glossController =
        widget.senseControllerMap['gloss']!;
    final TextEditingController sentenceIdController =
        widget.senseControllerMap['sentence_id']!;
    final TextEditingController destroyController =
        widget.senseControllerMap['_destroy']!;
    if (destroyController.text == 'true') {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        SharedItemLabel(text: '${t.senses.sense}(${widget.number})'),
        const SizedBox(
          height: 16,
        ),
        SenseFormGloss(glossController: glossController),
        //SentenceSetting(sentenceIdController: sentenceIdController, entry: entry, posTagIdController: posTagIdController, dictionary: dictionary),
        SenseFormDestroyButton(onPressed: () {
          final String senseIdStr = senseIdController.text;
          if (senseIdStr == '') {
            // 画面から消す。
            ref.read(senseControllerMapListProvider.notifier).removeLast();
          } else {
            // DBに存在する（IDが存在する）senseに削除フラグをつける
            final int senseId = int.parse(senseIdStr);
            ref
                .read(senseControllerMapListProvider.notifier)
                .destroy(senseId: senseId);
          }
          Navigator.pop(context);
        }),
      ],
    );
  }
}
