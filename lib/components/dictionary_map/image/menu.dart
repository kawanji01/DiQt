import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class DictionaryMapImageMenu extends StatelessWidget {
  const DictionaryMapImageMenu(
      {super.key,
      required this.clear,
      required this.crop,
      required this.croppedFile});

  final void Function() clear;
  final void Function() crop;
  final CroppedFile? croppedFile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: clear,
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          tooltip: 'Delete',
          child: const Icon(Icons.delete),
        ),
        if (croppedFile == null)
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              onPressed: crop,
              backgroundColor: const Color(0xFFBC764A),
              tooltip: 'Crop',
              child: const Icon(Icons.crop),
            ),
          )
      ],
    );
  }
}
