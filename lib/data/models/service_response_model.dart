import 'package:basic_billing_application/domain/models/service_response.dart';

class ServiceResponseModel {
  final String id;
  final String name;
  final String company;

  ServiceResponseModel({
    required this.id,
    required this.name,
    required this.company,
  });

  factory ServiceResponseModel.fromJson(Map<String, dynamic> json) =>
      ServiceResponseModel(
        id: json['id'],
        name: json['name'],
        company: json['company'],
      );

  ServiceResponse toDomain() =>
      ServiceResponse(id: id, name: name, company: company);
}
