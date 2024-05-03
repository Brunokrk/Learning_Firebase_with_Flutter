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
    apiKey: 'AIzaSyAh5hINWE1LRSbH5ifMPuMF-cjOkabSlLc',
    appId: '1:770099825476:web:e374ad4c7dbfd89c642511',
    messagingSenderId: '770099825476',
    projectId: 'studying-firebase-fef61',
    authDomain: 'studying-firebase-fef61.firebaseapp.com',
    databaseURL: 'https://studying-firebase-fef61-default-rtdb.firebaseio.com',
    storageBucket: 'studying-firebase-fef61.appspot.com',
    measurementId: 'G-HGB19H6B11',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQUSHvPRd4ndUWgn9Ns7xT6tyEkaf3Ato',
    appId: '1:770099825476:android:170f24168d1fba80642511',
    messagingSenderId: '770099825476',
    projectId: 'studying-firebase-fef61',
    databaseURL: 'https://studying-firebase-fef61-default-rtdb.firebaseio.com',
    storageBucket: 'studying-firebase-fef61.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnq4ImmaP9zguQI_KNey0HkAF2fsKlfhk',
    appId: '1:770099825476:ios:126bf6a54f974afb642511',
    messagingSenderId: '770099825476',
    projectId: 'studying-firebase-fef61',
    databaseURL: 'https://studying-firebase-fef61-default-rtdb.firebaseio.com',
    storageBucket: 'studying-firebase-fef61.appspot.com',
    iosBundleId: 'com.example.listingTasksApp',
  );

}