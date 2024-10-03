part of 'tree_bloc.dart';

sealed class TreeState extends Equatable {
  const TreeState();

  @override
  List<Object> get props => [];
}

final class TreeInitial extends TreeState {}

final class Loading extends TreeState {}

final class CompaniesLoaded extends TreeState {
  final List<Company> companies;
  const CompaniesLoaded({required this.companies});

  @override
  List<Object> get props => [companies];
}

final class TreeLoaded extends TreeState {
  final List<Branch> branchs;
  const TreeLoaded({required this.branchs});

  @override
  List<Object> get props => [branchs];
}
