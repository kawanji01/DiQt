import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:booqs_mobile/components/word_request/item/edit_target_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';

class WordRequestItemEditTargetButton extends StatelessWidget {
  const WordRequestItemEditTargetButton({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final Word? word = wordRequest.word;
    if (word == null) {
      return Container();
    }
    word.dictionary = wordRequest.dictionary;
    return InkWell(
        child: SmallOutlineGrayButton(
          label: t.wordRequests.target,
          icon: null,
        ),
        onTap: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              // 丸める
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
              ),
              builder: (context) {
                return Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ResponsiveValues.horizontalMargin(context),
                      vertical: 32),
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  // 80%の高さで表示させる
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: WordRequestItemEditTargetScreen(
                        wordRequest: wordRequest),
                  ),
                );
              });
        });
  }
}
