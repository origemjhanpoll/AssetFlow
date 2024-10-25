part of 'tree_bloc.dart';

sealed class TreeState extends Equatable {
  const TreeState();

  @override
  List<Object> get props => [];
}

final class TreeInitial extends TreeState {}

final class TreeLoading extends TreeState {}

final class TreeEmpty extends TreeState {}

final class CompaniesLoaded extends TreeState {
  final List<Company> companies;
  const CompaniesLoaded({required this.companies});

  @override
  List<Object> get props => [companies];
}

final class TreeLoaded extends TreeState {
  final List<Branch> branches;
  const TreeLoaded({required this.branches});

  @override
  List<Object> get props => [branches];
}

final class FilterLoaded extends TreeEvent {
  final String query;
  const FilterLoaded({required this.query});

  @override
  List<Object> get props => [query];
}
