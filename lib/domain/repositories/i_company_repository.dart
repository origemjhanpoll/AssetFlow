import 'package:asset_flow/domain/entities/company.dart';

abstract class ICompanyRepository {
  Future<List<Company>> getCompanies();
}
