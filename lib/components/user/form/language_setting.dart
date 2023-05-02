import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFormLanguageSetting extends ConsumerWidget {
  const UserFormLanguageSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // List<int> langNumberItems = languageCodeMap.values.toList();
    List<int> langNumberItems = [21, 44];

    return Container(
      margin: const EdgeInsets.only(top: 24),
      height: 48,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 15.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black87)),
      child: DropdownButton<int>(
        value: ref.watch(userLangNumberProvider),
        iconSize: 24,
        elevation: 16,
        onChanged: (int? newValue) async {
          if (newValue == null) return;
          ref.read(userLangNumberProvider.notifier).state = newValue;
        },
        items: langNumberItems.map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(LanguageService.getLanguageFromNumber(value),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
          );
        }).toList(),
      ),
    );
  }
}
