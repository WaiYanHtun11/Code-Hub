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
    apiKey: 'AIzaSyClBI9FYeony36MX7ErwV6hgy_-wIfM25U',
    appId: '1:711482219919:web:8e0ab30a8fff10ec39bffa',
    messagingSenderId: '711482219919',
    projectId: 'code-hub-c933b',
    authDomain: 'code-hub-c933b.firebaseapp.com',
    databaseURL: 'https://code-hub-c933b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'code-hub-c933b.firebasestorage.app',
    measurementId: 'G-3302R5XS07',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUZFvQLRRmhtDxZug7hl1j7DFqibssHhw',
    appId: '1:711482219919:android:2be20be5a032687239bffa',
    messagingSenderId: '711482219919',
    projectId: 'code-hub-c933b',
    databaseURL: 'https://code-hub-c933b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'code-hub-c933b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3_MsFgRQplpzstVy7TFV3O55UAs7FAOc',
    appId: '1:711482219919:ios:9e0ba9897906cadd39bffa',
    messagingSenderId: '711482219919',
    projectId: 'code-hub-c933b',
    databaseURL: 'https://code-hub-c933b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'code-hub-c933b.firebasestorage.app',
    androidClientId: '711482219919-djdo28mjied45h4nuo970ik4nl81emvq.apps.googleusercontent.com',
    iosClientId: '711482219919-ivg11cudmedca3qojqbjo8cpn7mqmob3.apps.googleusercontent.com',
    iosBundleId: 'com.waiyanhtun.codehub',
  );

}