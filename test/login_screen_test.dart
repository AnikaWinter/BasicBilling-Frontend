import 'package:basic_billing_application/ui/features/auth/viewModels/auth_viewmodel.dart';
import 'package:basic_billing_application/ui/features/auth/widgets/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'mocks.mocks.dart';

void main() {
  late MockAuthViewModel mockAuthViewModel;
  late GoRouter router;

  setUp(() {
    mockAuthViewModel = MockAuthViewModel();

    router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const Scaffold(body: Center(child: Text('Home Screen'))),
        ),
      ],
    );
  });

  testWidgets('Shows error message when login fails', (WidgetTester tester) async {
    // Arrange
    when(mockAuthViewModel.isLoading).thenReturn(false);
    when(mockAuthViewModel.errorMessage).thenReturn('Login failed');
    when(mockAuthViewModel.login('u', 'p')).thenAnswer((_) async => false);

    // Act
    await tester.pumpWidget(
      ChangeNotifierProvider<AuthViewModel>.value(
        value: mockAuthViewModel,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );
    await tester.pump();

    // Assert
    expect(find.text('Login failed'), findsOneWidget);
  });

  testWidgets('Successful login navigates to /home', (tester) async {
    // Arrange
    when(mockAuthViewModel.isLoading).thenReturn(false);
    when(mockAuthViewModel.errorMessage).thenReturn(null);
    when(mockAuthViewModel.login(any, any)).thenAnswer((_) async => true);

    await tester.pumpWidget(
      ChangeNotifierProvider<AuthViewModel>.value(
        value: mockAuthViewModel,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    // Enter username and password
    await tester.enterText(find.byType(TextFormField).at(0), 'user');
    await tester.enterText(find.byType(TextFormField).at(1), 'pass');

    // Tap the login button
    await tester.tap(find.text('Login'));

    // Trigger async calls and rebuilds
    await tester.pumpAndSettle();

    // Verify navigation to /home
    expect(find.text('Home Screen'), findsOneWidget);

    // Verify login method called with correct params
    verify(mockAuthViewModel.login('user', 'pass')).called(1);
  });

  testWidgets('Shows loading indicator while loading', (tester) async {
    // Arrange
    when(mockAuthViewModel.isLoading).thenReturn(true);
    when(mockAuthViewModel.errorMessage).thenReturn(null);

    await tester.pumpWidget(
      ChangeNotifierProvider<AuthViewModel>.value(
        value: mockAuthViewModel,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    // Assert CircularProgressIndicator is shown
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
