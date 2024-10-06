import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RemoteDataSource {
  final http.Client client;

  // Injeção do cliente HTTP via construtor
  RemoteDataSource({required this.client});

  Future<Map<String, dynamic>?> getData() async {
    const url =
        'https://raw.githubusercontent.com/origemjhanpoll/AssetFlow/refs/heads/main/assets/api_data.json';

    debugPrint('getData');

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        debugPrint('Failed to load JSON. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e, stacktrace) {
      debugPrint('Error fetching data: $e');
      debugPrint('Stacktrace: $stacktrace');
      return null;
    }
  }
}
