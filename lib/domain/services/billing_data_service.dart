import 'package:basic_billing_application/core/result.dart';
import 'package:basic_billing_application/domain/models/service_response.dart';
import 'package:basic_billing_application/domain/repositories/client_repository.dart';
import 'package:basic_billing_application/domain/repositories/service_repository.dart';

class BillingDataService {
  final ServiceRepository _serviceRepo;
  final ClientRepository _clientRepo;

  List<String> clientIds = [];
  List<ServiceResponse> services = [];

  BillingDataService(this._serviceRepo, this._clientRepo);

  Future<List<String>> loadClientData() async {
    final clientResult = await _clientRepo.getClients();
    print('clientResult: $clientResult');

    if (clientResult is Success<List<String>>) {
      return (clientResult.data);
    } else if (clientResult is Failure<List<String>>) {
      throw Exception(
        'Failed to load client dropdown data. \n Error: ${clientResult.message}',
      );
    } else {
      throw Exception('Unexpected error.');
    }
  }

  Future<List<ServiceResponse>> loadServiceData() async {
    final serviceResult = await _serviceRepo.getServices();
    print('serviceResult: $serviceResult');

    if (serviceResult is Success<List<ServiceResponse>>) {
      return (serviceResult.data);
    } else if (serviceResult is Failure<List<ServiceResponse>>) {
      throw Exception(
        'Failed to load service dropdown data \n Error: ${serviceResult.message}',
      );
    } else {
      throw Exception('Unexpected error.');
    }
  }
}
