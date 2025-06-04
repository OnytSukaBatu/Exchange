import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_widget.dart';
import 'package:flutter/material.dart';
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

  void onChangeTheme() {
    bool cacheTheme = f.onBR(key: Config.theme);
    bool reverse = !cacheTheme;
    ThemeMode themeMode = reverse ? ThemeMode.light : ThemeMode.dark;
    f.onBW(key: Config.theme, value: reverse);
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
