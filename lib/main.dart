import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:exchange/core/main_theme.dart';
import 'package:exchange/features/domain/usecase/main_usecase.dart';
import 'package:exchange/features/presentation/auth/auth_page.dart';
import 'package:exchange/features/presentation/dashboard/dashboard_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  di.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeMode onGetThemeMode() {
    bool? cacheTheme = f.onBR(key: Config.boolTheme, dv: null);

    if (cacheTheme == null) {
      Brightness brightness = PlatformDispatcher.instance.platformBrightness;
      cacheTheme = brightness == Brightness.light ? true : false;
      f.onBW(key: Config.boolTheme, value: cacheTheme);
    }

    return cacheTheme ? ThemeMode.light : ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: MainPage(), theme: lightTheme, darkTheme: darkTheme, themeMode: onGetThemeMode());
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final MainGetx getx = Get.put(MainGetx());

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(color: theme.primaryColor, backgroundColor: Colors.transparent),
        ),
      ),
    );
  }
}

class MainGetx extends GetxController {
  MainUsecase useCase = di.injection<MainUsecase>();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onGetConfig();
    });
  }

  void onGetConfig() async {
    await useCase.getConfig(config: 'main').then((value) {
      value.fold((left) {}, (right) async {
        List data = right.split('|');

        String versiAPK = data[0];
        await f.onSW(key: Config.stringAPIKey, value: data[1]);

        if (versiAPK != Config.stringVersion) {
          return f.showSnackBar(titleText: 'versi $versiAPK sudah rilis', messageText: 'harap update aplikasi ke versi terbaru!');
        }

        if (f.onBR(key: Config.boolLogin, dv: false)) {
          Get.offAll(() => DashboardPage());
        } else {
          Get.offAll(() => AuthPage());
        }
      });
    });
  }
}
