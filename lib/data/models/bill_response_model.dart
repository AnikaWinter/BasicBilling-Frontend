import 'package:basic_billing_application/domain/models/bill_response.dart';
import 'package:intl/intl.dart';

class BillResponseModel {
  final String id;
  final String clientId;
  final String serviceType;
  final String period;
  final int amount;
  final String? paymentDate;

  BillResponseModel({
    required this.id,
    required this.clientId,
    required this.serviceType,
    required this.period,
    required this.amount,
    this.paymentDate,
  });

  factory BillResponseModel.fromJson(Map<String, dynamic> json) =>
      BillResponseModel(
        id: json['id'],
        clientId: json['clientId'],
        serviceType: json['serviceType'],
        period: json['period'],
        amount: json['amount'],
        paymentDate: json['paymentDate'] != null 
          ? DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(json['paymentDate']))
          : null
      );

  BillResponse toDomain() => BillResponse(
    id: id,
    clientId: clientId,
    serviceType: serviceType,
    period: period,
    amount: amount,
    paymentDate: paymentDate,
  );
}
