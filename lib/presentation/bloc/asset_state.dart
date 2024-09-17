part of 'asset_bloc.dart';

sealed class AssetState extends Equatable {
  const AssetState();
  
  @override
  List<Object> get props => [];
}

final class AssetInitial extends AssetState {}
