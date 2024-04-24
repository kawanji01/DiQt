import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';

class HomeMaintenanceScreen extends StatelessWidget {
  const HomeMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: Container(
        color: Colors.green,
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '🙇‍♂️',
                style: TextStyle(fontSize: 64),
              ),
              Text(t.home.maintenance_mode,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 16,
              ),
              Text(t.home.maintenance_description,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal)),
              const SizedBox(
                height: 24,
              ),
              TextButton(
                  onPressed: () {
                    WebPageLauncher.openByWebView(
                        'https://twitter.com/DiQt_net');
                  },
                  child: Text(
                    t.home.maintenance_latest_information,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
