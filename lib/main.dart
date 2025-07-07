import 'package:basic_billing_application/di/auth_providers.dart';
import 'package:basic_billing_application/di/billing_providers.dart';
import 'package:basic_billing_application/di/router.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() {
  // Logging configuration
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });
  runApp(MultiProvider(
      providers: [...authProviders, ...billingProviders],
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Basic Billing App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(176, 238, 150, 17)),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
