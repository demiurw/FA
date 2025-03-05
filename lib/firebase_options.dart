import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOS - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1xHxkmwYljQ4ANts36Z6Q8d8m9CT8bGM',
    appId: '1:858689639966:android:ec1c83933789264967400f',
    messagingSenderId: '858689639966',
    projectId: 'financial-aid-firebase',
    storageBucket: 'financial-aid-firebase.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDtyW1HBHINno2seYUR7V4D7o8iFJaFT_I',
    appId: '1:858689639966:web:cb981a66a033df5767400f',
    messagingSenderId: '858689639966',
    projectId: 'financial-aid-firebase',
    authDomain: 'financial-aid-firebase.firebaseapp.com',
    storageBucket: 'financial-aid-firebase.firebasestorage.app',
    measurementId: 'G-XW2Z4YCLBL',
  );

  // Web configuration
}