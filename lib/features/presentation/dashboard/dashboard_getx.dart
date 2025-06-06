import 'package:exchange/features/presentation/home/home_page.dart';
import 'package:exchange/features/presentation/setting/setting_page.dart';
import 'package:get/get.dart';

class DashboardGetx extends GetxController {
  RxInt index = 0.obs;
  List page = [HomePage(), SettingPage()];
  void onChanged(int value) {
    index.value = value;
  }
}
