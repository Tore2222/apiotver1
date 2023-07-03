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
    apiKey: 'AIzaSyCuKI0uuP1r2eQbXp1dSq-xrWAn7F8XITw',
    appId: '1:206187573588:web:16906f1708793c12e7d8c1',
    messagingSenderId: '206187573588',
    projectId: 'iotapp-fb613',
    authDomain: 'iotapp-fb613.firebaseapp.com',
    databaseURL: 'https://iotapp-fb613-default-rtdb.firebaseio.com',
    storageBucket: 'iotapp-fb613.appspot.com',
    measurementId: 'G-9MWE4ZC6EK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3qyD8HOC58D_girwSqT1jQ0_g9zAJo34',
    appId: '1:206187573588:android:bf82928f87316116e7d8c1',
    messagingSenderId: '206187573588',
    projectId: 'iotapp-fb613',
    databaseURL: 'https://iotapp-fb613-default-rtdb.firebaseio.com',
    storageBucket: 'iotapp-fb613.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnczrt9tM2Izx709omjCmEF_TAmQtoJOM',
    appId: '1:206187573588:ios:7ddf7bb2361c7b75e7d8c1',
    messagingSenderId: '206187573588',
    projectId: 'iotapp-fb613',
    databaseURL: 'https://iotapp-fb613-default-rtdb.firebaseio.com',
    storageBucket: 'iotapp-fb613.appspot.com',
    iosBundleId: 'com.example.clonetaxi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnczrt9tM2Izx709omjCmEF_TAmQtoJOM',
    appId: '1:206187573588:ios:7ddf7bb2361c7b75e7d8c1',
    messagingSenderId: '206187573588',
    projectId: 'iotapp-fb613',
    databaseURL: 'https://iotapp-fb613-default-rtdb.firebaseio.com',
    storageBucket: 'iotapp-fb613.appspot.com',
    iosBundleId: 'com.example.clonetaxi',
  );
}
