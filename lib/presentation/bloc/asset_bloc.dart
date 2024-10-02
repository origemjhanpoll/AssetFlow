import 'package:asset_flow/domain/entities/company.dart';
import 'package:asset_flow/domain/entities/location.dart';
import 'package:asset_flow/domain/usecases/filter_asset_and_location.dart';
import 'package:asset_flow/domain/usecases/get_companies.dart';
import 'package:asset_flow/domain/usecases/get_locations.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final GetCompanies getCompanies;
  final GetLocations getLocations;
  final FilterAssetAndLocation filterAssetAndLocation;

  AssetBloc({
    required this.getCompanies,
    required this.getLocations,
    required this.filterAssetAndLocation,
  }) : super(AssetInitial()) {
    on<GetCompaniesEvent>(_getCompaniesEvent);
    on<AssetsLoadedEvent>(_assetsLoadedEvent);
  }

  void _getCompaniesEvent(
      GetCompaniesEvent event, Emitter<AssetState> emit) async {
    emit(Loading());
    try {
      final companies = await getCompanies();
      emit(CompaniesLoaded(companies: companies));
    } catch (e, s) {
      debugPrint('Erro: $e');
      debugPrint('Stack trace: $s');
    }
  }

  void _assetsLoadedEvent(
      AssetsLoadedEvent event, Emitter<AssetState> emit) async {
    emit(Loading());
    try {
      final locations = await getLocations(companyId: event.companyId);
      emit(AssetsLoaded(locations: locations));
    } catch (e, s) {
      debugPrint('Erro: $e');
      debugPrint('Stack trace: $s');
    }
  }
}
