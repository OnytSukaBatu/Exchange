import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:exchange/core/main_config.dart';
import 'package:exchange/core/main_function.dart';
import 'package:exchange/features/data/models/coin_model.dart';
import 'package:exchange/features/data/models/user_model.dart';

class MainDatasource {
  Future<String> getConfig({required String config}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('main-config').doc('main-genesis').get();
    Map<String, dynamic>? data = snapshot.data();
    return data?[config];
  }

  Future<UserModel> getUserData({required String email}) async {
    final collection = FirebaseFirestore.instance.collection('main-user');
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await collection.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isEmpty) {
      Map<String, dynamic> user = {'email': email, 'display': '', 'data': '0'};
      await collection.add(user);
      UserModel.fromJson(user);
    }

    UserModel data = UserModel.fromJson(querySnapshot.docs[0].data());
    return data;
  }

  Future<List<CoinModel>> getListCoin() async {
    Response<dynamic> response = await Dio().get(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=idr',
      options: Options(headers: {'x-cg-demo-api-key': await f.onSR(key: Config.stringAPIKey)}),
    );
    List data = response.data;
    return data.map((item) => CoinModel.fromJson(item)).toList();
  }

  Future<double> getPrice({required String id}) async {
    Response<dynamic> response = await Dio().get(
      'https://api.coingecko.com/api/v3/simple/price?vs_currencies=idr&ids=$id',
      options: Options(headers: {'x-cg-demo-api-key': await f.onSR(key: Config.stringAPIKey)}),
    );
    return double.parse(response.data[id]['idr'].toString());
  }
}
