import 'package:exchange/features/data/datasource/main_datasource.dart';
import 'package:exchange/features/data/repo_implementation/main_repo.dart';
import 'package:exchange/features/domain/repo_interface/main_repo.dart';
import 'package:exchange/features/domain/usecase/main_usecase.dart';
import 'package:get_it/get_it.dart';

GetIt injection = GetIt.instance;

void setup() {
  injection.registerLazySingleton<MainDatasource>(() => MainDatasource());

  injection.registerLazySingleton<MainRepoInterface>(() => MainRepoImplementation(injection<MainDatasource>()));

  injection.registerLazySingleton<MainUsecase>(() => MainUsecase(injection<MainRepoInterface>()));
}
