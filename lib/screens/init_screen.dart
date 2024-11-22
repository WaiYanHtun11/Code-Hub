import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../managers/auth_manager.dart';
import 'auth_screen.dart';
import 'home_screen.dart';
class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  Widget build(BuildContext context) {

    return Consumer<AuthManager>(
        builder: (context,authManager,child){
          return ValueListenableBuilder<bool>(
            valueListenable: authManager.isInitialized,
            builder: (context, isInitialized, _) {
              if (!isInitialized) {
                return Scaffold(
                  body: Center(child: Image.asset('assets/images/codehub.png',width: 100,)),
                );
              }

              return authManager.isSignedIn ? HomeScreen(user : authManager.user) : const AuthScreen();

            },
          );
        }
    );
  }
}
