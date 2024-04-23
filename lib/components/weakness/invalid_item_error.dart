import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/data/provider/weakness.dart';
import 'package:booqs_mobile/data/remote/weaknesses.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessInvalidItemError extends ConsumerStatefulWidget {
  const WeaknessInvalidItemError({super.key});

  @override
  WeaknessInvalidItemErrorState createState() =>
      WeaknessInvalidItemErrorState();
}

class WeaknessInvalidItemErrorState
    extends ConsumerState<WeaknessInvalidItemError> {
  bool _isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          t.shared.error_occurred,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
        const SizedBox(
          height: 24,
        ),
        InkWell(
          onTap: _isProcessing
              ? null
              : () async {
                  setState(() {
                    _isProcessing = true;
                  });
                  EasyLoading.show(status: 'loading...');
                  await RemoteWeaknesses.destroyInvalidItems();
                  EasyLoading.dismiss();
                  ref.invalidate(asyncUnsolvedWeaknessesProvider);
                  final snackBar =
                      SnackBar(content: Text(t.shared.error_fixed));
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
          child: MediumGreenButton(
            label: t.shared.fix_error,
            fontSize: 16,
            icon: Icons.refresh,
          ),
        ),
      ],
    );
  }
}
