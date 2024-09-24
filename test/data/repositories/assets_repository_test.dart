import 'package:asset_flow/data/datasources/local_datasource.dart';
import 'package:asset_flow/data/repositories/assets_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../get_sample_json.dart';
import 'assets_repository_test.mocks.dart';

@GenerateMocks([ApiDataSource])
void main() {
  late MockApiDataSource mockApiDataSource;
  late AssetsRepository assetsRepository;

  setUp(() {
    mockApiDataSource = MockApiDataSource();
    assetsRepository = AssetsRepository(mockApiDataSource);
  });

  test('Deve retornar uma lista de empresas quando getCompanies for chamado',
      () async {
    final expectedData = await getSampleJSON();

    when(mockApiDataSource.getApiData()).thenAnswer((_) async => expectedData);

    final result = await assetsRepository.getCompanies();

    expect(result.length, 3);
  });
}
