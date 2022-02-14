import 'package:booqs_mobile/main.dart';
import 'package:catcher/catcher.dart';

class CatcherService {
  static setup() {
    /// STEP 1. Create catcher configuration.
    /// Debug configuration with dialog report mode and console handler. It will show dialog and once user accepts it, error will be shown   /// in console.
    CatcherOptions debugOptions =
        CatcherOptions(DialogReportMode(), [ConsoleHandler()]);

    /// Release configuration. Same as above, but once user accepts dialog, user will be prompted to send email with crash to support.
    CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
      EmailManualHandler(["kawanji01@gmail.com"])
    ]);

    /// STEP 2. Pass your root widget (MyApp) along with Catcher configuration:
    Catcher(
        rootWidget: const MyApp(),
        debugConfig: debugOptions,
        releaseConfig: releaseOptions);
  }
}
