import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:exchange/core/main_widget.dart';
import 'package:exchange/features/presentation/setting/setting_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final SettingGetx getx = Get.put(SettingGetx());

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            border: Border.all(color: theme.primaryColor, width: .5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      w.text(data: 'Username', fontWeight: FontWeight.bold),
                      Row(
                        children: [
                          Icon(Icons.person, color: theme.primaryColor),
                          SizedBox(width: 5),
                          w.text(data: f.onBR(key: Config.stringDisplay)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: theme.primaryColor, thickness: .5),
              InkWell(
                onTap: getx.doChangeTheme,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      w.text(data: 'Tema', fontWeight: FontWeight.bold),
                      Obx(() => Icon(getx.isLight.value ? Icons.light_mode : Icons.dark_mode, color: theme.primaryColor)),
                    ],
                  ),
                ),
              ),
              Divider(color: theme.primaryColor, thickness: .5),
              InkWell(
                onTap: getx.onLogout,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      w.text(data: 'Logout', fontWeight: FontWeight.bold),
                      Icon(Icons.logout, color: theme.primaryColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
