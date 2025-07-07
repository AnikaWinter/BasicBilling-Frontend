import 'package:basic_billing_application/core/result.dart';
import 'package:basic_billing_application/data/services/service_service.dart';
import 'package:basic_billing_application/domain/models/service_response.dart';

class ServiceRepository {
  final ServiceService _serviceApi;

  ServiceRepository({required ServiceService serviceApi}) : _serviceApi = serviceApi;

  Future<Result<List<ServiceResponse>>> getServices() async {
    try {
      final result = await _serviceApi.getServices();
      final services = result.map((c) => c.toDomain()).toList();
      return Success(services);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}