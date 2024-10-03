import 'package:asset_flow/domain/entities/branch.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';

class FilterBranchs {
  final IAssetsRepository repository;

  FilterBranchs(this.repository);

  Future<List<Branch>> call({required String companyId}) async {
    return await repository.getAssets(companyId: companyId);
  }
}
