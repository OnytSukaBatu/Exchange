import 'package:exchange/features/domain/usecase/main_usecase.dart';
import 'package:get/get.dart';
import 'package:exchange/injection_container.dart' as di;

class HomeGetx extends GetxController {
  MainUsecase useCase = di.injection<MainUsecase>();

  RxDouble dSaldo = 0.0.obs;
  RxBool bShowSaldo = false.obs;

  void onShowSaldo() {
    bShowSaldo.value = !bShowSaldo.value;
  }

  void onDeposit() async {
    await useCase.getData(name: 'Valentyno Elsan').then((value) {
      value.fold((left) {}, (right) {});
    });
  }
}
