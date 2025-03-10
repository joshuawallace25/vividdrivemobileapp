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
    apiKey: 'AIzaSyBT6ghWJ0uaf_M3baYvJoB352DoWFsT0U4',
    appId: '1:573635879515:web:55940f68dd7dbd67cc957e',
    messagingSenderId: '573635879515',
    projectId: 'vividdrive-b253f',
    authDomain: 'vividdrive-b253f.firebaseapp.com',
    storageBucket: 'vividdrive-b253f.firebasestorage.app',
    measurementId: 'G-051KQBLDK9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOGCBnjU7IwB2W3R_rW6YchwbxNEmuxLw',
    appId: '1:573635879515:android:583a34ad8ccee4b7cc957e',
    messagingSenderId: '573635879515',
    projectId: 'vividdrive-b253f',
    storageBucket: 'vividdrive-b253f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDnk4qSEIa7yYDs4GZsrcCw7wbW0OGu4fQ',
    appId: '1:573635879515:ios:5c80f3fba08dc350cc957e',
    messagingSenderId: '573635879515',
    projectId: 'vividdrive-b253f',
    storageBucket: 'vividdrive-b253f.firebasestorage.app',
    iosBundleId: 'com.example.vividdrive',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDnk4qSEIa7yYDs4GZsrcCw7wbW0OGu4fQ',
    appId: '1:573635879515:ios:5c80f3fba08dc350cc957e',
    messagingSenderId: '573635879515',
    projectId: 'vividdrive-b253f',
    storageBucket: 'vividdrive-b253f.firebasestorage.app',
    iosBundleId: 'com.example.vividdrive',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBT6ghWJ0uaf_M3baYvJoB352DoWFsT0U4',
    appId: '1:573635879515:web:6a1551bd5b13ac45cc957e',
    messagingSenderId: '573635879515',
    projectId: 'vividdrive-b253f',
    authDomain: 'vividdrive-b253f.firebaseapp.com',
    storageBucket: 'vividdrive-b253f.firebasestorage.app',
    measurementId: 'G-2N40T0V8KZ',
  );
}
