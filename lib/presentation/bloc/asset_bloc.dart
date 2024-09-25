import 'package:asset_flow/domain/entities/company.dart';
import 'package:asset_flow/domain/usecases/get_companies.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final GetCompanies getCompanies;

  AssetBloc({required this.getCompanies}) : super(AssetInitial()) {
    on<GetCompaniesEvent>(_getCompaniesEvent);
  }

  void _getCompaniesEvent(
      GetCompaniesEvent event, Emitter<AssetState> emit) async {
    try {
      final companies = await getCompanies();
      emit(Companies(companies: companies));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
