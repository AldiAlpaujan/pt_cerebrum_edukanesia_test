import 'package:aldi_test/interface/iname.dart';

class User extends IName {
  final int id;
  final String username;
  final String email;
  final String phone;
  final String password;

  String get initial => getInitialName(username);

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      password: map['pw'],
    );
  }
}
