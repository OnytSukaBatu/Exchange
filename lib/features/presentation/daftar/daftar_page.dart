import 'package:exchange/core/main_widget.dart';
import 'package:exchange/features/presentation/daftar/daftar_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DaftarPage extends StatelessWidget {
  DaftarPage({super.key});

  final DaftarGetx getx = Get.put(DaftarGetx());

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Form(
          key: getx.globalKey,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.primaryColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    w.text(data: 'Sebelum melanjutkan isi data diri terlebih dahulu', fontSize: 16),
                    SizedBox(height: 16),
                    w.input(
                      controller: getx.controller,
                      label: w.text(data: 'Buat Username'),
                      validator: getx.usernameValidator,
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() => w.checkBox(value: getx.snkValue.value, onChanged: getx.onChanged)),
                        InkWell(
                          onTap: getx.onShowSNK,
                          child: w.text(data: 'saya menyetujui syarat & ketentuan', fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: w.button(
                        onPressed: getx.onLanjut,
                        borderRadius: BorderRadius.circular(32),
                        child: w.text(data: 'Lanjut'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
