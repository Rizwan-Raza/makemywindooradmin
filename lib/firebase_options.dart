// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAivzocPB7rSLLaUMBRNsnDQpkYk1neT9U',
    appId: '1:225435076860:web:94f245c3820cd2a8b56f79',
    messagingSenderId: '225435076860',
    projectId: 'make-my-windoor',
    authDomain: 'make-my-windoor.firebaseapp.com',
    storageBucket: 'make-my-windoor.appspot.com',
    measurementId: 'G-NG164XSN2C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDLRT-yPM1xlNj9qnWAgOh9mN3qFRZ_oAo',
    appId: '1:225435076860:android:1abf0a5315801c92b56f79',
    messagingSenderId: '225435076860',
    projectId: 'make-my-windoor',
    storageBucket: 'make-my-windoor.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZOKUARGhKt8mbIg_UrEtDox48zG96JDk',
    appId: '1:225435076860:ios:9c2b25eef128b928b56f79',
    messagingSenderId: '225435076860',
    projectId: 'make-my-windoor',
    storageBucket: 'make-my-windoor.appspot.com',
    iosClientId: '225435076860-toplm16hfln9e3rfjhber101qd1djs7c.apps.googleusercontent.com',
    iosBundleId: 'com.makemywindoor.admin',
  );
}
