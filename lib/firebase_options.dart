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
    apiKey: 'AIzaSyCakusgTp8OfCtbl503xMgUBJvJC9SzxCE',
    appId: '1:922161063778:web:56bd3bbb231810b6c76e3b',
    messagingSenderId: '922161063778',
    projectId: 'jobsearchapp-3da0a',
    authDomain: 'jobsearchapp-3da0a.firebaseapp.com',
    storageBucket: 'jobsearchapp-3da0a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALC8nfMMTI9GC8iJGKQckGGzwBaSVJj2U',
    appId: '1:922161063778:android:d14668a4cbf76b4ac76e3b',
    messagingSenderId: '922161063778',
    projectId: 'jobsearchapp-3da0a',
    storageBucket: 'jobsearchapp-3da0a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdthMM_z9nQn-NYi9liHdWdSFgX6ocYEY',
    appId: '1:922161063778:ios:2859b734ffa38a5cc76e3b',
    messagingSenderId: '922161063778',
    projectId: 'jobsearchapp-3da0a',
    storageBucket: 'jobsearchapp-3da0a.appspot.com',
    iosBundleId: 'com.example.jobFinderApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdthMM_z9nQn-NYi9liHdWdSFgX6ocYEY',
    appId: '1:922161063778:ios:ad987a344f011377c76e3b',
    messagingSenderId: '922161063778',
    projectId: 'jobsearchapp-3da0a',
    storageBucket: 'jobsearchapp-3da0a.appspot.com',
    iosBundleId: 'com.example.jobFinderApp.RunnerTests',
  );
}
