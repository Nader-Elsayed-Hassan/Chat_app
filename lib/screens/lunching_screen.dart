import 'package:chat_application/screens/auth_screen.dart';
import 'package:chat_application/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LunchingScreen extends StatelessWidget {
  const LunchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return const Scaffold(body: Center(child: AuthScreen()));
        }
      },
    );
  }
}
