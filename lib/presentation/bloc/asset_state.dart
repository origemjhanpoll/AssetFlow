part of 'asset_bloc.dart';

sealed class AssetState extends Equatable {
  const AssetState();

  @override
  List<Object> get props => [];
}

class AssetInitial extends AssetState {}

class Companies extends AssetState {
  final List<Company> companies;
  const Companies({required this.companies});

  @override
  List<Object> get props => [companies];
}
