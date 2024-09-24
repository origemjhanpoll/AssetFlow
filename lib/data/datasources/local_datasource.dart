import 'dart:convert';
import 'dart:io';

class ApiDataSource {
  Future<Map<String, dynamic>> getApiData() async {
    final String response = await File('assets/api_data.json').readAsString();
    final data = json.decode(response);
    return data;
  }
}
