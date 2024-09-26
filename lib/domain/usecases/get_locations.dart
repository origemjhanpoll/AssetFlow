import 'package:asset_flow/domain/entities/location.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';

class GetLocations {
  final IAssetsRepository repository;

  GetLocations(this.repository);

  Future<List<Location>> call({required String companyId}) async {
    return await repository.getLocations(companyId: companyId);
  }
}
