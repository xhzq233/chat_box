/// xhzq_test - global
/// Created by xhz on 25/04/2022
import 'package:chat_box/utils/loading.dart';
import 'package:chat_box/utils/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static const cbBackground = Color.fromARGB(255, 23, 23, 23);
  static const cbOthersBubbleBackground = cbSecondaryBackground;
  static const cbAppBar = cbSecondaryBackground;
  static const cbSecondaryBackground = Color.fromARGB(255, 45, 45, 45);
  static const cbPrimaryColor = cbMyBubbleBackground;
  static const cbMyBubbleBackground = Color.fromARGB(255, 113, 243, 142);
  static const cbOnOthersBubble = cbOnBackground;
  static const cbOnBackground = Colors.white;

  static const cbOnMyBubble = Colors.black;
  static const cbWarning = Colors.pink;
  static const tsWarning = TextStyle(color: cbWarning);
  static const cbTextFieldBackground = Color.fromARGB(255, 27, 27, 27);

  static final cbDarkScheme = const ColorScheme.dark().copyWith(
    primary: cbPrimaryColor,
    surface: cbOnMyBubble,
    background: cbBackground,
    onPrimary: cbOnMyBubble,
    secondary: cbOthersBubbleBackground,
    onBackground: cbOnBackground,
    onSurface: cbOnOthersBubble,
    error: cbTextFieldBackground,
    onError: cbWarning,
  );

  static final cbLightScheme = const ColorScheme.light().copyWith(
    primary: cbPrimaryColor,
  );
  static const textTheme = TextTheme(
    displayLarge: TextStyle(
        debugLabel: 'blackCupertino displayLarge',
        fontFamily: '.SF UI Display',
        color: Colors.white70,
        fontSize: 27,
        decoration: TextDecoration.none),
    displayMedium: TextStyle(
        debugLabel: 'blackCupertino displayMedium',
        fontFamily: '.SF UI Display',
        color: Colors.white70,
        fontSize: 18,
        decoration: TextDecoration.none),
    displaySmall: TextStyle(
        debugLabel: 'blackCupertino displaySmall',
        fontFamily: '.SF UI Display',
        color: Colors.white60,
        fontSize: 14,
        decoration: TextDecoration.none),
    headlineLarge: TextStyle(
        debugLabel: 'blackCupertino headlineLarge',
        fontFamily: '.SF UI Display',
        color: Colors.white,
        fontSize: 24,
        decoration: TextDecoration.none),
    headlineMedium: TextStyle(
        debugLabel: 'blackCupertino headlineMedium',
        fontFamily: '.SF UI Display',
        color: Colors.white60,
        fontSize: 21,
        decoration: TextDecoration.none),
    headlineSmall: TextStyle(
        debugLabel: 'blackCupertino headlineSmall',
        fontFamily: '.SF UI Display',
        color: Colors.white,
        fontSize: 16,
        decoration: TextDecoration.none),
    titleLarge: TextStyle(
        debugLabel: 'blackCupertino titleLarge',
        fontFamily: '.SF UI Display',
        color: Colors.white60,
        fontSize: 21,
        //AppBar上文字大小
        decoration: TextDecoration.none),
    titleMedium: TextStyle(
        debugLabel: 'blackCupertino titleMedium',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        //list tile title
        fontSize: 16,
        //接近AppBar的文字大小
        decoration: TextDecoration.none),
    titleSmall: TextStyle(
        debugLabel: 'blackCupertino titleSmall',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        fontSize: 15,
        decoration: TextDecoration.none),
    bodyLarge: TextStyle(
        debugLabel: 'blackCupertino bodyLarge',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        fontSize: 15,
        decoration: TextDecoration.none),
    bodyMedium: TextStyle(
        //body
        debugLabel: 'blackCupertino bodyMedium',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        fontSize: 15,
        decoration: TextDecoration.none),
    bodySmall: TextStyle(
        debugLabel: 'blackCupertino bodySmall',
        fontFamily: '.SF UI Text',
        color: Colors.white54,
        //list tile subtitle
        fontSize: 12,
        decoration: TextDecoration.none),
    labelLarge: TextStyle(
        debugLabel: 'blackCupertino labelLarge',
        fontFamily: '.SF UI Text',
        color: Colors.white70,
        fontSize: 16,
        //按钮上文字大小
        decoration: TextDecoration.none),
    labelMedium: TextStyle(
        debugLabel: 'blackCupertino labelMedium',
        fontFamily: '.SF UI Text',
        color: Colors.white38,
        fontSize: 14,
        decoration: TextDecoration.none),
    labelSmall: TextStyle(
        debugLabel: 'blackCupertino labelSmall',
        fontFamily: '.SF UI Text',
        color: Colors.white38,
        fontSize: 12,
        decoration: TextDecoration.none),
  );

  static const lightTextTheme = TextTheme(
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
  );

  static final darkTheme = ThemeData.dark().copyWith(
    canvasColor: cbAppBar,
    cardColor: Colors.black45,
    scaffoldBackgroundColor: cbBackground,
    appBarTheme: const AppBarTheme(color: cbAppBar),
    indicatorColor: cbPrimaryColor,
    textTheme: textTheme,
    colorScheme: cbDarkScheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static const cbLightBackground = Colors.white;

  static final lightTheme = ThemeData.light().copyWith(
    cardColor: cbPrimaryColor,
    indicatorColor: cbPrimaryColor,
    primaryColor: Colors.grey,
    scaffoldBackgroundColor: cbLightBackground,
    textTheme: lightTextTheme,
    colorScheme: cbLightScheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static Size get screenSize => MediaQuery.of(GlobalOverlayContext.overlayState!.context).size;

  static double get screenWidth => screenSize.width;

  static double get screenHeight => screenSize.height;

  static const defaultSpacing = SizedBox(
    height: 10,
    width: 5,
  );
}


