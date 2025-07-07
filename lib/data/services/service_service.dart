import 'dart:convert';
import 'package:basic_billing_application/data/models/service_response_model.dart';
import 'package:basic_billing_application/data/services/api_service.dart';

class ServiceService {
  final ApiService apiService = ApiService();

  Future<List<ServiceResponseModel>> getServices() async {
    var response = await apiService.get('services/odata');
    final jsonResponse = jsonDecode(response.body);

    if(response.statusCode == 200) {
      final List data = jsonResponse['value'];
      return data
        .map((e) => ServiceResponseModel.fromJson(e))
        .toList();
      }
    
    throw Exception('Error ${response.statusCode}: ${jsonResponse.toString()}');
  }
}
