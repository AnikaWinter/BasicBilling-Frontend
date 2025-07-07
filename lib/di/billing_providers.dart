import 'package:basic_billing_application/data/services/billing_service.dart';
import 'package:basic_billing_application/data/services/client_service.dart';
import 'package:basic_billing_application/data/services/service_service.dart';
import 'package:basic_billing_application/domain/repositories/bill_repository.dart';
import 'package:basic_billing_application/domain/repositories/client_repository.dart';
import 'package:basic_billing_application/domain/repositories/service_repository.dart';
import 'package:basic_billing_application/domain/services/billing_data_service.dart';
import 'package:basic_billing_application/ui/features/billing/viewModels/manage_bill_viewmodel.dart';
import 'package:basic_billing_application/ui/features/billing/viewModels/view_bills_viewmodel.dart';
import 'package:provider/provider.dart';

final billingProviders = [
  Provider(create: (_) => BillingService()),
  Provider(create: (_) => ClientService()),
  Provider(create: (_) => ServiceService()),

  ProxyProvider<BillingService, BillRepository>(
    update: (_, billingApi, __) => BillRepository(billingApi: billingApi),
  ),
  ProxyProvider<ClientService, ClientRepository>(
    update: (_, clientApi, __) => ClientRepository(clientApi: clientApi),
  ),
  ProxyProvider<ServiceService, ServiceRepository>(
    update: (_, serviceApi, __) => ServiceRepository(serviceApi: serviceApi),
  ),

  ProxyProvider2<ServiceRepository, ClientRepository, BillingDataService>(
    update: (_, serviceRepo, clientRepo, __) =>
        BillingDataService(serviceRepo, clientRepo),
  ),

  ChangeNotifierProxyProvider2<BillRepository, BillingDataService, ManageBillViewModel>(
    create: (_) => ManageBillViewModel(),
    update: (_, billRepo, billingData, vm) =>
        vm!..updateRepositories(billRepo: billRepo, billingData: billingData)
  ),

  ChangeNotifierProxyProvider2<BillRepository, BillingDataService, ViewBillsViewModel>(
    create: (_) => ViewBillsViewModel(),
    update: (_, billRepo, billingData, vm) =>
        vm!..updateRepositories(billRepo: billRepo, billingData: billingData)
  ),
];