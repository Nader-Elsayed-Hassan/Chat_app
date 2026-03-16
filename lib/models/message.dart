class Message {
  String id;
  final String senderId;
  final String receiverId;
  final String message;
  final String dateTime;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'dateTime': dateTime,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      dateTime: map['dateTime'] as String,
    );
  }
}
