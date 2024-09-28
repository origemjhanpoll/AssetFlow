import 'package:asset_flow/domain/entities/asset.dart';
import 'package:asset_flow/domain/entities/company.dart';
import 'package:asset_flow/domain/entities/location.dart';
import 'package:asset_flow/domain/usecases/fetch_assets.dart';
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
  final FetchAssets fetchAssets;

  AssetBloc({
    required this.getCompanies,
    required this.getLocations,
    required this.getAssets,
    required this.fetchAssets,
  }) : super(AssetInitial()) {
    on<GetCompaniesEvent>(_getCompaniesEvent);
    on<GetLocationsEvent>(_getLocationsEvent);
    on<GetAssetsEvent>(_getAssetsEvent);
    on<AssetsLoadedEvent>(_assetsLoadedEvent);
  }

  void _getCompaniesEvent(
      GetCompaniesEvent event, Emitter<AssetState> emit) async {
    emit(Loading());
    try {
      final companies = await getCompanies();
      emit(AssetCompanies(companies: companies));
    } catch (e, s) {
      debugPrint('Erro: $e');
      debugPrint('Stack trace: $s');
    }
  }

  void _getLocationsEvent(
      GetLocationsEvent event, Emitter<AssetState> emit) async {
    emit(Loading());
    try {
      final locations =
          await getLocations(companyId: '662fd0ee639069143a8fc387');
      emit(AssetLocations(locations: locations));
    } catch (e, s) {
      debugPrint('Erro: $e');
      debugPrint('Stack trace: $s');
    }
  }

  void _getAssetsEvent(GetAssetsEvent event, Emitter<AssetState> emit) async {
    emit(Loading());
    try {
      final assets = await getAssets(companyId: '662fd0fab3fd5656edb39af5');
      emit(AssetsLoaded(assets: assets));
    } catch (e, s) {
      debugPrint('Erro: $e');
      debugPrint('Stack trace: $s');
    }
  }

  void _assetsLoadedEvent(
      AssetsLoadedEvent event, Emitter<AssetState> emit) async {
    emit(Loading());
    try {
      final assets = await fetchAssets(companyId: event.companyId);
      emit(AssetsLoaded(assets: assets));
    } catch (e, s) {
      debugPrint('Erro: $e');
      debugPrint('Stack trace: $s');
    }
  }
}
