/// xhzq_test - global
/// Created by xhz on 25/04/2022
import 'package:flutter/material.dart';

class Global {
  static String sender = '';
  static String token = '';
  static const https = 'https://';
  static const wss = 'wss://';
  static const wsHost = 'xhzq.xyz:23333';
  static const releasesUrl = 'xhzq.xyz/files/'; // + version tag
  static const arm64 = 'app-arm64-v8a-release.apk';
  static const arm32 = 'app-armeabi-v7a-release.apk';

  static const cbBackground = Color.fromARGB(255, 23, 23, 23);
  static const cbSendButtonBackground = Color.fromARGB(255, 44, 44, 44);
  static const cbHintMessageBackground = cbSendButtonBackground;
  static const cbOthersBubbleBackground = Color.fromARGB(255, 45, 45, 45);
  static const cbPrimaryColor = cbMyBubbleBackground;
  static const cbMyBubbleBackground = Color.fromARGB(255, 113, 243, 142);
  static const cbOnOthersBubble = Colors.white;
  static const cbOnBackground = Colors.white;
  static const cbOnMyBubble = Colors.black;
  static const cbWarning = Colors.pink;
  static const cbTextFieldBackground = Color.fromARGB(255, 27, 27, 27);
  static final cbScheme = const ColorScheme.dark().copyWith(
    primary: cbPrimaryColor,
    background: cbBackground,
    onPrimary: cbOnMyBubble,
    secondary: cbOthersBubbleBackground,
    onBackground: cbOnBackground,
    onSurface: cbOnOthersBubble,
    error: cbTextFieldBackground,
    onError: cbWarning,
  );

  static final theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: cbBackground,
    appBarTheme: const AppBarTheme(color: cbOthersBubbleBackground),
    indicatorColor: cbPrimaryColor,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          debugLabel: 'blackCupertino displayLarge',
          fontFamily: '.SF UI Display',
          color: Colors.black54,
          fontSize: 27,
          decoration: TextDecoration.none),
      displayMedium: TextStyle(
          debugLabel: 'blackCupertino displayMedium',
          fontFamily: '.SF UI Display',
          color: Colors.black54,
          fontSize: 18,
          decoration: TextDecoration.none),
      displaySmall: TextStyle(
          debugLabel: 'blackCupertino displaySmall',
          fontFamily: '.SF UI Display',
          color: Colors.black54,
          fontSize: 14,
          decoration: TextDecoration.none),
      headlineLarge: TextStyle(
          debugLabel: 'blackCupertino headlineLarge',
          fontFamily: '.SF UI Display',
          color: Colors.black54,
          fontSize: 24,
          decoration: TextDecoration.none),
      headlineMedium: TextStyle(
          debugLabel: 'blackCupertino headlineMedium',
          fontFamily: '.SF UI Display',
          color: Colors.black54,
          fontSize: 21,
          decoration: TextDecoration.none),
      headlineSmall: TextStyle(
          debugLabel: 'blackCupertino headlineSmall',
          fontFamily: '.SF UI Display',
          color: Colors.black87,
          fontSize: 16,
          decoration: TextDecoration.none),
      titleLarge: TextStyle(
          debugLabel: 'blackCupertino titleLarge',
          fontFamily: '.SF UI Display',
          color: Colors.black87,
          fontSize: 21,
          //AppBar上文字大小
          decoration: TextDecoration.none),
      titleMedium: TextStyle(
          debugLabel: 'blackCupertino titleMedium',
          fontFamily: '.SF UI Text',
          color: Colors.black87,
          fontSize: 16,
          //接近AppBar的文字大小
          decoration: TextDecoration.none),
      titleSmall: TextStyle(
          debugLabel: 'blackCupertino titleSmall',
          fontFamily: '.SF UI Text',
          color: Colors.black,
          fontSize: 15,
          decoration: TextDecoration.none),
      bodyLarge: TextStyle(
          debugLabel: 'blackCupertino bodyLarge',
          fontFamily: '.SF UI Text',
          color: Colors.black87,
          fontSize: 15,
          decoration: TextDecoration.none),
      bodyMedium: TextStyle(
          debugLabel: 'blackCupertino bodyMedium',
          fontFamily: '.SF UI Text',
          color: Colors.black87,
          fontSize: 15,
          decoration: TextDecoration.none),
      bodySmall: TextStyle(
          debugLabel: 'blackCupertino bodySmall',
          fontFamily: '.SF UI Text',
          color: Colors.black54,
          fontSize: 12,
          decoration: TextDecoration.none),
      labelLarge: TextStyle(
          debugLabel: 'blackCupertino labelLarge',
          fontFamily: '.SF UI Text',
          color: Colors.black87,
          fontSize: 16,
          //按钮上文字大小
          decoration: TextDecoration.none),
      labelMedium: TextStyle(
          debugLabel: 'blackCupertino labelMedium',
          fontFamily: '.SF UI Text',
          color: Colors.black,
          fontSize: 14,
          decoration: TextDecoration.none),
      labelSmall: TextStyle(
          debugLabel: 'blackCupertino labelSmall',
          fontFamily: '.SF UI Text',
          color: Colors.black,
          fontSize: 12,
          decoration: TextDecoration.none),
    ),
    colorScheme: cbScheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
