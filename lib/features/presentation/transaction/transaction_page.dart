import 'package:cached_network_image/cached_network_image.dart';
import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:exchange/core/main_widget.dart';
import 'package:exchange/features/presentation/transaction/transaction_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TransactionPage extends StatelessWidget {
  final String coinID;
  final String coinImageUrl;
  final String coinSymbol;
  final List data;
  final TransactionGetx getx;
  TransactionPage({super.key, required this.coinID, required this.coinImageUrl, required this.coinSymbol, required this.data})
    : getx = Get.put(TransactionGetx(data: data, coinID: coinID));

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(Icons.arrow_back, color: theme.primaryColor),
        ),
        title: w.text(data: coinSymbol.toUpperCase(), fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 32, child: CachedNetworkImage(imageUrl: coinImageUrl)),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        w.text(data: coinSymbol, fontSize: 16, fontWeight: FontWeight.bold),
                        w.text(data: coinID, fontSize: 12),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        w.text(data: 'Saldo $coinID Kamu:'),
                        Obx(() => w.text(data: f.currency(value: getx.saldo.value))),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                w.input(
                  label: w.text(data: 'Nominal Transaksi'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: getx.controller,
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: w.text(
                    data: 'Saldo Tether Tersedia : ${f.currency(value: f.onBR(key: Config.doubleTether))}',
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    w.text(data: 'Harga $coinSymbol Saat Ini :'),
                    Obx(
                      () => Row(
                        children: [
                          w.text(data: '(${getx.timeUpdate.value})', color: Colors.grey),
                          SizedBox(width: 5),
                          w.text(data: f.currency(value: getx.priceCoin.value)),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: w.text(data: 'Fee Beli & Jual : 1.25%'),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: w.button(
                        onPressed: getx.onBeli,
                        borderRadius: BorderRadius.circular(16),
                        backgroundColor: Colors.green,
                        borderColor: theme.primaryColor,
                        child: w.text(data: 'Beli', fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: w.button(
                        onPressed: () {},
                        borderRadius: BorderRadius.circular(16),
                        backgroundColor: Colors.red,
                        borderColor: theme.primaryColor,
                        child: w.text(data: 'Jual', fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                w.text(data: 'Pembelian atau Penjualan harus menggunakan Tether sebagai mata uang utama aplikasi'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
