import 'package:asset_flow/data/datasources/remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'remote_datasource_test.mocks.dart';

void main() {
  late RemoteDataSource dataSource;
  late MockAssetBundle mockAssetBundle;

  setUp(() {
    mockAssetBundle = MockAssetBundle();
    dataSource = RemoteDataSource(bundle: mockAssetBundle);
  });

  group('ApiDataSource Test', () {
    test('deve retornar dados JSON corretamente ao carregar asset', () async {
      const mockJsonString = '{"key": "value"}';

      when(mockAssetBundle.loadString('assets/api_data.json'))
          .thenAnswer((_) async => mockJsonString);

      final result = await dataSource.getData();

      expect(result, equals({"key": "value"}));
    });

    test('deve lançar uma exceção se o arquivo JSON não for encontrado',
        () async {
      when(mockAssetBundle.loadString('assets/api_data.json'))
          .thenThrow(Exception('Arquivo não encontrado'));

      expect(() => dataSource.getData(), throwsException);
    });
  });
}
