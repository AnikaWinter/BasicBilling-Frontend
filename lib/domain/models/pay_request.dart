class PayRequest {
  String clientId;
  String serviceId;
  String period;

  PayRequest({
    required this.clientId,
    required this.serviceId,
    required this.period,
  });

  factory PayRequest.fromJson(Map<String, dynamic> json) => PayRequest(
    clientId: json['clientId'],
    serviceId: json['serviceId'],
    period: json['period'],
  );
}
