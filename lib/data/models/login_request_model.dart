import 'package:basic_billing_application/domain/models/login_request.dart';

class LoginRequestModel {
  final String userName;
  final String password;

  LoginRequestModel({required this.userName, required this.password});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        userName: json['name'],
        password: json['password'],
      );

  factory LoginRequestModel.fromDomain(LoginRequest login) =>
      LoginRequestModel(
        userName: login.userName,
        password: login.password,
      );

  Map<String, dynamic> toJson() => {
    "UserName": userName,
    "Password": password,
  };
}