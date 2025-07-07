import 'package:basic_billing_application/core/result.dart';
import 'package:basic_billing_application/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:basic_billing_application/domain/models/login_request.dart';

class AuthViewModel extends ChangeNotifier {
  late AuthRepository _authRepository;

  bool isLoading = false;
  String? errorMessage;

  AuthViewModel({AuthRepository? authRepository}) {
    if (authRepository != null) {
      _authRepository = authRepository;
    }
  }

  void updateRepository(AuthRepository authRepository) {
    _authRepository = authRepository;
  }

  Future<bool> login(String userName, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _authRepository.loginUser(LoginRequest(
      userName: userName,
      password: password,
    ));

    isLoading = false;

    if (result is Success) {
      notifyListeners();
      return true;
    } else if (result is Failure) {
      errorMessage = result.message;
      notifyListeners();
      return false;
    }

    return false;
  }
}
