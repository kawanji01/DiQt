import 'dart:io';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/data/remote/azure_text_to_speech.dart';
import 'package:path_provider/path_provider.dart';
import 'package:booqs_mobile/data/remote/langs.dart';

class WordFormSSML extends StatefulWidget {
  const WordFormSSML(
      {super.key,
      required this.ssmlController,
      required this.entryController,
      required this.dictionary});
  final TextEditingController ssmlController;
  final TextEditingController entryController;
  final Dictionary dictionary;

  @override
  WordFormSSMLState createState() => WordFormSSMLState();
}

class WordFormSSMLState extends State<WordFormSSML> {
  late final AudioPlayer _player;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playPreview() async {
    if (_isPlaying) return;
    setState(() => _isPlaying = true);
    final ssml = widget.ssmlController.text.trim();
    if (ssml.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SSMLを入力してください')),
      );
      setState(() => _isPlaying = false);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('音声を生成しています...')),
    );
    final result = await AzureTextToSpeech.synthesizeSSML(ssml);
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final audioBytes = result['audioBytes'];
    final error = result['error'];
    if (audioBytes == null) {
      // print('AzureTTS error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('音声の生成に失敗しました: $error')),
      );
      setState(() => _isPlaying = false);
      return;
    }
    // 一時ファイルに保存して再生
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/azure_tts_preview.mp3');
    await tempFile.writeAsBytes(audioBytes, flush: true);
    if (!mounted) return;
    await _player.play(DeviceFileSource(tempFile.path));
    setState(() => _isPlaying = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SSMLとは？リンク
        Row(
          children: [
            SharedItemLabel(text: '${t.words.entry_ssml} '),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: () async {
                const url =
                    'https://cloud.google.com/text-to-speech/docs/ssml?hl=ja';
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
              icon:
                  const Icon(Icons.help_outline, size: 16, color: Colors.green),
              label: const Text(
                'SSMLの書き方',
                style: TextStyle(fontSize: 12, color: Colors.green),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // SSML入力欄
        TextField(
          controller: widget.ssmlController,
          maxLines: 6,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: '<speak> ... </speak>',
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 8),
        // プレビューボタンとテンプレート生成リンク
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _playPreview,
              icon: const Icon(Icons.volume_up, color: Colors.white),
              label: const Text('プレビュー',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () async {
                final langCode = widget.dictionary.langCodeOfEntry();
                final text = widget.entryController.text;
                EasyLoading.show(status: 'loading...');
                final res = await RemoteLangs.getSsmlTemplate(
                    langCode: langCode, text: text);
                EasyLoading.dismiss();
                if (!context.mounted) return;
                if (res == null || res['ssml'] == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('テンプレートの取得に失敗しました')),
                  );
                  return;
                }
                setState(() {
                  widget.ssmlController.text = res['ssml'];
                });
              },
              child: const Text(
                'テンプレートを生成する',
                style: TextStyle(
                  color: Colors.green,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.green,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
