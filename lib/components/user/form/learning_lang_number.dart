import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/language_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFormLearningLangNumber extends ConsumerWidget {
  const UserFormLearningLangNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // toSet で重複を削除する
    List<int> langNumberItems = cefrjLanguageCodeMap.values.toSet().toList();
    // 0は undefined なので削除する
    langNumberItems.remove(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(text: t.users.learning_lang_number),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 48,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black87)),
          child: Row(
            children: [
              Expanded(
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: ref.watch(userLearningLangNumberProvider),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (int? newValue) async {
                    if (newValue == null) return;
                    ref.read(userLearningLangNumberProvider.notifier).state =
                        newValue;
                  },
                  items:
                      langNumberItems.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(LanguageHandler.getLanguageFromNumber(value),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87)),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
