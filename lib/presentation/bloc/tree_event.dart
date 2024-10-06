part of 'tree_bloc.dart';

sealed class TreeEvent extends Equatable {
  const TreeEvent();

  @override
  List<Object> get props => [];
}

final class GetCompaniesEvent extends TreeEvent {}

final class TreeLoadedEvent extends TreeEvent {
  final String companyId;
  const TreeLoadedEvent({required this.companyId});

  @override
  List<Object> get props => [companyId];
}

final class FilterLoadedEvent extends TreeEvent {
  final String companyId;
  const FilterLoadedEvent({required this.companyId});

  @override
  List<Object> get props => [companyId];
}
