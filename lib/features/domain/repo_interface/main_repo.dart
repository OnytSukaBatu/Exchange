import 'package:dartz/dartz.dart';
import 'package:exchange/features/data/models/data_model.dart';

abstract class MainRepoInterface {
  Future<Either<String, DataModel>> getData({required String name});
}
