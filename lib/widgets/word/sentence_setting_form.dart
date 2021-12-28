import 'package:flutter/material.dart';

class SentenceSettingForm extends StatefulWidget {
  const SentenceSettingForm(
      {Key? key, required this.sentenceIdController, this.keyword})
      : super(key: key);
  final TextEditingController sentenceIdController;
  final String? keyword;

  @override
  _SentenceSettingFormState createState() => _SentenceSettingFormState();
}

class _SentenceSettingFormState extends State<SentenceSettingForm> {
  TextEditingController? sentenceIdController;
  String? keyword;
  String original = '';
  String translation = '';

  @override
  void initState() {
    super.initState();
    sentenceIdController = widget.sentenceIdController;
    keyword = widget.keyword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: sentenceIdController,
      readOnly: true,
      onTap: () => {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 480,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[],
                ),
              ),
            );
          },
        )
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
