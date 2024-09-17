import 'package:asset_flow/presentation/pages/companies_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asset Flow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: const Color(0xFF2563EB),
          seedColor: const Color(0xFF2563EB),
        ),
        useMaterial3: true,
      ),
      home: const CompaniesPage(),
    );
  }
}
