import 'package:basic_billing_application/data/services/auth_service.dart';
import 'package:basic_billing_application/domain/repositories/auth_repository.dart';
import 'package:basic_billing_application/ui/features/auth/viewModels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

final authProviders = [
  Provider(create: (_) => AuthService()),

  ProxyProvider<AuthService, AuthRepository>(
    update: (_, authService, __) => AuthRepository(authService: authService),
  ),

  ChangeNotifierProxyProvider<AuthRepository, AuthViewModel>(
    create: (_) => AuthViewModel(),
     update: (_, authRepository, vm) => vm!..updateRepository(authRepository),
  ),
];