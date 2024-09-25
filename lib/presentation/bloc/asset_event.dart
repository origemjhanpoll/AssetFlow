part of 'asset_bloc.dart';

sealed class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object> get props => [];
}

class GetCompaniesEvent extends AssetEvent {}
