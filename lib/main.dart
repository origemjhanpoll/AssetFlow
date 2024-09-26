import 'package:asset_flow/injection.dart' as di;
import 'package:asset_flow/presentation/pages/companies_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

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
          primary: const Color(0xFF0F75E3),
          seedColor: const Color(0xFF0F75E3),
        ),
        useMaterial3: true,
      ),
      home: const CompaniesPage(),
    );
  }
}
