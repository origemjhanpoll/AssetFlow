import 'package:asset_flow/domain/entities/asset.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';

class FetchAssets {
  final IAssetsRepository repository;

  FetchAssets(this.repository);

  Future<List<Asset>> call({required String companyId}) async {
    return await repository.getAssets(companyId: companyId);
  }
}
