import 'dart:convert';

import 'package:basic_billing_application/core/result.dart';
import 'package:basic_billing_application/data/models/login_request_model.dart';
import 'package:basic_billing_application/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  ApiService apiService = ApiService();

  Future<Result<void>> login(LoginRequestModel model) async {
    try {
      var response = await apiService.anonymousPost(
        'auth/login',
        model.toJson(),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        var myToken = json['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', myToken);
        print("Token saved: $myToken");
        return Success(null);
      } else {
        final error = jsonDecode(response.body);
        String errorMsg = error['message'] ?? 'Unknown error';
        return Failure(errorMsg);
      }
    } catch (e) {
      return Failure('Error: $e');
    }
  }
}
