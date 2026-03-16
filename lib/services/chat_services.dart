import 'package:chat_application/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  static String _getChatRoomId(String user1, String user2) {
    List<String> ids = [user1, user2];
    ids.sort();
    return ids.join("_");
  }

  static Future<void> sendMessage(Message message) async {
    final String roomId = _getChatRoomId(message.senderId, message.receiverId);

    final messageDocRef = FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(roomId)
        .collection('messages')
        .doc();

    message.id = messageDocRef.id;

    await messageDocRef.set(message.toMap());
  }

  static Stream<List<Message>> getMessages({
    required String currentUserId,
    required String receiverId,
  }) {
    final String roomId = _getChatRoomId(currentUserId, receiverId);

    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Message.fromMap(doc.data()))
              .toList();
        });
  }
}
