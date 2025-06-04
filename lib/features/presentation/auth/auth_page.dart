import 'package:exchange/core/main_image_path.dart';
import 'package:exchange/core/main_widget.dart';
import 'package:exchange/features/presentation/auth/auth_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final AuthGetx getx = Get.put(AuthGetx());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: getx.doChangeTheme,
            icon: Obx(
              () => Icon(
                getx.isLight.value ? Icons.light_mode : Icons.dark_mode,
                color: theme.primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              w.text(
                data: 'Exchange Template',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
              w.text(
                data: 'mulai trading dengan mudah',
                fontSize: 12,
                color: theme.primaryColor,
              ),
              SizedBox(height: 64),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                child: w.button(
                  onPressed: getx.onGoogleLogin,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: theme.scaffoldBackgroundColor,
                  borderColor: theme.primaryColor,
                  borderRadius: BorderRadius.circular(32),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      w.text(
                        data: 'Masuk dengan google',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                      SizedBox(width: 16),
                      Image.asset(ImagePath.google, scale: 16),
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
