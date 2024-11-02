import 'package:asset_flow/domain/entities/branch.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';

class FilterBranchs {
  final IAssetsRepository repository;

  FilterBranchs(this.repository);

  Future<List<Branch>> call(
      {required List<Branch> tree, required String query}) async {
    List<Branch> exactMatches = [];

    final regex = RegExp(query, caseSensitive: false);

    for (var branch in tree) {
      if (regex.hasMatch(branch.name.toLowerCase())) {
        exactMatches.add(branch);
      }
    }

    return exactMatches;
  }
}

Branch? _filterBranchRecursive(Branch branch, RegExp regex) {
  bool matchesCurrent = regex.hasMatch(branch.name);

  List<Branch> filteredChildren = [];
  for (var child in branch.branches) {
    var filteredChild = _filterBranchRecursive(child, regex);
    if (filteredChild != null) {
      filteredChildren.add(filteredChild);
    }
  }

  if (matchesCurrent || filteredChildren.isNotEmpty) {
    return branch.copyWith(branches: filteredChildren);
  }

  return null;
}
