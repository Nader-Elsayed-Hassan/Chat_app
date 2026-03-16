import 'package:chat_application/models/registered_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  final String email;
  final String password;
  static const String userCollection = "users";

  AuthServices({required this.email, required this.password});

  Future<void> signin(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Login error")));
    }
  }

  Future<void> signUp(BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({'id': credential.user!.uid, 'email': credential.user!.email});
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);

      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Register error")));
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> saveNewUser(RegisteredUser user) async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(user.id)
        .set(user.toMap());
  }
}
