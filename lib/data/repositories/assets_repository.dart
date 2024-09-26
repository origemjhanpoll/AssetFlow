import 'package:asset_flow/data/datasources/remote_datasource.dart';
import 'package:asset_flow/domain/entities/asset.dart';
import 'package:asset_flow/domain/entities/company.dart';
import 'package:asset_flow/domain/entities/location.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';

class AssetsRepository implements IAssetsRepository {
  final RemoteDataSource remote;

  AssetsRepository(this.remote);

  @override
  Future<List<Company>> getCompanies() async {
    final data = await remote.getData();
    final List companiesJson = data['companies'];

    return companiesJson.map((json) => Company.fromJson(json)).toList();
  }

  @override
  Future<List<Asset>> getAssets({required String companyId}) async {
    final data = await remote.getData();
    final List assetsJson = data[companyId]['assets'];
    return assetsJson.map((json) => Asset.fromJson(json)).toList();
  }

  @override
  Future<List<Location>> getLocations({required String companyId}) async {
    final data = await remote.getData();
    final List locationsJson = data[companyId]['locations'];
    return locationsJson.map((json) => Location.fromJson(json)).toList();
  }
}
