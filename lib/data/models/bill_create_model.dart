import 'package:basic_billing_application/domain/models/bill.dart';

class BillCreateModel {
  final String clientId;
  final String serviceId;
  final String period;
  final int amount;

  BillCreateModel({required this.clientId, required this.serviceId, required this.period, required this.amount});

  factory BillCreateModel.fromJson(Map<String, dynamic> json) => BillCreateModel
  (
    clientId: json['clientId'],
    serviceId: json['serviceId'],
    period: json['period'],
    amount: json['amount'],
  );

  factory BillCreateModel.fromDomain(Bill bill) => BillCreateModel
  (
    clientId: bill.clientId,
    serviceId: bill.serviceId,
    period: bill.period,
    amount: bill.amount,
  );

  Map<String, dynamic> toJson() => {
    "ClientId" : clientId,
    "ServiceId" : serviceId,
    "Period" : period,
    "Amount" : amount
  };
  
}