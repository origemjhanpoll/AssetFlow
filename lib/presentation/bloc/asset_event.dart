part of 'asset_bloc.dart';

sealed class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object> get props => [];
}

final class GetCompaniesEvent extends AssetEvent {}

final class GetLocationsEvent extends AssetEvent {}

final class GetAssetsEvent extends AssetEvent {}
