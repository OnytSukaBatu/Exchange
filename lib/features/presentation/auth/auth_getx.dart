import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:exchange/features/domain/entities/user_entity.dart';
import 'package:exchange/features/domain/usecase/main_usecase.dart';
import 'package:exchange/features/presentation/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:exchange/injection_container.dart' as di;

class AuthGetx extends GetxController {
  MainUsecase useCase = di.injection<MainUsecase>();
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

  void onGoogleLogin() async {
    f.showLoading();
    await GoogleSignIn().signIn().then((user) async {
      f.endLoading();

      if (user != null) {
        String email = user.email;
        String display = user.displayName ?? '';
        f.onBW(key: Config.stringEmail, value: email);

        f.showLoading();
        await useCase.getUserData(email: email, display: display).then((value) {
          f.endLoading();

          value.fold((left) {}, (right) {
            User user = right;
            f.onBW(key: Config.stringDisplay, value: user.display);
            f.onBW(key: Config.stringData, value: user.data);
            f.onBW(key: Config.boolLogin, value: true);
            Get.offAll(() => DashboardPage());
          });
        });
      }
    });
  }
}
