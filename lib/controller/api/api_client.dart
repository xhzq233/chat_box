/// pinpin_1037 - api_client
/// Created by xhz on 2022/1/18.
import 'dart:convert';

import 'package:chat_box/controller/account/account_controller.dart';
import 'package:chat_box/model/account.dart';
import 'package:chat_box/model/group.dart';
import 'package:chat_box/model/message.dart';
import 'package:chat_box/utils/toast.dart';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../utils/loading.dart';
import 'api.dart';

class ApiClient {
  static late final Dio _dio = createDio();

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      ///不添加其他的，response就是json
      baseUrl: Api.baseUrl,
      receiveTimeout: 15000,
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      Loading.show();
      if (AccountController.shared.haveAccount) {
        options.headers['Authorization'] = AccountController.shared.mainAccount?.token;
        options.headers['ID'] = AccountController.shared.mainAccount?.id;
      }
      log('REQUEST[${options.method}] => PATH: ${options.path}');
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      Loading.hide();
      log('RESPONSE[${response.statusCode}] => DATA: ${response.data} ');
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      Loading.hide();
      if (e.response == null) {
        toast('network unavailable');
        return handler.reject(e);
      }
      final String msg = e.response!.data;
      final int statusCode = e.response!.statusCode!;
      final String text;
      if (statusCode == 400) {
        text = msg;
      } else if (statusCode == 401) {
        text = 'OAuth err:$msg';
      } else if (statusCode == 404) {
        text = '404 page not found';
      } else if (statusCode == 500) {
        text = '操作出错:$msg';
      } else if (statusCode == 504) {
        text = '无应答:$msg';
      } else {
        text = 'Unknown Exception:$msg';
      }
      toast(text);
      log(text);
      handler.reject(e);
    }));

    return dio;
  }

  static Future<List<ChatMessage>> getMessageListBefore(DateTime time, int inGroup) async {
    final response = await _dio.get(
      Api.messages + '?history=${time.toIso8601String()}&id=$inGroup',
    );
    final data = <ChatMessage>[];
    log(response.data.runtimeType.toString());
    for (dynamic i in jsonDecode(response.data)) {
      data.add(ChatMessage.fromJson(i));
    }
    return data;
  }

  ///delete message
  static Future<void> deleteMessage(int id) async {
    await _dio.get(Api.delete + '?delete=$id');
  }

  /// group操作
  static Future<List<Group>> getAllGroups() async {
    final response = await _dio.get(
      Api.groups,
    );
    final data = <Group>[];
    for (dynamic i in jsonDecode(response.data)) {
      data.add(Group.fromJson(i));
    }
    return data;
  }

  static Future<List<Group>> getAccountGroups() async {
    final response = await _dio.get(Api.groups + '?id=0'); //todo
    final data = <Group>[];
    for (dynamic i in jsonDecode(response.data)) {
      data.add(Group.fromJson(i));
    }
    return data;
  }

  static Future<void> joinGroup(int id) async {
    await _dio.put(Api.groups + '?id=$id');
  }

  static Future<void> createGroup(int id, String name) async {
    await _dio.post(Api.groups + '?id=$id&name=$name');
  }

  static Future<void> leaveGroup(int id) async {
    await _dio.delete(Api.groups + '?id=$id');
  }

  ///account

  ///也可用于异地登陆刷新token
  static Future<void> register(String email, String code) async {
    final j = await _dio.get(Api.register + '?email=$email&code=$code');
    AccountController.shared.saveAccount(Account.fromJson(jsonDecode(j.data)));
  }

  static Future<void> sendCode(String email) async {
    await _dio.get(Api.code + '?email=$email');
  }

  static Future<void> changeAccountName(String name) async {
    await _dio.put(Api.account + '?name=$name');
    AccountController.shared.changeMainAccountName(name);
  }
}
