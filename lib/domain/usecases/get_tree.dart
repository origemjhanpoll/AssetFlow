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

    assets = assets
        .map((element) => element.copyWith(branchType: setBranchType(element)))
        .toList();

    locations = locations
        .map((element) => element.copyWith(branchType: BranchType.location))
        .toList();

    final branchs = [...locations, ...assets];
    final tree = _buildTree(branchs);

    return tree;
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
