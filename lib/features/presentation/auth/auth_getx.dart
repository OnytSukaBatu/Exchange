import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGetx extends GetxController {
  RxBool isLight = true.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onCheckTheme();
    });
  }

  void doChangeTheme() {
    f.onChangeTheme();
    onCheckTheme();
  }

  void onCheckTheme() {
    isLight.value = f.onBR(key: Config.boolTheme);
  }

  void onGoogleLogin() async {}
}
