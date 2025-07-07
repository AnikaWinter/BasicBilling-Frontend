import 'dart:convert';
import 'package:basic_billing_application/data/models/bill_create_model.dart';
import 'package:basic_billing_application/data/models/bill_response_model.dart';
import 'package:basic_billing_application/data/models/payment_request_model.dart';
import 'package:basic_billing_application/data/services/api_service.dart';

class BillingService {
  ApiService apiService = ApiService();

  Future<void> createBill(BillCreateModel model) async {
    var response = await apiService.post('bills', model.toJson());

    if (response.statusCode == 200) return;

    final error = jsonDecode(response.body);
    throw Exception('Error ${response.statusCode}: ${error.toString()}');
  }

  Future<void> payBill(PaymentRequestModel model) async {
    var response = await apiService.post('bills/payments', model.toJson());

    if (response.statusCode == 200) return;

    final error = jsonDecode(response.body);
    throw Exception('Error ${response.statusCode}: ${error.toString()}');
  }

  Future<List<BillResponseModel>> getPendingBills(String clientId) async {
    var response = await apiService.get('clients/$clientId/pending-bills');
    final jsonResponse = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return (jsonResponse as List)
        .map((e) => BillResponseModel.fromJson(e))
        .toList();
      }
    
    throw Exception('Error ${response.statusCode}: ${jsonResponse.toString()}');
  }

  Future<List<BillResponseModel>> getPaymentHistory(String clientId) async {
    var response = await apiService.get('clients/$clientId/payment-history');
    final jsonResponse = jsonDecode(response.body);
    
    if(response.statusCode == 200) {
      return (jsonResponse as List)
        .map((e) => BillResponseModel.fromJson(e))
        .toList();
      }
    
    throw Exception('Error ${response.statusCode}: ${jsonResponse.toString()}');
  }
}
