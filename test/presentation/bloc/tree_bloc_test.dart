// import 'package:asset_flow/domain/entities/company.dart';
// import 'package:asset_flow/domain/usecases/filter_elements.dart';
// import 'package:asset_flow/domain/usecases/get_companies.dart';
// import 'package:asset_flow/domain/usecases/get_locations.dart';
// import 'package:asset_flow/presentation/bloc/tree_bloc.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// @GenerateMocks([GetCompanies, GetLocations, FilterBranch])
// void main() {
//   late TreeBloc assetBloc;
//   late MockGetCompanies mockGetCompanies;
//   late MockGetLocations mockGetLocations;
//   late MockFilterAssetAndLocation mockFilterAssetAndLocation;

//   setUp(() {
//     mockGetCompanies = MockGetCompanies();
//     mockGetLocations = MockGetLocations();
//     mockFilterAssetAndLocation = MockFilterAssetAndLocation();

//     assetBloc = TreeBloc(
//       getCompanies: mockGetCompanies,
//       getLocations: mockGetLocations,
//       filterAssetAndLocation: mockFilterAssetAndLocation,
//     );
//   });

//   tearDown(() {
//     assetBloc.close();
//   });

//   blocTest<TreeBloc, TreeState>(
//     'emits a companies list empty when GetCompaniesEvent is added',
//     build: () {
//       when(mockGetCompanies()).thenAnswer((_) async => []);
//       return assetBloc;
//     },
//     act: (bloc) => bloc.add(GetCompaniesEvent()),
//     expect: () => [
//       const CompaniesLoaded(companies: []),
//     ],
//   );

//   blocTest<TreeBloc, TreeState>(
//     'emits List Companies when GetCompaniesEvent is added',
//     build: () {
//       when(mockGetCompanies()).thenAnswer((_) async => [
//             const Company(id: '662fd0fab3fd5656edb39af5', name: 'Tobias'),
//             const Company(id: '662fd0ee639069143a8fc387', name: 'Jaguar'),
//           ]);
//       return assetBloc;
//     },
//     act: (bloc) => bloc.add(GetCompaniesEvent()),
//     expect: () => [
//       const CompaniesLoaded(companies: [
//         Company(id: '662fd0fab3fd5656edb39af5', name: 'Tobias'),
//         Company(id: '662fd0ee639069143a8fc387', name: 'Jaguar'),
//       ]),
//     ],
//   );
// }
