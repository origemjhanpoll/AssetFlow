import 'package:asset_flow/data/datasources/remote_datasource.dart';
import 'package:asset_flow/domain/entities/branch.dart';
import 'package:asset_flow/domain/entities/company.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';

class AssetsRepository implements IAssetsRepository {
  final RemoteDataSource remote;

  AssetsRepository(this.remote);

  @override
  Future<List<Company>> getCompanies() async {
    final data = await remote.getData();
    final List<dynamic>? companiesJson = data?['companies'];

    if (companiesJson != null) {
      return companiesJson.map((json) => Company.fromJson(json)).toList();
    } else {
      throw Exception("No companies data found.");
    }
  }

  @override
  Future<List<Branch>> getAssets({required String companyId}) async {
    final data = await remote.getData();
    final List<dynamic>? assetsJson = data?[companyId]['assets'];

    if (assetsJson != null) {
      return assetsJson.map((json) => Branch.fromJson(json)).toList();
    } else {
      throw Exception("No assets data found.");
    }
  }

  @override
  Future<List<Branch>> getLocations({required String companyId}) async {
    final data = await remote.getData();
    final List<dynamic>? locationsJson = data![companyId]['locations'];
    if (locationsJson != null) {
      return locationsJson.map((json) => Branch.fromJson(json)).toList();
    } else {
      throw Exception("No locations data found.");
    }
  }
}
