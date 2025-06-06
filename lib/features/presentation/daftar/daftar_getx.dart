import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:exchange/core/main_widget.dart';
import 'package:exchange/features/domain/usecase/main_usecase.dart';
import 'package:exchange/features/presentation/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exchange/injection_container.dart' as di;

class DaftarGetx extends GetxController {
  MainUsecase useCase = di.injection<MainUsecase>();

  TextEditingController controller = TextEditingController();
  RxBool snkValue = false.obs;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  void onLanjut() async {
    if (!globalKey.currentState!.validate()) return;
    if (!snkValue.value) return;

    f.showLoading();
    String email = f.onBR(key: Config.stringEmail);
    CollectionReference collection = FirebaseFirestore.instance.collection('main-user');
    QuerySnapshot querySnapshot = await collection.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      String docId = querySnapshot.docs.first.id;
      await collection.doc(docId).update({'display': controller.text});
    }

    f.onBW(key: Config.stringDisplay, value: controller.text);
    f.endLoading();
    Get.offAll(() => DashboardPage());
  }

  void onShowSNK() async {
    f.showLoading();
    await useCase.getConfig(config: 'snk').then((value) {
      f.endLoading();

      value.fold((left) {}, (right) {
        f.showBottomSheet(
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  w.text(data: right, color: Colors.black),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: w.button(
                      onPressed: () {
                        Get.back();
                        snkValue.value = true;
                      },
                      child: w.text(data: 'Saya Setuju'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }

  void onChanged(bool? value) {
    snkValue.value = value ?? false;
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username tidak boleh kosong';
    }

    if (value.length < 5 || value.length > 16) {
      return 'Panjang harus antara 5 sampai 16 karakter';
    }

    final regex = RegExp(r'^[a-zA-Z0-9]+$');
    if (!regex.hasMatch(value)) {
      return 'Hanya huruf dan angka\ntanpa spasi atau simbol';
    }

    return null;
  }
}
