import 'package:dartz/dartz.dart';
import 'package:exchange/features/data/models/coin_model.dart';
import 'package:exchange/features/data/models/user_model.dart';

abstract class MainRepoInterface {
  Future<Either<String, String>> getConfig({required String config});

  Future<Either<String, UserModel>> getUserData({required String email});

  Future<Either<String, List<CoinModel>>> getListCoin();

  Future<Either<String, double>> getPrice({required String id});
}
