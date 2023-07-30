import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SharedTimestamp extends ConsumerWidget {
  const SharedTimestamp({super.key, required this.timestamp});
  final DateTime timestamp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        DateTimeFormatter.createTimeAgoString(
            dateTime: timestamp, locale: locale),
        style: const TextStyle(
            fontSize: 12, color: Colors.black54, fontWeight: FontWeight.normal),
      ),
    );
  }
}
