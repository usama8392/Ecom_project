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
    apiKey: 'AIzaSyAsb3bkvQqh8j64KUWBvOYguAO7s_3nzGs',
    appId: '1:624354168773:web:f6efb62a3e565a4b4005ac',
    messagingSenderId: '624354168773',
    projectId: 'fyp-neww',
    authDomain: 'fyp-neww.firebaseapp.com',
    storageBucket: 'fyp-neww.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqy6mV82sS9wSSK5zVwCH9Fejc0klFd0s',
    appId: '1:624354168773:android:837582256e15bc7e4005ac',
    messagingSenderId: '624354168773',
    projectId: 'fyp-neww',
    storageBucket: 'fyp-neww.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCzibN7bxJgvfbR4XkbF4ZC-LPBKPj2sSA',
    appId: '1:624354168773:ios:017950c2d247d7114005ac',
    messagingSenderId: '624354168773',
    projectId: 'fyp-neww',
    storageBucket: 'fyp-neww.firebasestorage.app',
    iosBundleId: 'com.example.newFyp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCzibN7bxJgvfbR4XkbF4ZC-LPBKPj2sSA',
    appId: '1:624354168773:ios:017950c2d247d7114005ac',
    messagingSenderId: '624354168773',
    projectId: 'fyp-neww',
    storageBucket: 'fyp-neww.firebasestorage.app',
    iosBundleId: 'com.example.newFyp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAsb3bkvQqh8j64KUWBvOYguAO7s_3nzGs',
    appId: '1:624354168773:web:54945baaa87ee7154005ac',
    messagingSenderId: '624354168773',
    projectId: 'fyp-neww',
    authDomain: 'fyp-neww.firebaseapp.com',
    storageBucket: 'fyp-neww.firebasestorage.app',
  );

}