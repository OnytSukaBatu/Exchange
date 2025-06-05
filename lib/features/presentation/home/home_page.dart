import 'package:exchange/core/main_function.dart';
import 'package:exchange/core/main_widget.dart';
import 'package:exchange/features/presentation/auth/auth_page.dart';
import 'package:exchange/features/presentation/home/home_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeGetx getx = Get.put(HomeGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.offAll(AuthPage());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    w.text(data: 'Total saldo anda', fontSize: 12),
                    SizedBox(height: 5),
                    Obx(
                      () => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: getx.onShowSaldo,
                              child: Icon(
                                getx.bShowSaldo.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          w.text(
                            data:
                                'Rp ${getx.bShowSaldo.value ? getx.dSaldo.value : '*****'}',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: w.button(
                        onPressed: getx.onDeposit,
                        backgroundColor: Colors.blue[100],
                        borderRadius: BorderRadius.circular(32),
                        borderColor: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_download_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(width: 5),
                            w.text(
                              data: 'Deposit',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: w.button(
                        onPressed: () {
                          f.showSnackBar(
                            titleText: 'Terjadi Masalah!',
                            messageText: '',
                          );
                        },
                        backgroundColor: Colors.blue[100],
                        borderRadius: BorderRadius.circular(32),
                        borderColor: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.attach_money, color: Colors.black),
                            SizedBox(width: 5),
                            w.text(
                              data: 'Withdraw',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
