import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/grammatical_tag.dart';
import 'package:flutter/material.dart';

class GrammaticalTagSelectSheet extends StatefulWidget {
  final List<GrammaticalTag> allTags;
  final List<int> selectedTagIds;
  const GrammaticalTagSelectSheet({
    super.key,
    required this.allTags,
    required this.selectedTagIds,
  });

  @override
  State<GrammaticalTagSelectSheet> createState() =>
      _GrammaticalTagSelectSheetState();
}

class _GrammaticalTagSelectSheetState extends State<GrammaticalTagSelectSheet> {
  late List<int> tempSelected;

  @override
  void initState() {
    super.initState();
    tempSelected = List<int>.from(widget.selectedTagIds);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(t.grammaticalTags.grammatical_tag_select,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView(
                children: widget.allTags.map((tag) {
                  final selected = tempSelected.contains(tag.id);
                  return CheckboxListTile(
                    value: selected,
                    title: Text(tag.name),
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          tempSelected.add(tag.id);
                        } else {
                          tempSelected.remove(tag.id);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(tempSelected);
                  },
                  child: Text(t.shared.save,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
