import 'package:asset_flow/domain/entities/asset.dart';
import 'package:asset_flow/domain/entities/company.dart';
import 'package:asset_flow/domain/entities/location.dart';

abstract class IAssetsRepository {
  Future<List<Company>> getCompanies();
  Future<List<Location>> getLocations({required String companyId});
  Future<List<Asset>> getAssets({required String companyId});
}
