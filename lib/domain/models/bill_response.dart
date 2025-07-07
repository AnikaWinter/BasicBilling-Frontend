class BillResponse {
  final String id;
  final String clientId;
  final String serviceType;
  final String period;
  final int amount;
  final String? paymentDate;

  BillResponse({
    required this.id,
    required this.clientId,
    required this.serviceType,
    required this.period,
    required this.amount,
    this.paymentDate,
  });
}