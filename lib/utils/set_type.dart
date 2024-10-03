import 'package:asset_flow/domain/entities/branch.dart';
import 'package:asset_flow/utils/item_type.dart';

ItemType setType(Branch branch) {
  if (branch.sensorType != null) {
    return ItemType.component;
  }

  if ((branch.locationId != null || branch.parentId != null) &&
      branch.sensorId == null) {
    return ItemType.asset;
  }

  return ItemType.component;
}
