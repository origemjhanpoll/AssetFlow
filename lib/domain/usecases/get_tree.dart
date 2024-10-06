import 'package:asset_flow/domain/entities/branch.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';
import 'package:asset_flow/utils/types.dart';
import 'package:asset_flow/utils/set_types.dart';

class GetTree {
  final IAssetsRepository repository;

  GetTree(this.repository);

  Future<List<Branch>> call({required String companyId}) async {
    var locations = await repository.getLocations(companyId: companyId);
    var assets = await repository.getAssets(companyId: companyId);

    final branchs = [
      ...locations.map((loc) => updateBranchType(loc, BranchType.location)),
      ...assets.map((asset) => updateBranchType(asset, setBranchType(asset))),
    ];

    return _buildTree(branchs);
  }
}

List<Branch> _buildTree(List<Branch> branchs) {
  Map<String, Branch> map = {for (var item in branchs) item.id: item};
  List<Branch> tree = [];

  for (var item in branchs) {
    var parentId = item.parentId;
    var locationId = item.locationId;

    if (parentId != null && map.containsKey(parentId)) {
      map[parentId]?.branches.add(item);
    } else if (locationId != null && map.containsKey(locationId)) {
      map[locationId]?.branches.add(item);
    } else {
      tree.add(item);
    }
  }

  return tree;
}
