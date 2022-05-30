import 'package:chat_box/model/account.dart';

/// chat_box - group
/// Created by xhz on 28/05/2022

class Group {
  final int id;
  final String name;
  final List<Account> accounts;

  const Group({required this.name, required this.id, required this.accounts});

  factory Group.fromJson(Map json) {
    return Group(name: json['Name'], id: json['ID'], accounts: [for (final i in json['Accounts']) Account.fromJson(i)]);
  }
}
