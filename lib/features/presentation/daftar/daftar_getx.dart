import 'package:exchange/features/presentation/home/home_page.dart';
import 'package:get/get.dart';

class DaftarGetx extends GetxController {
  void onLanjut() async {
    Get.to(() => HomePage());
  }
}
