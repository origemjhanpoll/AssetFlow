import 'package:asset_flow/domain/entities/location.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';
import 'package:flutter/foundation.dart';

class GetLocations {
  final IAssetsRepository repository;

  GetLocations(this.repository);

  Future<List<Location>> call({required String companyId}) async {
    final locations = await repository.getLocations(companyId: companyId);

    var updateLocation = List<Location>.from(locations);

    for (var location in updateLocation) {
      var parentIds = [];
      for (var element in updateLocation) {
        parentIds.add(element.parentId);
      }

      if (parentIds.contains(location.id)) {
        location.copyWith();
      }
    }
    if (kDebugMode) {
      print(updateLocation);
    }
    return updateLocation;
  }
}
