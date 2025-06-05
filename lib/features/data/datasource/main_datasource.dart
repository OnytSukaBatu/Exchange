import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:exchange/features/data/models/data_model.dart';

class MainDatasource {
  Future<DataModel> getData({required String name}) async {
    Response<dynamic> response = await Dio().get(
      'https://api.agify.io/?name=$name',
    );
    DataModel data = DataModel.fromJson(response.data);
    return data;
  }

  Future<String> getConfig() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('main-config')
        .doc('main-genesis')
        .get();
    Map<String, dynamic>? data = snapshot.data();
    return data?['main'];
  }
}
