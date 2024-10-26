import 'package:asset_flow/domain/entities/branch.dart';

class FilterBranchs {
  Future<List<Branch>> call(
      {required List<Branch> tree, required String query}) async {
    List<Branch> filteredTree = [];

    for (var branch in tree) {
      var filteredBranch = _filterBranchRecursive(branch, query);
      if (filteredBranch != null) {
        filteredTree.add(filteredBranch);
      }
    }

    return filteredTree;
  }
}

Branch? _filterBranchRecursive(Branch branch, String query) {
  bool matchesCurrent = branch.name.toLowerCase().contains(query.toLowerCase());

  List<Branch> filteredChildren = [];
  for (var child in branch.branches) {
    var filteredChild = _filterBranchRecursive(child, query);
    if (filteredChild != null) {
      filteredChildren.add(filteredChild);
    }
  }

  if (matchesCurrent || filteredChildren.isNotEmpty) {
    return branch.copyWith(branches: filteredChildren);
  }

  return null;
}
