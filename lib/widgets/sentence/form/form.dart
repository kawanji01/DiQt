import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/sentence/form/preview_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceForm extends ConsumerStatefulWidget {
  const SentenceForm(
      {Key? key,
      required this.originalController,
      required this.translationController,
      required this.explanationController,
      required this.dictionary})
      : super(key: key);
  final TextEditingController originalController;
  final TextEditingController translationController;
  final TextEditingController explanationController;
  final Dictionary dictionary;

  @override
  _SentenceFormState createState() => _SentenceFormState();
}

class _SentenceFormState extends ConsumerState<SentenceForm> {
  TextEditingController? _originalController;
  TextEditingController? _translationController;
  TextEditingController? _explanationController;

  @override
  void initState() {
    super.initState();
    _originalController = widget.originalController;
    _translationController = widget.translationController;
    _explanationController = widget.explanationController;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 例文フォーム
        TextFormField(
          controller: _originalController,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          decoration:
              const InputDecoration(labelText: "例文", hintText: '例文を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return '例文は空欄にできません。';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        // 翻訳フォーム
        TextFormField(
          controller: _translationController,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          decoration: const InputDecoration(
              labelText: "例文の訳", hintText: '例文の訳を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return '例文の翻訳は空欄にできません。';
            }
            return null;
          },
        ),
        const SizedBox(height: 40),
        // 解説フォーム
        TextFormField(
          // 複数行のフォーム。 参考： https://stackoverflow.com/questions/54972928/how-to-expand-a-textfield-in-flutter-looks-like-a-text-area
          minLines: 8,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _explanationController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '解説',
            hintText: '【空欄可】解説があれば入力してください。',
          ),
        ),
        SentenceFormPreviewButton(
            originalController: _originalController!,
            translationController: _translationController!,
            explanationController: _explanationController!,
            dictionary: widget.dictionary)
      ],
    );
  }
}
