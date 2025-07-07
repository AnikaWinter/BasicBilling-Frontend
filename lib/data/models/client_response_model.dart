import 'package:basic_billing_application/domain/models/client_response.dart';

class ClientResponseModel {
    final String id;
    final String firstName;
    final String lastName;
    final int numOfBills;

  ClientResponseModel({required this.id, required this.firstName, required this.lastName, required this.numOfBills});

  factory ClientResponseModel.fromJson(Map<String, dynamic> json) =>
      ClientResponseModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        numOfBills: json['numOfBills'],
      );

  ClientResponse toDomain() => ClientResponse(
    id: id,
    firstName: firstName,
    lastName: lastName,
    numOfBills: numOfBills,
  );
}