import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SentenceFormTemperature extends StatefulWidget {
  const SentenceFormTemperature(
      {super.key, required this.temperatureController});
  final TextEditingController temperatureController;

  @override
  State<SentenceFormTemperature> createState() =>
      _SentenceFormTemperatureState();
}

class _SentenceFormTemperatureState extends State<SentenceFormTemperature> {
  double _currentSliderValue = 7;

  @override
  void initState() {
    super.initState();
    _currentSliderValue = double.parse(widget.temperatureController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        // Temperatur
        SharedItemLabel(text: t.sentences.temperature),
        const SizedBox(height: 8),
        Text(t.sentences.temperature_description,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.normal)),
        const SizedBox(height: 16),
        Slider(
          value: _currentSliderValue,
          max: 20,
          min: 0,
          divisions: 20,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            widget.temperatureController.text = '$value';
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
