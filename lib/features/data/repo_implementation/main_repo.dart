import 'package:dartz/dartz.dart';
import 'package:exchange/core/main_exception.dart';
import 'package:exchange/features/data/datasource/main_datasource.dart';
import 'package:exchange/features/data/models/data_model.dart';
import 'package:exchange/features/domain/repo_interface/main_repo.dart';

class MainRepoImplementation extends MainRepoInterface {
  final MainDatasource dataSource;
  MainRepoImplementation(this.dataSource);

  @override
  Future<Either<String, DataModel>> getData({required String name}) async {
    try {
      DataModel model = await dataSource.getData(name: name);
      return Right(model);
    } on ErrorException catch (e) {
      return Left(e.message);
    }
  }
}
