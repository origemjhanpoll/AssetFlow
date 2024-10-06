import 'package:asset_flow/domain/entities/branch.dart';
import 'package:asset_flow/utils/types.dart';

BranchType setBranchType(Branch branch) {
  if (branch.sensorType != null) {
    return BranchType.component;
  }

  if ((branch.locationId != null || branch.parentId != null) &&
      branch.sensorId == null) {
    return BranchType.asset;
  }

  return BranchType.component;
}

Branch updateBranchType(Branch branch, BranchType branchType) {
  return branch.copyWith(branchType: branchType);
}
