import 'dart:io';
import 'package:booqs_mobile/components/dictionary_map/image/menu.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class DictionaryMapImagePreview extends StatelessWidget {
  const DictionaryMapImagePreview(
      {super.key,
      required this.croppedFile,
      required this.pickedFile,
      required this.clear,
      required this.cropImage,
      required this.isRequesting,
      required this.ocr});
  final void Function() clear;
  final void Function() cropImage;
  final XFile? pickedFile;
  final CroppedFile? croppedFile;
  final bool isRequesting;
  final void Function() ocr;

  @override
  Widget build(BuildContext context) {
    Widget image() {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      if (croppedFile != null) {
        final path = croppedFile!.path;
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 0.8 * screenWidth,
            maxHeight: 0.7 * screenHeight,
          ),
          child: Image.file(File(path)),
        );
      } else if (pickedFile != null) {
        final path = pickedFile!.path;
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 0.8 * screenWidth,
            maxHeight: 0.7 * screenHeight,
          ),
          child: Image.file(File(path)),
        );
      } else {
        return const SizedBox.shrink();
      }
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          DictionaryMapImageMenu(
              clear: clear, crop: cropImage, croppedFile: croppedFile),
          // 送信ボタン
          Container(
            margin: const EdgeInsets.only(top: 32, bottom: 40),
            width: MediaQuery.of(context).size.width,
            height: 48,
            child: ElevatedButton(
              onPressed: isRequesting ? null : ocr,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                t.dictionaryMaps.start_speech_recognition,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
