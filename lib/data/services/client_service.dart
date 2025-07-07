import 'dart:convert';

import 'package:basic_billing_application/data/models/client_response_model.dart';
import 'package:basic_billing_application/data/services/api_service.dart';

class ClientService {
  final ApiService apiService = ApiService();

  Future<List<ClientResponseModel>> getClients() async {
    var response = await apiService.get('clients/odata');
    final jsonResponse = jsonDecode(response.body);

    if(response.statusCode == 200) {
      final List data = jsonResponse['value'];
      return data
        .map((e) => ClientResponseModel.fromJson(e))
        .toList();
      }
    
    throw Exception('Error ${response.statusCode}: ${jsonResponse.toString()}');
  }
}
