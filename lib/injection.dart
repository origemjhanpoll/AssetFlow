import 'package:asset_flow/data/datasources/remote_datasource.dart';
import 'package:asset_flow/data/repositories/assets_repository.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';
import 'package:asset_flow/domain/usecases/filter_branchs.dart';
import 'package:asset_flow/domain/usecases/get_companies.dart';
import 'package:asset_flow/domain/usecases/get_tree.dart';
import 'package:asset_flow/presentation/bloc/tree_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final di = GetIt.instance;

Future<void> init() async {
  di.registerLazySingleton<http.Client>(() => http.Client());

  di.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(client: di<http.Client>()));
  di.registerLazySingleton<IAssetsRepository>(
    () => AssetsRepository(di<RemoteDataSource>()),
  );
  di.registerLazySingleton(() => GetCompanies(di<IAssetsRepository>()));
  di.registerLazySingleton(() => GetTree(di<IAssetsRepository>()));
  di.registerLazySingleton(() => FilterBranchs());

  di.registerFactory<TreeBloc>(
    () => TreeBloc(
      getCompanies: di<GetCompanies>(),
      getTree: di<GetTree>(),
      filterBranchs: di<FilterBranchs>(),
    ),
  );
}
