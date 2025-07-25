// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyC6K1VsE-1oZ6o7KP1qBBuX1qINInZCOgY',
    appId: '1:813650188492:web:8ce08856f4495f638c8a69',
    messagingSenderId: '813650188492',
    projectId: 'gramakart-a9d4f',
    authDomain: 'gramakart-a9d4f.firebaseapp.com',
    storageBucket: 'gramakart-a9d4f.firebasestorage.app',
    measurementId: 'G-Q67X1TEEYW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2WkadxgLEwfYy_EM3yoakdgWv30gV-g4',
    appId: '1:813650188492:android:22f253cecce9237a8c8a69',
    messagingSenderId: '813650188492',
    projectId: 'gramakart-a9d4f',
    storageBucket: 'gramakart-a9d4f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD8U4Ux9LTImSLBuztWbYyKdIK7Nl9_nyk',
    appId: '1:813650188492:ios:a48973e694bf2eeb8c8a69',
    messagingSenderId: '813650188492',
    projectId: 'gramakart-a9d4f',
    storageBucket: 'gramakart-a9d4f.firebasestorage.app',
    iosBundleId: 'com.example.newapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD8U4Ux9LTImSLBuztWbYyKdIK7Nl9_nyk',
    appId: '1:813650188492:ios:a48973e694bf2eeb8c8a69',
    messagingSenderId: '813650188492',
    projectId: 'gramakart-a9d4f',
    storageBucket: 'gramakart-a9d4f.firebasestorage.app',
    iosBundleId: 'com.example.newapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC6K1VsE-1oZ6o7KP1qBBuX1qINInZCOgY',
    appId: '1:813650188492:web:6a8e4bbcd5a67f3c8c8a69',
    messagingSenderId: '813650188492',
    projectId: 'gramakart-a9d4f',
    authDomain: 'gramakart-a9d4f.firebaseapp.com',
    storageBucket: 'gramakart-a9d4f.firebasestorage.app',
    measurementId: 'G-LD2L8TW9L8',
  );
}
