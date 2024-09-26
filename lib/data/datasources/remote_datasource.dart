import 'dart:convert';
import 'package:flutter/services.dart' show AssetBundle;

class RemoteDataSource {
  final AssetBundle bundle;
  RemoteDataSource({required this.bundle});

  Future<Map<String, dynamic>> getData() async {
    final String response = await bundle.loadString('assets/api_data.json');
    final data = json.decode(response);
    return data;
  }
}
