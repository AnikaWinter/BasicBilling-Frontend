import 'package:basic_billing_application/core/result.dart';
import 'package:basic_billing_application/data/models/bill_create_model.dart';
import 'package:basic_billing_application/data/models/payment_request_model.dart';
import 'package:basic_billing_application/data/services/billing_service.dart';
import 'package:basic_billing_application/domain/models/bill.dart';
import 'package:basic_billing_application/domain/models/bill_response.dart';
import 'package:basic_billing_application/domain/models/pay_request.dart';

class BillRepository {
  final BillingService _billingApi;

  BillRepository({required BillingService billingApi}) : _billingApi = billingApi;

  Future<Result<void>> createBill(Bill bill) async {
    try {
      final billCreateApiModel = BillCreateModel.fromDomain(bill);
      await _billingApi.createBill(billCreateApiModel);
      return Success(null);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<void>> payBill(PayRequest request) async {
    try {
      final paymentApiModel = PaymentRequestModel.fromDomain(request);
      await _billingApi.payBill(paymentApiModel);
      return Success(null);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<List<BillResponse>>> getPendingBills(String clientId) async {
    try {
      final result = await _billingApi.getPendingBills(clientId);
      final list = result.map((e) => e.toDomain()).toList();
      return Success(list);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<List<BillResponse>>> getPaymentHistory(String clientId) async {
    try {
      final result = await _billingApi.getPaymentHistory(clientId);
      final list = result.map((e) => e.toDomain()).toList();
      return Success(list);
    } catch (e) {
      return Failure(e.toString());
    }
  }
  
}