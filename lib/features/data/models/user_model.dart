import 'package:exchange/features/domain/entities/user_entity.dart';

class UserModel extends User {
  const UserModel({
    required super.email,
    required super.display,
    required super.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      display: json['display'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'display': display, 'data': data};
  }

  User toUser() {
    return User(email: email, display: display, data: data);
  }
}
