import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AuthManager with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late final ValueNotifier<bool> isInitialized = ValueNotifier(false);
  late SharedPreferences prefs;
  late User user;
  bool isSignedIn = false;

  Future<void> saveUser(User user) async {
    prefs.setString('user', user.toMap().toString());
  }

  // Retrieve user data from SharedPreferences
  Future<User> getUser() async {
    String? userString = prefs.getString('user');

    if (userString != null) {
      // Convert the stored string back to a map
      Map<String, String> userMap = Map.fromEntries(
        userString
            .replaceAll(RegExp(r'[{}]'), '')
            .split(', ')
            .map((e) => MapEntry(e.split(': ')[0], e.split(': ')[1])),
      );
      return User.fromMap(userMap);
    }

    return User(uid: '1111', name: 'Code Hub', mail: 'codehub@gmail.com', image: '');
  }

  AuthManager() {
    // Initialize authentication status when the class is instantiated
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      // Check if the user is already signed in
      isSignedIn = await _googleSignIn.isSignedIn();
      prefs = await SharedPreferences.getInstance();
      if(isSignedIn){
        user = await getUser();
        print('User is already signed in with ${user!.uid}');
      }

    } catch (e) {
      // Log or handle the error appropriately
      debugPrint("Error initializing AuthManager: $e");
    } finally {
      // Notify listeners and set initialized flag
      isInitialized.value = true;
      notifyListeners();
    }
  }

  Future<void> signIn() async {
    try {
      // Trigger Google Sign-In
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        isSignedIn = true;
        user = User(
            uid: account.id,
            name: account.displayName ?? 'Code Hub',
            mail: account.email,
            image: account.photoUrl ?? ''
        );
        saveUser(user);
        notifyListeners();
      } else {
        // User canceled the sign-in process
        debugPrint("Sign-in canceled by user.");
      }
    } catch (e) {
      // Log or handle sign-in error
      debugPrint("Error during sign-in: $e");
    }
  }

  Future<void> signOut() async {
    try {
      // Trigger Google Sign-Out
      await _googleSignIn.signOut();
      isSignedIn = false;
      prefs.clear();
      notifyListeners();
    } catch (e) {
      // Log or handle sign-out error
      debugPrint("Error during sign-out: $e");
    }
  }
}
