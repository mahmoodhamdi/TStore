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
    apiKey: 'AIzaSyDFSQI6RIbypsOSZF2lNPQ-QE-zp6XkhGs',
    appId: '1:304668783025:web:0646e84f0d9c6b32e08d90',
    messagingSenderId: '304668783025',
    projectId: 'mahmoud-tstore',
    authDomain: 'mahmoud-tstore.firebaseapp.com',
    storageBucket: 'mahmoud-tstore.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBKR3oHvYO3lM79EVbONpy2Aa1rgKZPJaI',
    appId: '1:304668783025:android:5a263b5f78247108e08d90',
    messagingSenderId: '304668783025',
    projectId: 'mahmoud-tstore',
    storageBucket: 'mahmoud-tstore.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBKQ4wyH7wnPrAKl21fxa9iMk33GLvNlPM',
    appId: '1:304668783025:ios:41bdb917f34e2aeee08d90',
    messagingSenderId: '304668783025',
    projectId: 'mahmoud-tstore',
    storageBucket: 'mahmoud-tstore.appspot.com',
    iosClientId: '304668783025-49u5iper3c2rp65f66h2ckukta3kg7f5.apps.googleusercontent.com',
    iosBundleId: 'com.example.tStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBKQ4wyH7wnPrAKl21fxa9iMk33GLvNlPM',
    appId: '1:304668783025:ios:85608911ae66447ee08d90',
    messagingSenderId: '304668783025',
    projectId: 'mahmoud-tstore',
    storageBucket: 'mahmoud-tstore.appspot.com',
    iosClientId: '304668783025-gtd134qh0730inn6tqvnm24gut5sulft.apps.googleusercontent.com',
    iosBundleId: 'com.example.tStore.RunnerTests',
  );
}
