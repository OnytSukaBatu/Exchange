import 'package:dartz/dartz.dart';
import 'package:exchange/features/data/datasource/main_datasource.dart';
import 'package:exchange/features/data/models/coin_model.dart';
import 'package:exchange/features/data/models/user_model.dart';
import 'package:exchange/features/domain/repo_interface/main_repo.dart';

class MainRepoImplementation extends MainRepoInterface {
  final MainDatasource dataSource;
  MainRepoImplementation(this.dataSource);

  @override
  Future<Either<String, String>> getConfig({required String config}) async {
    try {
      return Right(await dataSource.getConfig(config: config));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserModel>> getUserData({required String email}) async {
    try {
      UserModel model = await dataSource.getUserData(email: email);
      return Right(model);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CoinModel>>> getListCoin() async {
    try {
      List<CoinModel> model = await dataSource.getListCoin();
      return Right(model);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, double>> getPrice({required String id}) async {
    try {
      double data = await dataSource.getPrice(id: id);
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
