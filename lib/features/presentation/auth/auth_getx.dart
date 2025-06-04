import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:exchange/features/presentation/daftar/daftar_page.dart';
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

  void onGoogleLogin() async {
    Get.to(() => DaftarPage());
  }

  void doChangeTheme() {
    f.onChangeTheme();
    onCheckTheme();
  }

  void onCheckTheme() {
    bool cacheTheme = f.onBR(key: Config.theme);
    isLight.value = cacheTheme;
  }
}
