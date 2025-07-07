import 'package:basic_billing_application/core/result.dart';
import 'package:basic_billing_application/domain/models/bill.dart';
import 'package:basic_billing_application/domain/models/pay_request.dart';
import 'package:basic_billing_application/domain/models/service_response.dart';
import 'package:basic_billing_application/domain/repositories/bill_repository.dart';
import 'package:basic_billing_application/domain/services/billing_data_service.dart';
import 'package:flutter/material.dart';

class ManageBillViewModel extends ChangeNotifier {
  late BillRepository _billRepo;
  late BillingDataService _billingData;

  List<String> clientIds = [];
  List<ServiceResponse> services = [];

  bool isLoading = false;
  String? errorMessage;

  ManageBillViewModel();

  void updateRepositories({
    required BillRepository billRepo,
    required BillingDataService billingData,
  }) {
    _billRepo = billRepo;
    _billingData = billingData;
  }

  Future<void> loadDropdownData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      clientIds = await _billingData.loadClientData();
      services = await _billingData.loadServiceData();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Result<void>> submitBill({
    required String clientId,
    required String serviceId,
    required String period,
    required int amount,
  }) async {
    errorMessage = null;
    notifyListeners();

    final bill = Bill(
      clientId: clientId,
      serviceId: serviceId,
      period: period,
      amount: amount,
    );

    final result = await _billRepo.createBill(bill);

    if (result is Failure<void>) {
      errorMessage = result.message;
      notifyListeners();
    }

    return result;
  }

  Future<Result<void>> payBill({
    required String clientId,
    required String serviceId,
    required String period,
  }) async {
    errorMessage = null;
    notifyListeners();

    final request = PayRequest(
      clientId: clientId,
      serviceId: serviceId,
      period: period,
    );

    final result = await _billRepo.payBill(request);

    if (result is Failure<void>) {
      errorMessage = result.message;
      notifyListeners();
    }

    return result;
  }
}
