import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class NoItemsFoundIndicator extends StatelessWidget {
  const NoItemsFoundIndicator({super.key, required this.itemName});
  final String itemName;

  @override
  Widget build(BuildContext context) {
    final String text = t.shared.no_items_found(name: itemName);
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 32),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black54),
        ));
  }
}
