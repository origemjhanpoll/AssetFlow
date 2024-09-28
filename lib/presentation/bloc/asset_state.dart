part of 'asset_bloc.dart';

sealed class AssetState extends Equatable {
  const AssetState();

  @override
  List<Object> get props => [];
}

final class AssetInitial extends AssetState {}

final class Loading extends AssetState {}

final class AssetCompanies extends AssetState {
  final List<Company> companies;
  const AssetCompanies({required this.companies});

  @override
  List<Object> get props => [companies];
}

final class AssetLocations extends AssetState {
  final List<Location> locations;
  const AssetLocations({required this.locations});

  @override
  List<Object> get props => [locations];
}

final class AssetsLoaded extends AssetState {
  final List<Asset> assets;
  const AssetsLoaded({required this.assets});

  @override
  List<Object> get props => [assets];
}
