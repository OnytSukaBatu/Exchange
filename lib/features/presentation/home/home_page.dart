import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:exchange/core/main_widget.dart';
import 'package:exchange/features/domain/entities/coin_entity.dart';
import 'package:exchange/features/presentation/home/home_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeGetx getx = Get.put(HomeGetx());

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: w.text(data: f.onBR(key: Config.stringDisplay), fontSize: 16),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: getx.onRefresh,
          backgroundColor: theme.primaryColor,
          color: theme.scaffoldBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          border: Border.all(color: theme.primaryColor),
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
                                    child: InkWell(onTap: getx.onShowSaldo, child: Icon(getx.showSaldo.value ? Icons.visibility : Icons.visibility_off)),
                                  ),
                                  SizedBox(width: 5),
                                  w.text(
                                    data: getx.showSaldo.value ? f.currency(value: getx.saldo.value) : '*****',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: getx.showSaldo.value,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    w.text(data: 'Assets Kamu', fontSize: 12, fontWeight: FontWeight.bold),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: getx.myAssets.length,
                                      itemBuilder: (context, index) {
                                        List i = getx.myAssets[index];
                                        return w.text(
                                          data: '${i[0]} : ${f.currency(value: i[1])}',
                                          textAlign: TextAlign.left,
                                          fontSize: 12,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: w.button(
                      //           onPressed: getx.onDeposit,
                      //           backgroundColor: theme.scaffoldBackgroundColor,
                      //           borderRadius: BorderRadius.circular(32),
                      //           borderColor: theme.primaryColor,
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Icon(Icons.file_download_outlined, color: theme.primaryColor),
                      //               SizedBox(width: 5),
                      //               w.text(data: 'Deposit', fontSize: 12, fontWeight: FontWeight.bold),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(width: 16),
                      //       Expanded(
                      //         child: w.button(
                      //           onPressed: () {},
                      //           backgroundColor: theme.scaffoldBackgroundColor,
                      //           borderRadius: BorderRadius.circular(32),
                      //           borderColor: theme.primaryColor,
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Icon(Icons.attach_money, color: theme.primaryColor),
                      //               SizedBox(width: 5),
                      //               w.text(data: 'Withdraw', fontSize: 12, fontWeight: FontWeight.bold),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: getx.listCoin.length,
                    itemBuilder: (context, index) {
                      Coin coin = getx.listCoin[index];

                      return Material(
                        child: InkWell(
                          onTap: () {
                            getx.onTransaction(coinID: coin.id, coinImageUrl: coin.image, coinSymbol: coin.symbol);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 16,
                                  child: ClipOval(child: CachedNetworkImage(imageUrl: coin.image)),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      w.text(data: coin.symbol.toUpperCase(), fontSize: 12, fontWeight: FontWeight.bold),
                                      w.text(data: coin.name, fontSize: 10),
                                    ],
                                  ),
                                ),
                                IntrinsicWidth(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      w.text(
                                        data: f.currency(value: coin.currentPrice),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      w.text(
                                        data: '${coin.priceChange.toStringAsFixed(2)} %',
                                        fontSize: 10,
                                        color: coin.priceChange < 0 ? Colors.red : Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
