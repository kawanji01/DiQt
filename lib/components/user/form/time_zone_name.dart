import 'package:booqs_mobile/consts/time_zone.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/time_zone_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/item_label.dart';

class UserFormTimeZoneName extends ConsumerWidget {
  const UserFormTimeZoneName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(text: t.users.time_zone_name),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 48,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 15.0, right: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black87)),
          child: DropdownButton<String>(
            value: ref.watch(userTimeZoneNameProvider),
            iconSize: 24,
            elevation: 16,
            onChanged: (String? newValue) async {
              if (newValue == null) return;
              ref.read(userTimeZoneNameProvider.notifier).state = newValue;
            },
            items: timeZoneNames.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(TimeZoneHandler.nameToI18n(value),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
