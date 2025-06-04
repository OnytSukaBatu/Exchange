import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:exchange/core/main_theme.dart';
import 'package:exchange/features/presentation/auth/auth_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  di.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final MainGetx getx = Get.put(MainGetx());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: getx.theme,
    );
  }
}

class MainGetx extends GetxController {
  ThemeMode get theme => onGetThemeMode();

  ThemeMode onGetThemeMode() {
    bool? cacheTheme = f.onBR(key: Config.theme, dv: null);

    if (cacheTheme == null) {
      Brightness brightness = PlatformDispatcher.instance.platformBrightness;
      cacheTheme = brightness == Brightness.light ? true : false;
      f.onBW(key: Config.theme, value: cacheTheme);
    }

    return cacheTheme ? ThemeMode.light : ThemeMode.dark;
  }
}
