class User {
  final int? id;
  final String email;
  final String username;
  final String password;

  User({
    this.id,
    required this.email,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, username: $username, password: $password}';
  }
}
