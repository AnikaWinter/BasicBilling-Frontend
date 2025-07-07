import 'package:basic_billing_application/core/result.dart';
import 'package:basic_billing_application/domain/models/bill_response.dart';
import 'package:basic_billing_application/domain/repositories/bill_repository.dart';
import 'package:basic_billing_application/domain/services/billing_data_service.dart';
import 'package:flutter/material.dart';

class ViewBillsViewModel extends ChangeNotifier{
  late BillRepository _billRepo;
  late BillingDataService _billingData;

  List<String> clientIds = [];
  List<BillResponse> pendingBills = [];
  List<BillResponse> paidBills = [];

  bool isLoading = false;
  String? errorMessage;

  ViewBillsViewModel();

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
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPendingBills(String clientId) async {
    isLoading = true;
    errorMessage = null;
    pendingBills = [];
    notifyListeners();

    try {
      final billResult = await _billRepo.getPendingBills(clientId);
      print('billResult: $billResult');
      if (billResult is Success<List<BillResponse>>) {
        pendingBills = billResult.data;
      } else if (billResult is Failure<List<BillResponse>>) {
        errorMessage = billResult.message;
        print('errorMessage: $errorMessage');
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPaidBills(String clientId) async {
    isLoading = true;
    errorMessage = null;
    paidBills = [];
    notifyListeners();

    try {
      final billResult = await _billRepo.getPaymentHistory(clientId);
      print('billResult: $billResult');
      if (billResult is Success<List<BillResponse>>) {
        paidBills = billResult.data;
      } else if (billResult is Failure<List<BillResponse>>) {
        errorMessage = billResult.message;
        print('errorMessage: $errorMessage');
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}