import 'package:basic_billing_application/ui/features/auth/widgets/login_screen.dart';
import 'package:basic_billing_application/ui/features/billing/widgets/home_screen.dart';
import 'package:basic_billing_application/ui/features/billing/widgets/view_bills_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/pending-bills', builder: (context, state) => ViewBillsScreen(status: 'pending',)),
    GoRoute(path: '/payment-history', builder: (context, state) => ViewBillsScreen(status: 'paid'))
  ],
);
