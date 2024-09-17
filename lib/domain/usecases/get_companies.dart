import 'package:asset_flow/domain/entities/company.dart';
import 'package:asset_flow/domain/repositories/i_company_repository.dart';

class GetCompanies {
  final ICompanyRepository repository;

  GetCompanies(this.repository);

  Future<List<Company>> call() async {
    return await repository.getCompanies();
  }
}
