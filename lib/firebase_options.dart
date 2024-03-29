// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB6D0rIU0UsxDiToNAEbJ35HC1xGQqv_i8',
    appId: '1:874138930661:web:475a9a80b01df2cafdb30c',
    messagingSenderId: '874138930661',
    projectId: 'reference-point-286301',
    authDomain: 'reference-point-286301.firebaseapp.com',
    storageBucket: 'reference-point-286301.appspot.com',
    measurementId: 'G-NX6PMCQ9WH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWZxXvt-gyLlw-gYy3NvwugPzbKpJ5lZI',
    appId: '1:874138930661:android:112985d27b83b23dfdb30c',
    messagingSenderId: '874138930661',
    projectId: 'reference-point-286301',
    storageBucket: 'reference-point-286301.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCti_dQYWJ3H6iGUr6jvzh1Ia1AZvy3MiQ',
    appId: '1:874138930661:ios:d67199fe0c594a3ffdb30c',
    messagingSenderId: '874138930661',
    projectId: 'reference-point-286301',
    storageBucket: 'reference-point-286301.appspot.com',
    androidClientId: '874138930661-2o3baqfd693vqh288iig6ra4u3k97qbj.apps.googleusercontent.com',
    iosClientId: '874138930661-08qjbhrovv58l61b8f72gf83tt7j3h2v.apps.googleusercontent.com',
    iosBundleId: 'com.booqs.booqsMobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCti_dQYWJ3H6iGUr6jvzh1Ia1AZvy3MiQ',
    appId: '1:874138930661:ios:5df0166f014b5df1fdb30c',
    messagingSenderId: '874138930661',
    projectId: 'reference-point-286301',
    storageBucket: 'reference-point-286301.appspot.com',
    androidClientId: '874138930661-2o3baqfd693vqh288iig6ra4u3k97qbj.apps.googleusercontent.com',
    iosClientId: '874138930661-1s0o8qqnmhth8kkf62kt67tb5mhlckd0.apps.googleusercontent.com',
    iosBundleId: 'com.booqs.diqt',
  );
}
