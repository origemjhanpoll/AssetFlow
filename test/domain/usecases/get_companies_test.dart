import 'package:asset_flow/domain/entities/company.dart';
import 'package:asset_flow/domain/repositories/i_company_repository.dart';
import 'package:asset_flow/domain/usecases/get_companies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_companies_test.mocks.dart';

@GenerateMocks([ICompanyRepository])
void main() {
  late GetCompanies usecase;
  late MockICompanyRepository mockRepository;

  setUp(() {
    mockRepository = MockICompanyRepository();
    usecase = GetCompanies(mockRepository);
  });
  test('should return list of companies from the repository', () async {
    final companyList = [
      Company(id: '662fd0fab3fd5656edb39af5', name: 'Tobias'),
      Company(id: '662fd0ee639069143a8fc387', name: 'Jaguar'),
    ];
    when(mockRepository.getCompanies()).thenAnswer((_) async => companyList);

    final result = await usecase.call();

    expect(result, companyList);
    verify(mockRepository.getCompanies()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
