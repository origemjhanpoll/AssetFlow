import 'package:asset_flow/data/datasources/remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late RemoteDataSource dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = RemoteDataSource(client: mockHttpClient);
  });

  group('ApiDataSource Test', () {
    test('deve retornar dados JSON corretamente ao carregar asset', () async {
      const mockJsonString = '{"key": "value"}';

      when(mockHttpClient.get(Uri()))
          .thenAnswer((_) async => http.Response(mockJsonString, 200));

      final result = await dataSource.getData();

      expect(result, equals({"key": "value"}));
    });

    test('deve lançar uma exceção se o arquivo JSON não for encontrado',
        () async {
      when(mockHttpClient.get(Uri()))
          .thenThrow(Exception('Arquivo não encontrado'));

      expect(() => dataSource.getData(), throwsException);
    });
  });
}
