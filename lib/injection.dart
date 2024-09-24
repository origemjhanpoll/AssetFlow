import 'package:asset_flow/data/datasources/local_datasource.dart';
import 'package:asset_flow/data/repositories/assets_repository.dart';
import 'package:asset_flow/domain/repositories/i_company_repository.dart';
import 'package:asset_flow/domain/usecases/get_companies.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> init() async {
  di.registerLazySingleton<ApiDataSource>(() => ApiDataSource());
  di.registerLazySingleton<AssetsRepository>(
    () => AssetsRepository(di<ApiDataSource>()),
  );
  di.registerLazySingleton(() => GetCompanies(di<ICompanyRepository>()));
}
