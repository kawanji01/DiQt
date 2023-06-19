import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SentenceFormKeepingForm extends StatefulWidget {
  const SentenceFormKeepingForm(
      {super.key, required this.keepingFormController});
  final TextEditingController keepingFormController;

  @override
  State<SentenceFormKeepingForm> createState() =>
      _SentenceFormKeepingFormState();
}

class _SentenceFormKeepingFormState extends State<SentenceFormKeepingForm> {
  late bool _isSwitched;
  @override
  void initState() {
    super.initState();
    final String formKeepedStr = widget.keepingFormController.text;
    if (formKeepedStr == 'true') {
      _isSwitched = true;
    } else {
      _isSwitched = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: Text(t.sentences.keeping_form,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        value: _isSwitched,
        onChanged: (bool value) {
          widget.keepingFormController.text = '$value';
          setState(() {
            _isSwitched = value;
          });
        },
        secondary: const Icon(Icons.check));
  }
}
