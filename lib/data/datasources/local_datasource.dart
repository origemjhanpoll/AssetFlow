import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ApiDataSource {
  Future<Map<String, dynamic>> getApiData() async {
    final String response = await rootBundle.loadString('assets/api_data.json');
    final data = json.decode(response);
    return data;
  }
}
