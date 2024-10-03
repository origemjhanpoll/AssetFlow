import 'package:asset_flow/domain/entities/branch.dart';
import 'package:asset_flow/domain/entities/company.dart';

abstract class IAssetsRepository {
  Future<List<Company>> getCompanies();
  Future<List<Branch>> getLocations({required String companyId});
  Future<List<Branch>> getAssets({required String companyId});
}
