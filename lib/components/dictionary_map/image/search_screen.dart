import 'dart:io';

import 'package:booqs_mobile/components/dictionary_map/image/language_options.dart';
import 'package:booqs_mobile/components/dictionary_map/image/preview.dart';
import 'package:booqs_mobile/components/dictionary_map/image/uploader.dart';
import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/data/remote/azure_computer_vision.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class DictionaryMapImageSearchScreen extends StatefulWidget {
  const DictionaryMapImageSearchScreen(
      {super.key, required this.keywordController, required this.dictionary});
  final TextEditingController keywordController;
  final Dictionary dictionary;

  @override
  State<DictionaryMapImageSearchScreen> createState() =>
      _DictionaryMapImageSearchScreenState();
}

class _DictionaryMapImageSearchScreenState
    extends State<DictionaryMapImageSearchScreen> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;
  bool _isRequesting = false;
  late String _currentLocale;

  @override
  void initState() {
    super.initState();
    initCurrentLocale();
  }

  // 読み込む言語の初期化。
  void initCurrentLocale() {
    final String dictionaryLangCode = widget.dictionary.langCodeOfEntry();
    // Azure Computer visionが対応していない場合には'en'にする。
    if (azureImageAnalysisLanguages.contains(dictionaryLangCode)) {
      _currentLocale = dictionaryLangCode;
    } else {
      _currentLocale = 'en';
    }
    setState(() {
      _currentLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      if (_croppedFile != null || _pickedFile != null) {
        // Preview
        return DictionaryMapImagePreview(
          clear: _clear,
          cropImage: _cropImage,
          croppedFile: _croppedFile,
          pickedFile: _pickedFile,
          isRequesting: _isRequesting,
          ocr: _ocr,
        );
      } else {
        // Uploader
        return DictionaryMapImageUploader(
          upload: _uploadImage,
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          t.dictionaryMaps.search_by_image,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(
          height: 16,
        ),
        DictionaryMapImageLanguageOptions(
          currentLocale: _currentLocale,
          switchLang: _switchLang,
        ),
        body(),
      ],
    );
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: WebPresentStyle.dialog,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
      // crop処理
      _cropImage();
    }
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocale = selectedVal;
    });
  }

  Future<void> _ocr() async {
    if (_isRequesting == true) return;
    File image;
    if (_croppedFile != null) {
      image = File(_croppedFile!.path);
    } else if (_pickedFile != null) {
      image = File(_pickedFile!.path);
    } else {
      return;
    }
    setState(() => _isRequesting = true);
    // OCR
    EasyLoading.show(status: 'loading...');
    final String? ocrText = await AzureComputerVision.analyzeImageBinary(
        imageData: image, language: _currentLocale);
    EasyLoading.dismiss();
    if (!mounted) return;
    // エラーの場合の処理
    if (ocrText == null) {
      Toasts.showSimple(context, t.errors.error_occured);
      return setState(() {
        _isRequesting = false;
      });
    }
    widget.keywordController.text = ocrText;
    Navigator.pop(context);
  }
}
