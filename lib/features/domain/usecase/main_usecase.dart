import 'package:dartz/dartz.dart';
import 'package:exchange/features/data/models/data_model.dart';
import 'package:exchange/features/domain/entities/data_entity.dart';
import 'package:exchange/features/domain/repo_interface/main_repo.dart';

class MainUsecase {
  final MainRepoInterface repositoryAPI;
  MainUsecase(this.repositoryAPI);

  Future<Either<String, Data>> getData({required String name}) async {
    Either<String, DataModel> result = await repositoryAPI.getData(name: name);
    return result.map((model) => model.toEntity());
  }

  Future<Either<String, String>> getConfig() async {
    return await repositoryAPI.getConfig();
  }
}
