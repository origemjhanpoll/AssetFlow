import 'package:asset_flow/domain/entities/company.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';

class GetCompanies {
  final IAssetsRepository repository;

  GetCompanies(this.repository);

  Future<List<Company>> call() async {
    final companies = await repository.getCompanies();

    final updatedCompanies = Future.wait(companies.map((element) async {
      final assets = await repository.getAssets(companyId: element.id);

      return element.copyWith(assetCount: assets.length);
    }).toList());

    return updatedCompanies;
  }
}
