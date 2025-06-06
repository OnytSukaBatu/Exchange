import 'package:dartz/dartz.dart';
import 'package:exchange/features/data/models/coin_model.dart';
import 'package:exchange/features/data/models/user_model.dart';
import 'package:exchange/features/domain/entities/coin_entity.dart';
import 'package:exchange/features/domain/entities/user_entity.dart';
import 'package:exchange/features/domain/repo_interface/main_repo.dart';

class MainUsecase {
  final MainRepoInterface repositoryAPI;
  MainUsecase(this.repositoryAPI);

  Future<Either<String, String>> getConfig({required String config}) async {
    return await repositoryAPI.getConfig(config: config);
  }

  Future<Either<String, User>> getUserData({required String email, required String display}) async {
    Either<String, UserModel> result = await repositoryAPI.getUserData(email: email);
    return result.map((model) => model.toUser());
  }

  Future<Either<String, List<Coin>>> getListCoin() async {
    Either<String, List<CoinModel>> result = await repositoryAPI.getListCoin();
    return result.map((coinList) => coinList.map((model) => model.toCoin()).toList());
  }

  Future<Either<String, double>> getPrice({required String id}) async {
    Either<String, double> result = await repositoryAPI.getPrice(id: id);
    return result;
  }
}
