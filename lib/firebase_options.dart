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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBsu8hNAdSKju74B5gnVHlEWyLLaP1KRDk',
    appId: '1:508441591692:web:3b6f72d1e9a65925a0a0a9',
    messagingSenderId: '508441591692',
    projectId: 'fanana-dev',
    authDomain: 'fanana-dev.firebaseapp.com',
    databaseURL: 'https://fanana-dev-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fanana-dev.appspot.com',
    measurementId: 'G-CHE2MXVB5Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCr0oxSoB2UrHmvmWOAiXRN_y-1mx3oukM',
    appId: '1:508441591692:android:39296fa7b3b32a84a0a0a9',
    messagingSenderId: '508441591692',
    projectId: 'fanana-dev',
    databaseURL: 'https://fanana-dev-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fanana-dev.appspot.com',
  );
}
