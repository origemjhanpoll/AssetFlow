import 'package:asset_flow/data/datasources/local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../get_sample_json.dart';

const path = 'assets/api_data.json';

void main() {
  late ApiDataSource apiDataSource;

  setUp(() {
    apiDataSource = ApiDataSource();
  });

  test('Deve retornar dados do arquivo JSON corretamente', () async {
    final expectedData = await getSampleJSON();

    final result = await apiDataSource.getApiData();

    expectLater(result, expectedData);
  });
}
