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
    apiKey: 'AIzaSyAOEE10QCaAiYHHtWt2iVKOLohPUEAKW00',
    appId: '1:437111373823:web:24d3f29b56ee5d7df771ca',
    messagingSenderId: '437111373823',
    projectId: 'litlore-62236',
    authDomain: 'litlore-62236.firebaseapp.com',
    storageBucket: 'litlore-62236.firebasestorage.app',
    measurementId: 'G-K3NF59WXZZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdEEDS7OjYRMHqCVgJIWFzQook4jmzCuM',
    appId: '1:437111373823:android:4a1077f7e61b1f2ef771ca',
    messagingSenderId: '437111373823',
    projectId: 'litlore-62236',
    storageBucket: 'litlore-62236.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOzYZvV6l7dujCx6tpeSwbw3uDk-DKerc',
    appId: '1:437111373823:ios:9b3b60e0e08da856f771ca',
    messagingSenderId: '437111373823',
    projectId: 'litlore-62236',
    storageBucket: 'litlore-62236.firebasestorage.app',
    iosBundleId: 'com.example.litlore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAOzYZvV6l7dujCx6tpeSwbw3uDk-DKerc',
    appId: '1:437111373823:ios:9b3b60e0e08da856f771ca',
    messagingSenderId: '437111373823',
    projectId: 'litlore-62236',
    storageBucket: 'litlore-62236.firebasestorage.app',
    iosBundleId: 'com.example.litlore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAOEE10QCaAiYHHtWt2iVKOLohPUEAKW00',
    appId: '1:437111373823:web:bcedc800f85981f7f771ca',
    messagingSenderId: '437111373823',
    projectId: 'litlore-62236',
    authDomain: 'litlore-62236.firebaseapp.com',
    storageBucket: 'litlore-62236.firebasestorage.app',
    measurementId: 'G-ED9CVK4BB2',
  );
}
