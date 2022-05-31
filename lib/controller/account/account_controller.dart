/// chat_box - account_controller
/// Created by xhz on 28/05/2022
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:chat_box/utils/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/account.dart';
import '../../utils/toast.dart';
import '../api/api.dart';

class AccountController {
  static const spKey = 'account';
  static AccountController? _controller;

  static AccountController get shared {
    _controller ??= AccountController._();
    return _controller!;
  }

  AccountController._();

  late final SharedPreferences _sp;
  WebSocket? socket;

  final List<Account> _accounts = [];

  List<Account>? get otherAccounts {
    if (_accounts.length <= 1) {
      return null;
    } else {
      return _accounts.sublist(1);
    }
  }

  Account? get mainAccount {
    if (_accounts.isEmpty) {
      return null;
    } else {
      return _accounts.first;
    }
  }

  bool get isOnline => socket?.readyState == WebSocket.open;

  bool get haveAccount => mainAccount != null;

  Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
    if (_sp.containsKey(spKey)) {
      for (final i in _sp.getStringList(spKey)!) {
        _accounts.add(Account.fromJson(jsonDecode(i)));
      }
    }
  }

  void changeMainAccount(int accountID) {
    final index = indexOf(accountID);
    if (index == -1) {
      throw 'No Such Account';
    }
    final a = _accounts.removeAt(index);
    _accounts.insert(0, a);
    _updateAccountList();
  }

  void changeMainAccountName(String name) {
    final newAccount = mainAccount!.copyWith(name: name);
    _accounts.removeAt(0);
    saveAccount(newAccount);
  }

  void saveAccount(Account account) {
    _accounts.insert(0, account);
    _updateAccountList();
  }

  int indexOf(int accountID) {
    for (int i = 0; i < _accounts.length; ++i) {
      if (accountID == _accounts[i].id) {
        return i;
      }
    }
    toast('no such account');
    log('no such account');
    return -1;
  }

  void removeAccount(int accountID) {
    final index = indexOf(accountID);
    if (index == -1) {
      throw 'No Such Account';
    }
    _accounts.removeAt(index);
    _updateAccountList();
  }

  Future<void> _updateAccountList() async =>
      await _sp.setStringList(spKey, _accounts.map((e) => jsonEncode(e.toJson())).toList());

  bool _logging = false;

  Future<bool> login() async {
    if (_logging) return false;
    _logging = true;
    if (isOnline) {
      log('Already Online');
      return false;
    }
    Loading.show();
    bool res = false;
    try {
      socket =
          await WebSocket.connect(Api.loginUrl, headers: {'Authorization': mainAccount?.token, "ID": mainAccount?.id});
      res = true;
    } catch (e) {
      log(e.toString());
      res = false;
    }
    Loading.hide();
    _logging = false;
    return res;
  }
}
