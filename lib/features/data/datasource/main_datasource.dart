import 'package:dio/dio.dart';
import 'package:exchange/core/main_exception.dart';
import 'package:exchange/features/data/models/data_model.dart';

class MainDatasource {
  Future<DataModel> getData({required String name}) async {
    try {
      Response<dynamic> response = await Dio().get('https://api.agify.io/?name=$name');
      DataModel data = DataModel.fromJson(response.data);
      return data;
    } catch (e) {
      throw ErrorException(e.toString());
    }
  }
}
