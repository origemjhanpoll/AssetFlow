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

final class TreeLoadMoreEvent extends TreeEvent {
  final int page;

  const TreeLoadMoreEvent({required this.page});

  @override
  List<Object> get props => [page];
}

final class FilteredEvent extends TreeEvent {
  final String query;

  const FilteredEvent({
    required this.query,
  });

  @override
  List<Object> get props => [query];
}
