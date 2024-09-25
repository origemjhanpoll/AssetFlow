// Mocks generated by Mockito 5.4.4 from annotations
// in asset_flow/test/presentation/bloc/asset_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:asset_flow/domain/entities/company.dart' as _i5;
import 'package:asset_flow/domain/repositories/i_company_repository.dart'
    as _i2;
import 'package:asset_flow/domain/usecases/get_companies.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeICompanyRepository_0 extends _i1.SmartFake
    implements _i2.ICompanyRepository {
  _FakeICompanyRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetCompanies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetCompanies extends _i1.Mock implements _i3.GetCompanies {
  MockGetCompanies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ICompanyRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeICompanyRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.ICompanyRepository);

  @override
  _i4.Future<List<_i5.Company>> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i4.Future<List<_i5.Company>>.value(<_i5.Company>[]),
      ) as _i4.Future<List<_i5.Company>>);
}