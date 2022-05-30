/// chat_box - api
/// Created by xhz on 28/05/2022
import 'package:http/http.dart' as http;

class Api {
  /// scheme
  static const https = 'https://';
  // static const https = 'http://';
  // static const wss = 'ws://';
  static const wss = 'wss://';

  ///domain
  // static const domain = '192.168.252.37';
  static const domain = 'xhzq.xyz';
  static const imageSecondaryDomain = 'images.';

  ///port
  static const wsPort = ':23333';

  ///ws url
  static const wssUrl = wss + domain + wsPort;
  static const loginUrl = wssUrl + login;

  ///base url
  static const baseUrl = https + domain + wsPort;
  static const imageBaseUrl = https + imageSecondaryDomain + domain;

  ///urls
  static const getImageUrl = imageBaseUrl + '/';

  ///
  static const latestVersionUrl = imageBaseUrl + version;

  static Future<String> get latestTag async => (await http.get(Uri.parse(Api.latestVersionUrl))).body;
  static String armReleaseUrl(String vTag, [bool arm64 = true]) {
    return https + domain + files + '/' + vTag + (arm64 ? Api.arm64 : Api.arm32);
  }

  //后缀
  static const register = '/register';
  static const version = '/version';
  static const code = '/code';
  static const messages = '/messages';
  static const delete = '/delete';
  static const groups = '/groups';
  static const login = '/login';
  static const account = '/account';

  static const files = '/files';
  static const arm64 = '/app-arm64-v8a-release.apk';
  static const arm32 = '/app-armeabi-v7a-release.apk';
}
