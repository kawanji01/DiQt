import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:booqs_mobile/data/remote/langs.dart';
import 'package:booqs_mobile/data/remote/azure_text_to_speech.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';

class SharedSsmlForm extends StatefulWidget {
  const SharedSsmlForm({
    super.key,
    required this.ssmlController,
    required this.textController,
    required this.dictionary,
    required this.label,
  });
  final TextEditingController ssmlController;
  final TextEditingController textController;
  final Dictionary dictionary;
  final String label;

  @override
  State<SharedSsmlForm> createState() => _SharedSsmlFormState();
}

class _SharedSsmlFormState extends State<SharedSsmlForm> {
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
        SnackBar(content: Text(t.shared.please_enter(name: 'SSML'))),
      );
      setState(() => _isPlaying = false);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.shared.processing)),
    );
    final result = await AzureTextToSpeech.synthesizeSSML(ssml);
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final audioBytes = result['audioBytes'];
    final error = result['error'];
    if (audioBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${t.shared.error_occurred}: $error')),
      );
      setState(() => _isPlaying = false);
      return;
    }
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
        Row(
          children: [
            SharedItemLabel(text: widget.label),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: () async {
                const url =
                    'https://abundant-galliform-71d.notion.site/SSML-de4b05d1f73741488803faa3dd5c1af7';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
              icon:
                  const Icon(Icons.help_outline, size: 16, color: Colors.green),
              label: Text(
                t.shared.how_to_write_ssml,
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
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _playPreview,
              icon: const Icon(Icons.volume_up, color: Colors.white),
              label: Text(t.shared.audio_preview,
                  style: const TextStyle(
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
                final text = widget.textController.text;
                EasyLoading.show(status: 'loading...');
                final res = await RemoteLangs.getSsmlTemplate(
                    langCode: langCode, text: text);
                EasyLoading.dismiss();
                if (!context.mounted) return;
                if (res == null || res['ssml'] == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        t.shared.ssml_template_generation_failed,
                      ),
                    ),
                  );
                  return;
                }
                setState(() {
                  widget.ssmlController.text = res['ssml'];
                });
              },
              child: Text(
                t.shared.generate_template,
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
