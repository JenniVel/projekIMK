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
    apiKey: 'AIzaSyBXOd-7ZdHk8MhU8af8yZaPJ8Zdih_fVwA',
    appId: '1:3524906210:web:75946d904a065b633b62bb',
    messagingSenderId: '3524906210',
    projectId: 'traveline-905a2',
    authDomain: 'traveline-905a2.firebaseapp.com',
    databaseURL: 'https://traveline-905a2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'traveline-905a2.appspot.com',
    measurementId: 'G-Z1GDQXEXER',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqEls1UzwNREwSO3QYq1s1TuPxFKKG3_k',
    appId: '1:3524906210:android:5ffe65dd06a758e43b62bb',
    messagingSenderId: '3524906210',
    projectId: 'traveline-905a2',
    databaseURL: 'https://traveline-905a2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'traveline-905a2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqYN63phN1iLz3bTX0lwk9K5sBpglVDJs',
    appId: '1:3524906210:ios:fbc7eca92fe14c133b62bb',
    messagingSenderId: '3524906210',
    projectId: 'traveline-905a2',
    databaseURL: 'https://traveline-905a2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'traveline-905a2.appspot.com',
    androidClientId: '3524906210-742qq9oilsq0i20s9sg5ie6q2ih2qten.apps.googleusercontent.com',
    iosClientId: '3524906210-hc9ruv4h4tg08mqrdkqcthu5281a1u39.apps.googleusercontent.com',
    iosBundleId: 'com.example.projek',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqYN63phN1iLz3bTX0lwk9K5sBpglVDJs',
    appId: '1:3524906210:ios:fbc7eca92fe14c133b62bb',
    messagingSenderId: '3524906210',
    projectId: 'traveline-905a2',
    databaseURL: 'https://traveline-905a2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'traveline-905a2.appspot.com',
    androidClientId: '3524906210-742qq9oilsq0i20s9sg5ie6q2ih2qten.apps.googleusercontent.com',
    iosClientId: '3524906210-hc9ruv4h4tg08mqrdkqcthu5281a1u39.apps.googleusercontent.com',
    iosBundleId: 'com.example.projek',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBXOd-7ZdHk8MhU8af8yZaPJ8Zdih_fVwA',
    appId: '1:3524906210:web:d64c4b69a0e15ced3b62bb',
    messagingSenderId: '3524906210',
    projectId: 'traveline-905a2',
    authDomain: 'traveline-905a2.firebaseapp.com',
    databaseURL: 'https://traveline-905a2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'traveline-905a2.appspot.com',
    measurementId: 'G-QNC16KDT77',
  );

}