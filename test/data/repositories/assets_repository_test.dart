import 'package:asset_flow/data/datasources/remote_datasource.dart';
import 'package:asset_flow/data/repositories/assets_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../get_sample_json.dart';
import 'assets_repository_test.mocks.dart';

@GenerateMocks([RemoteDataSource])
void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late AssetsRepository assetsRepository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    assetsRepository = AssetsRepository(mockRemoteDataSource);
  });

  test('Deve retornar uma lista de empresas quando getCompanies for chamado',
      () async {
    final expectedData = await getSampleJSON();

    when(mockRemoteDataSource.getData()).thenAnswer((_) async => expectedData);

    final result = await assetsRepository.getCompanies();

    expect(result.length, 3);
  });
}
