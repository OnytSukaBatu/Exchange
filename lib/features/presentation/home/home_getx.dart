import 'dart:developer';

import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:exchange/features/domain/entities/coin_entity.dart';
import 'package:exchange/features/domain/usecase/main_usecase.dart';
import 'package:exchange/features/presentation/daftar/daftar_page.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:exchange/injection_container.dart' as di;

class HomeGetx extends GetxController {
  MainUsecase useCase = di.injection<MainUsecase>();

  RxString display = ''.obs;

  RxDouble saldo = 0.0.obs;
  RxBool showSaldo = false.obs;

  RxList<Coin> listCoin = <Coin>[].obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onGetListCoin();
      display.value = f.onBR(key: Config.stringDisplay);
      if (display.value.isEmpty) Get.offAll(() => DaftarPage());
    });
  }

  Future<void> onGetListCoin() async {
    await useCase.getListCoin().then((value) {
      value.fold(
        (left) {
          log(left);
        },
        (right) {
          listCoin.value = right;
          log(right.toString());
        },
      );
    });
  }

  void onCheckUser() {}

  void onShowSaldo() {
    showSaldo.value = !showSaldo.value;
  }

  void onDeposit() async {}
}
