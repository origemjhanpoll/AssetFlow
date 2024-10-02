import 'package:asset_flow/data/datasources/remote_datasource.dart';
import 'package:asset_flow/data/repositories/assets_repository.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';
import 'package:asset_flow/domain/usecases/filter_asset_and_location.dart';
import 'package:asset_flow/domain/usecases/get_companies.dart';
import 'package:asset_flow/domain/usecases/get_locations.dart';
import 'package:asset_flow/presentation/bloc/asset_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter/services.dart';

final di = GetIt.instance;

Future<void> init() async {
  di.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(bundle: rootBundle));
  di.registerLazySingleton<IAssetsRepository>(
    () => AssetsRepository(di<RemoteDataSource>()),
  );
  di.registerLazySingleton(() => GetCompanies(di<IAssetsRepository>()));
  di.registerLazySingleton(() => GetLocations(di<IAssetsRepository>()));
  di.registerLazySingleton(
      () => FilterAssetAndLocation(di<IAssetsRepository>()));

  di.registerFactory<AssetBloc>(
    () => AssetBloc(
      getCompanies: di<GetCompanies>(),
      getLocations: di<GetLocations>(),
      filterAssetAndLocation: di<FilterAssetAndLocation>(),
    ),
  );
}
