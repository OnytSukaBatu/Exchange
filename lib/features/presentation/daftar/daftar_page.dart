import 'package:exchange/core/main_widget.dart';
import 'package:exchange/features/presentation/daftar/daftar_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class DaftarPage extends StatelessWidget {
  DaftarPage({super.key});

  final DaftarGetx getx = Get.put(DaftarGetx());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                w.text(data: 'Sebelum melanjutkan isi data diri terlebih dahulu', fontSize: 16),
                SizedBox(height: 16),
                w.input(
                  label: w.text(data: 'Masukan Nama lengkap', color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                w.text(data: 'Dengan ini saya menyetujui syarat & ketentuan yang berlaku', fontSize: 12),
                SizedBox(
                  width: double.infinity,
                  child: w.button(
                    onPressed: getx.onLanjut,
                    backgroundColor: Colors.blue[100],
                    borderRadius: BorderRadius.circular(32),
                    borderColor: Colors.black,
                    child: w.text(data: 'Lanjut'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
