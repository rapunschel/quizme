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
    apiKey: 'AIzaSyA8rg6GPVdcmHEAA0znZ0U2GHtd3qIEWYU',
    appId: '1:122909042976:web:a3452afa56c79da81c8f45',
    messagingSenderId: '122909042976',
    projectId: 'quiz-g4',
    authDomain: 'quiz-g4.firebaseapp.com',
    storageBucket: 'quiz-g4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC0zbxmMQAosMTv2fvhg9tj-qgHjEiPrAs',
    appId: '1:122909042976:android:a3efbcfe169188551c8f45',
    messagingSenderId: '122909042976',
    projectId: 'quiz-g4',
    storageBucket: 'quiz-g4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxIsL99fOvKk5Ibd2YprHCtgFMmGksHDk',
    appId: '1:122909042976:ios:f1c7cc9c0d9983321c8f45',
    messagingSenderId: '122909042976',
    projectId: 'quiz-g4',
    storageBucket: 'quiz-g4.appspot.com',
    iosBundleId: 'com.example.firebaseLearning',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxIsL99fOvKk5Ibd2YprHCtgFMmGksHDk',
    appId: '1:122909042976:ios:9fe036a0162d646b1c8f45',
    messagingSenderId: '122909042976',
    projectId: 'quiz-g4',
    storageBucket: 'quiz-g4.appspot.com',
    iosBundleId: 'com.example.firebaseLearning.RunnerTests',
  );
}
