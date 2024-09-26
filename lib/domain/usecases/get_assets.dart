import 'package:asset_flow/domain/entities/asset.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';

class GetAssets {
  final IAssetsRepository repository;

  GetAssets(this.repository);

  Future<List<Asset>> call({required String companyId}) async {
    return await repository.getAssets(companyId: companyId);
  }
}
