part of 'asset_bloc.dart';

sealed class AssetState extends Equatable {
  const AssetState();

  @override
  List<Object> get props => [];
}

final class AssetInitial extends AssetState {}

final class Loading extends AssetState {}

final class CompaniesLoaded extends AssetState {
  final List<Company> companies;
  const CompaniesLoaded({required this.companies});

  @override
  List<Object> get props => [companies];
}

final class AssetsLoaded extends AssetState {
  final List<Location> locations;
  const AssetsLoaded({required this.locations});

  @override
  List<Object> get props => [locations];
}
