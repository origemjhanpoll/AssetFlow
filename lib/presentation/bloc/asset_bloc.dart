import 'package:asset_flow/domain/entities/asset.dart';
import 'package:asset_flow/domain/entities/company.dart';
import 'package:asset_flow/domain/entities/location.dart';
import 'package:asset_flow/domain/usecases/get_assets.dart';
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
  final GetAssets getAssets;

  AssetBloc({
    required this.getCompanies,
    required this.getLocations,
    required this.getAssets,
  }) : super(AssetInitial()) {
    on<GetCompaniesEvent>(_getCompaniesEvent);
    on<GetLocationsEvent>(_getLocationsEvent);
    on<GetAssetsEvent>(_getAssetsEvent);
  }

  void _getCompaniesEvent(
      GetCompaniesEvent event, Emitter<AssetState> emit) async {
    emit(Loading());
    try {
      final companies = await getCompanies();
      emit(AssetCompanies(companies: companies));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _getLocationsEvent(
      GetLocationsEvent event, Emitter<AssetState> emit) async {
    emit(Loading());
    try {
      final locations =
          await getLocations(companyId: '662fd0ee639069143a8fc387');
      emit(AssetLocations(locations: locations));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _getAssetsEvent(GetAssetsEvent event, Emitter<AssetState> emit) async {
    emit(Loading());
    try {
      final assets = await getAssets(companyId: '662fd0fab3fd5656edb39af5');
      emit(AssetLoaded(assets: assets));
    } catch (e, s) {
      debugPrint('Erro: $e');
      debugPrint('Stack trace: $s');
    }
  }
}
