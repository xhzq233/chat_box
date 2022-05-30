import 'dart:convert';

/// chat_box - account
/// Created by xhz on 28/05/2022
class Account {
  final bool banned;
  final int id;
  final String email;
  final String name;

  String get friendlyName => name == '' ? '😋freshman' : name;
  final String? token;

  const Account({
    required this.name,
    required this.id,
    required this.email,
    required this.token,
    required this.banned,
  });

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  factory Account.fromJson(Map<String, dynamic> map) {
    return Account(name: map['Name'], id: map['ID'], email: map['Email'], token: map['Token'], banned: map['Banned']);
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'ID': id,
        'Email': email,
        'Token': token,
        'Banned': banned,
      };

  Account copyWith({String? name, String? email, String? token}) =>
      Account(name: name ?? this.name, id: id, email: email ?? this.email, token: token ?? this.token, banned: banned);
}
