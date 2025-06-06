import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:exchange/features/presentation/auth/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingGetx extends GetxController {
  RxBool isLight = true.obs;

  @override
  void onInit() async {
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

  void onLogout() async {
    f.showLoading();
    await GoogleSignIn().signOut();
    f.endLoading();
    f.onBW(key: Config.boolLogin, value: false);
    Get.offAll(AuthPage());
  }
}
