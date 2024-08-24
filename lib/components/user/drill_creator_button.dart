import 'package:booqs_mobile/components/button/large_green_button.dart';
import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_browser_dialog.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';

class UserDrillCreatorButton extends StatelessWidget {
  const UserDrillCreatorButton({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 40;

    Widget createDrill() {
      const String redirectPath = 'drills/new';
      return InkWell(
        onTap: () {
          DiQtBrowserDialog.open(context, redirectPath);
        },
        child: MediumGreenButton(
          label: t.drills.create_drill,
          icon: Icons.create,
          fontSize: 18,
        ),
      );
    }

    Widget createDrillWithCSV() {
      const String redirectPath = 'drills/new_with_csv';
      return InkWell(
        onTap: () {
          DiQtBrowserDialog.open(context, redirectPath);
        },
        child: MediumGreenButton(
          label: t.drills.create_drill_with_csv,
          icon: Icons.file_upload,
          fontSize: 18,
        ),
      );
    }

    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        showModalBottomSheet(
            backgroundColor: Colors.white,
            isScrollControlled: true,
            context: context,
            // 丸み ref: https://www.codegrepper.com/code-examples/whatever/showmodalbottomsheet+rounded+corners
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
            // showModalBottomSheetで表示される中身
            builder: (context) {
              return SizedBox(
                  height: height,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              ResponsiveValues.horizontalMargin(context)),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            t.drills.create_drill,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          createDrill(),
                          const SizedBox(
                            height: 24,
                          ),
                          createDrillWithCSV(),
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ));
            });
      },
      child: LargeGreenButton(label: t.drills.create_drill, icon: Icons.create),
    );
  }
}
