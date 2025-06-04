import 'package:exchange/features/domain/entities/data_entity.dart';

class DataModel extends Data {
  final int count;

  const DataModel({required this.count, required super.name, required super.age});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(count: json['count'], name: json['name'], age: json['age']);
  }

  Map<String, dynamic> toJson() {
    return {'count': count, 'name': name, 'age': age};
  }

  Data toEntity() {
    return Data(name: name, age: age);
  }
}
