import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:exchange/features/domain/usecase/main_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:exchange/injection_container.dart' as di;

class TransactionGetx extends GetxController {
  final List data;
  final String coinID;
  TransactionGetx({required this.data, required this.coinID});

  MainUsecase useCase = di.injection<MainUsecase>();

  TextEditingController controller = TextEditingController();

  Timer? timer;
  RxDouble saldo = 0.0.obs;
  RxDouble priceCoin = 0.0.obs;
  RxInt timeUpdate = 60.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      onCheckSaldo();

      f.showLoading();
      await onPriceUpdate();
      f.endLoading();

      onUpdate();
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void onCheckSaldo() {
    for (List i in data) {
      if (i[0] == coinID) saldo.value = i[1];
    }
  }

  void onUpdate() async {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (timeUpdate.value == 0) {
        onPriceUpdate();
        timeUpdate.value = 60;
      } else {
        timeUpdate.value--;
      }
    });
  }

  Future<void> onPriceUpdate() async {
    await useCase.getPrice(id: coinID).then((value) {
      value.fold((left) {}, (right) {
        priceCoin.value = right;
      });
    });
  }

  void onBeli() async {
    String get = f.onBR(key: Config.stringData);
    List data = get.split('|');
    double saldoTether = f.onBR(key: Config.doubleTether);
    double nominalBeli = double.parse(controller.text);

    if (nominalBeli < 10000) {
      f.showSnackBar(titleText: 'Gagal Membeli $coinID', messageText: 'Minimal Pembelian IDR 10.000');
      return;
    }

    if (saldoTether < nominalBeli) {
      f.showSnackBar(titleText: 'Gagal Membeli $coinID', messageText: 'Saldo Tidak Mencukupi');
      return;
    }

    double sisaSaldo = saldoTether - nominalBeli;
    double feeDone = nominalBeli - ((1.25 / 100) * nominalBeli);

    f.onBW(key: Config.doubleTether, value: sisaSaldo);

    String doneData = '';

    if (get.contains(coinID)) {
      List newData = [];
      for (String i in data) {
        List index = i.split('~');
        List newIndex = [];
        if (index[0] == coinID) {
          newIndex.add(coinID);
          newIndex.add(priceCoin.value);
          newIndex.add(feeDone + saldo.value);
          newData.add(newIndex.join('~'));
        } else if (index[0] == 'tether') {
          newIndex.add(index[0]);
          newIndex.add(index[1]);
          newIndex.add(sisaSaldo);
          newData.add(newIndex.join('~'));
        } else {
          if (newIndex[2] > 1000) newData.add(i);
        }
      }
      doneData = newData.join('|');
    } else {
      List newData = [];
      data.add([coinID, priceCoin.value, feeDone].join('~'));
      for (String i in data) {
        List index = i.split('~');
        List newIndex = [];
        if (index[0] == 'tether') {
          newIndex.add(index[0]);
          newIndex.add(index[1]);
          newIndex.add(sisaSaldo);
          newData.add(newIndex.join('~'));
        } else {
          newData.add(i);
        }
        doneData = newData.join('|');
      }
    }

    f.showLoading();
    String userID = await f.onSR(key: Config.stringID);
    await FirebaseFirestore.instance.collection('main-user').doc(userID).update({'data': doneData});
    f.endLoading();

    Get.back();
  }

  void onJual() async {}
}
