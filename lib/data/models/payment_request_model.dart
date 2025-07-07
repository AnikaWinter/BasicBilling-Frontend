import 'package:basic_billing_application/domain/models/pay_request.dart';

class PaymentRequestModel {
  final String clientId;
  final String serviceId;
  final String period;

  PaymentRequestModel({
    required this.clientId,
    required this.serviceId,
    required this.period,
  });

  factory PaymentRequestModel.fromJson(Map<String, dynamic> json) =>
      PaymentRequestModel(
        clientId: json['clientId'],
        serviceId: json['serviceId'],
        period: json['period'],
      );

  factory PaymentRequestModel.fromDomain(PayRequest request) =>
      PaymentRequestModel(
        clientId: request.clientId,
        serviceId: request.serviceId,
        period: request.period,
      );

  Map<String, dynamic> toJson() => {
    "ClientId": clientId,
    "ServiceId": serviceId,
    "Period": period,
  };
}
