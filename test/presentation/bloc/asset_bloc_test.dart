import 'package:asset_flow/domain/entities/company.dart';
import 'package:asset_flow/domain/usecases/get_companies.dart';
import 'package:asset_flow/presentation/bloc/asset_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'asset_bloc_test.mocks.dart';

@GenerateMocks([GetCompanies])
void main() {
  late AssetBloc assetBloc;
  late MockGetCompanies mockGetCompanies;

  setUp(() {
    mockGetCompanies = MockGetCompanies();
    assetBloc = AssetBloc(getCompanies: mockGetCompanies);
  });

  tearDown(() {
    assetBloc.close();
  });

  blocTest<AssetBloc, AssetState>(
    'emits a companies list empty when GetCompaniesEvent is added',
    build: () {
      when(mockGetCompanies()).thenAnswer((_) async => []);
      return assetBloc;
    },
    act: (bloc) => bloc.add(GetCompaniesEvent()),
    expect: () => [
      const Companies(companies: []),
    ],
  );

  blocTest<AssetBloc, AssetState>(
    'emits List Companies when GetCompaniesEvent is added',
    build: () {
      when(mockGetCompanies()).thenAnswer((_) async => [
            const Company(id: '662fd0fab3fd5656edb39af5', name: 'Tobias'),
            const Company(id: '662fd0ee639069143a8fc387', name: 'Jaguar'),
          ]);
      return assetBloc;
    },
    act: (bloc) => bloc.add(GetCompaniesEvent()),
    expect: () => [
      const Companies(companies: [
        Company(id: '662fd0fab3fd5656edb39af5', name: 'Tobias'),
        Company(id: '662fd0ee639069143a8fc387', name: 'Jaguar'),
      ]),
    ],
  );
}
