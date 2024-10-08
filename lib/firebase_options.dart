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
    apiKey: 'AIzaSyDlNIAByPkxoTVu_eM5wnPHgekMqyuvBk0',
    appId: '1:346716165610:web:1658ef046696f285e98e93',
    messagingSenderId: '346716165610',
    projectId: 'k3posapp',
    authDomain: 'k3posapp.firebaseapp.com',
    storageBucket: 'k3posapp.appspot.com',
    measurementId: 'G-P3HYN0JFPY',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXogoxaE1JjvRRqA2_4cUdsXhRxKYEImU',
    appId: '1:346716165610:ios:dcca03171b70e5b1e98e93',
    messagingSenderId: '346716165610',
    projectId: 'k3posapp',
    storageBucket: 'k3posapp.appspot.com',
    iosBundleId: 'com.example.oderApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCXogoxaE1JjvRRqA2_4cUdsXhRxKYEImU',
    appId: '1:346716165610:ios:dcca03171b70e5b1e98e93',
    messagingSenderId: '346716165610',
    projectId: 'k3posapp',
    storageBucket: 'k3posapp.appspot.com',
    iosBundleId: 'com.example.oderApplication',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDlNIAByPkxoTVu_eM5wnPHgekMqyuvBk0',
    appId: '1:346716165610:web:ac3292241daccb5ce98e93',
    messagingSenderId: '346716165610',
    projectId: 'k3posapp',
    authDomain: 'k3posapp.firebaseapp.com',
    storageBucket: 'k3posapp.appspot.com',
    measurementId: 'G-ER6B7FLVE8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYqBbEXFxIqQf-3DOry4CcJmp-GWOZ7EY',
    appId: '1:346716165610:android:51070acc0474d61fe98e93',
    messagingSenderId: '346716165610',
    projectId: 'k3posapp',
    storageBucket: 'k3posapp.appspot.com',
  );

}