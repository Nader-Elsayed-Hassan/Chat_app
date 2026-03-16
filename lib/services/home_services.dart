import 'package:chat_application/models/registered_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeServices {
  static const String collectionName = 'users';
  static Stream<List<RegisteredUser>> getUsers() {
    final usersSnapshot = FirebaseFirestore.instance
        .collection(collectionName)
        .where('id', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return usersSnapshot.map((snapshot) {
      return snapshot.docs
          .map((doc) => RegisteredUser.fromMap(doc.data()))
          .toList();
    });
  }
}
