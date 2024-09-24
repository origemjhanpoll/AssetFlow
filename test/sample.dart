import 'dart:convert';
import 'dart:io';

Future<Map<String, dynamic>> getSampleJSON() async {
  final fileContent = await File('assets/api_data.json').readAsString();
  return jsonDecode(fileContent);
}
