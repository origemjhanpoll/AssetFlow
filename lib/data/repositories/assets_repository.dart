import 'package:asset_flow/data/datasources/local_datasource.dart';
import 'package:asset_flow/domain/entities/company.dart';
import 'package:asset_flow/domain/repositories/i_company_repository.dart';

class AssetsRepository implements ICompanyRepository {
  final ApiDataSource apiDataSource;

  AssetsRepository(this.apiDataSource);

  @override
  Future<List<Company>> getCompanies() async {
    final apiData = await apiDataSource.getApiData();
    final List companiesJson = apiData['companies'];

    return companiesJson.map((json) => Company.fromJson(json)).toList();
  }
}
