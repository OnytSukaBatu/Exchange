import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainFunction {
  GetStorage box = GetStorage();

  void onBW({required String key, required dynamic value}) {
    box.write(key, value);
  }

  dynamic onBR({required String key, dynamic dv}) {
    return box.read(key) ?? dv;
  }

  void onBD({required String key}) {
    box.remove(key);
  }

  FlutterSecureStorage storage = FlutterSecureStorage(
    aOptions: const AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> onSW({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future<String> onSR({required String key, String? dv}) async {
    return await storage.read(key: key) ?? dv ?? '';
  }

  Future<void> onSD({required String key}) async {
    await storage.delete(key: key);
  }

  void onChangeTheme() {
    bool cacheTheme = f.onBR(key: Config.boolTheme);
    bool reverse = !cacheTheme;
    ThemeMode themeMode = reverse ? ThemeMode.light : ThemeMode.dark;
    f.onBW(key: Config.boolTheme, value: reverse);
    Get.changeThemeMode(themeMode);
  }

  void showSnackBar({
    required String titleText,
    Color? titleColor,
    double? titleFontSize,
    FontWeight? titleFontWeight,
    required String messageText,
    Color? messageColor,
    double? messageFontSize,
    FontWeight? messageFontWeight,
    Color? backgroundColor,
    Duration? duration,
    Widget? icon,
    bool? isDismissible,
    EdgeInsets? padding,
    SnackPosition? snackPosition,
  }) {
    titleColor ??= Colors.white;
    titleFontSize ??= 14;
    titleFontWeight ??= FontWeight.bold;
    messageColor ??= Colors.white;
    messageFontSize ??= 12;
    backgroundColor ??= Colors.grey;
    snackPosition ??= SnackPosition.TOP;
    duration ??= Duration(seconds: 2);

    Get.snackbar(
      '',
      '',
      titleText: w.text(
        data: titleText,
        color: titleColor,
        fontSize: titleFontSize,
        fontWeight: titleFontWeight,
        textAlign: TextAlign.left,
      ),
      messageText: w.text(
        data: messageText,
        color: messageColor,
        fontSize: messageFontSize,
        fontWeight: messageFontWeight,
        textAlign: TextAlign.left,
      ),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: backgroundColor,
      duration: duration,
      icon: icon,
      isDismissible: isDismissible,
      padding: padding,
      snackPosition: snackPosition,
      snackStyle: SnackStyle.FLOATING,
    );
  }
}

MainFunction get f => MainFunction();
