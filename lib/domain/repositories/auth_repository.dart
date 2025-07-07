import 'package:basic_billing_application/core/result.dart';
import 'package:basic_billing_application/data/models/login_request_model.dart';
import 'package:basic_billing_application/data/services/auth_service.dart';
import 'package:basic_billing_application/domain/models/login_request.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository({required AuthService authService})
    : _authService = authService;

  Future<Result<void>> loginUser(LoginRequest request) async {
    final loginApiModel = LoginRequestModel.fromDomain(request);
    return await _authService.login(loginApiModel);
  }
}
