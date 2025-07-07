import 'package:basic_billing_application/core/result.dart';
import 'package:basic_billing_application/data/services/client_service.dart';

class ClientRepository {
  final ClientService _clientApi;

  ClientRepository({required ClientService clientApi}) : _clientApi = clientApi;

  Future<Result<List<String>>> getClients() async {
    try {
      final result = await _clientApi.getClients();
      final ids = result.map((c) => c.id).toList();
      return Success(ids);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}