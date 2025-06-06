import 'dart:developer';

import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:exchange/features/domain/entities/coin_entity.dart';
import 'package:exchange/features/domain/entities/user_entity.dart';
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
      onRefresh();
      display.value = f.onBR(key: Config.stringDisplay);
      if (display.value.isEmpty) Get.offAll(() => DaftarPage());
    });
  }

  Future<void> onRefresh() async {
    await onGetData();
    await onCheckUser();
    await onGetListCoin();
  }

  Future<void> onGetListCoin() async {
    await useCase.getListCoin().then((value) {
      value.fold(
        (left) {
          log(left);
        },
        (right) {
          listCoin.value = right;
        },
      );
    });
  }

  Future<void> onCheckUser() async {
    saldo.value = 0.0;
    List listData = f.onBR(key: Config.stringData).split('|');
    for (String i in listData) {
      List indexData = i.split('~');
      await useCase.getPrice(id: indexData[0]).then((value) {
        value.fold((left) {}, (right) {
          double priceWhenBuy = double.parse(indexData[1]);
          double totalWhenBuy = double.parse(indexData[2]);
          double difference = right - priceWhenBuy;
          double percentage = (difference / right);
          saldo.value = saldo.value + (totalWhenBuy + (totalWhenBuy * percentage));
        });
      });
    }
  }

  Future<void> onGetData() async {
    String email = f.onBR(key: Config.stringEmail);
    String display = f.onBR(key: Config.stringDisplay);
    await useCase.getUserData(email: email, display: display).then((value) {
      value.fold((left) {}, (right) {
        User user = right;
        f.onBW(key: Config.stringData, value: user.data);
      });
    });
  }

  void onShowSaldo() {
    showSaldo.value = !showSaldo.value;
  }

  void onDeposit() async {}
}
