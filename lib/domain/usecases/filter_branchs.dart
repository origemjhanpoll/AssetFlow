import 'package:asset_flow/domain/entities/branch.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';
import 'package:asset_flow/utils/set_types.dart';
import 'package:asset_flow/utils/types.dart';

class FilterBranchs {
  final IAssetsRepository repository;

  FilterBranchs(this.repository);

  Future<List<Branch>> call(
      {required String companyId, required String query}) async {
    var locations = await repository.getLocations(companyId: companyId);
    var assets = await repository.getAssets(companyId: companyId);

    final branchs = [
      ...locations.map((loc) => updateBranchType(loc, BranchType.location)),
      ...assets.map((asset) => updateBranchType(asset, setBranchType(asset))),
    ];

    return branchs;
  }
}
