import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String password;
  final String email;
  final String token;
  const User({
    this.id = 0,
    this.username = '',
    this.password = '',
    this.email = '',
    this.token = '',
  });

  @override
  List<Object?> get props => [
        id,
        username,
        password,
        email,
        token,
      ];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'token': token,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) => User(
        id: map['id'] ?? 0,
        username: map['username'] ?? '',
        password: map['password'] ?? '',
        email: map['email'] ?? '',
        token: map['token'] ?? '',
      );

  User copyWith({
    int? id,
    String? username,
    String? password,
    String? email,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }
}
