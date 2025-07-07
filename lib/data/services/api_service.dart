import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const _baseUrl = 'http://localhost:5045';
  static final Logger _logger = Logger('Client Service');

  Future<String?> _getToken() async {
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<http.Response> get(String endpoint) async {
    String? token = await _getToken();

    _logger.info('GET to $_baseUrl/$endpoint');

    final response = await http.get(
      Uri.parse("$_baseUrl/$endpoint"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    
    return response;
  }

  Future<http.Response> anonymousPost(String endpoint, Map<String, dynamic> body) async {
    _logger.info('POST to $_baseUrl/$endpoint');
    _logger.info('Body: ${jsonEncode(body)}');

    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode(body)
    );

    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    String? token = await _getToken();

    _logger.info('POST to $_baseUrl/$endpoint');
    _logger.info('Body: ${jsonEncode(body)}');

    final response = await http.post(
      Uri.parse("$_baseUrl/$endpoint"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body)
    );

    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    String? token = await _getToken();

    _logger.info('DELETE to $_baseUrl/$endpoint');

    final response = await http.delete(
      Uri.parse("$_baseUrl/$endpoint"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return response;
  }
}

