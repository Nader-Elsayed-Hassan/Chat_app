class RegisteredUser {
  final String id;
  final String email;
  RegisteredUser({required this.id, required this.email});

  factory RegisteredUser.fromMap(Map<String, dynamic> map) =>
      RegisteredUser(id: map['id'], email: map['email']);

  Map<String, dynamic> toMap() => {'id': id, 'email': email};
}
