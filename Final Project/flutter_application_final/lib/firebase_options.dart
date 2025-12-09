// File generated manually based on your Firebase configuration.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  /// Web
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB4KHLnQyLw2WVL2c73bzgm4babPrceNXM',
    appId: '1:679395607584:web:a1f8c2e7ddeb15ef316845',
    messagingSenderId: '679395607584',
    projectId: 'yulinw-final-project',
    authDomain: 'yulinw-final-project.firebaseapp.com',
    storageBucket: 'yulinw-final-project.firebasestorage.app',
  );

  /// Android
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-8iUdajdllUSE-4HhcJlzxCzI0UvILUQ',
    appId: '1:679395607584:android:adab2254a32a8e36316845',
    messagingSenderId: '679395607584',
    projectId: 'yulinw-final-project',
    storageBucket: 'yulinw-final-project.firebasestorage.app',
  );

  /// iOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBBNv0NSxWy-A6IDrgL6n1ykO8M8ss94zc',
    appId: '1:679395607584:ios:adeb20e87105682b316845',
    messagingSenderId: '679395607584',
    projectId: 'yulinw-final-project',
    storageBucket: 'yulinw-final-project.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplicationFinal',
  );

  /// macOS — same as iOS
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBBNv0NSxWy-A6IDrgL6n1ykO8M8ss94zc',
    appId: '1:679395607584:ios:adeb20e87105682b316845',
    messagingSenderId: '679395607584',
    projectId: 'yulinw-final-project',
    storageBucket: 'yulinw-final-project.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplicationFinal',
  );
}
