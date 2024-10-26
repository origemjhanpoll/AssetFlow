import 'package:asset_flow/domain/entities/branch.dart';
import 'package:asset_flow/domain/entities/company.dart';
import 'package:asset_flow/domain/usecases/filter_branchs.dart';
import 'package:asset_flow/domain/usecases/get_companies.dart';
import 'package:asset_flow/domain/usecases/get_tree.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'tree_event.dart';
part 'tree_state.dart';

class TreeBloc extends Bloc<TreeEvent, TreeState> {
  final GetCompanies getCompanies;
  final GetTree getTree;
  final FilterBranchs filterBranchs;

  List<Branch> tree = [];
  List<Branch> branches = [];

  TreeBloc({
    required this.getCompanies,
    required this.getTree,
    required this.filterBranchs,
  }) : super(TreeInitial()) {
    on<GetCompaniesEvent>(_getCompaniesEvent);
    on<TreeLoadedEvent>(_treeLoadedEvent);
    on<TreeLoadMoreEvent>(_treeLoadMoreEvent);
    on<FilteredEvent>(_filteredEvent);
  }

  void _getCompaniesEvent(
      GetCompaniesEvent event, Emitter<TreeState> emit) async {
    emit(TreeLoading());
    try {
      final companies = await getCompanies();
      emit(CompaniesLoaded(companies: companies));
    } catch (e, s) {
      debugPrint('Erro: $e');
      debugPrint('Stack trace: $s');
    }
  }

  void _treeLoadedEvent(TreeLoadedEvent event, Emitter<TreeState> emit) async {
    emit(TreeLoading());
    try {
      tree = await getTree(companyId: event.companyId);
      if (tree.isNotEmpty) {
        emit(TreeLoaded(branches: tree));
      } else {
        emit(TreeEmpty());
      }
    } catch (e, s) {
      debugPrint('Erro: $e');
      debugPrint('Stack trace: $s');
    }
  }

  void _filteredEvent(FilteredEvent event, Emitter<TreeState> emit) async {
    try {
      if (event.query.length > 2) {
        final resultFilter =
            await filterBranchs(query: event.query, tree: tree);

        if (resultFilter.isEmpty) {
          emit(TreeEmpty());
        } else {
          emit(TreeLoaded(branches: resultFilter));
        }
      } else {
        emit(TreeEmpty());
      }
    } catch (e, s) {
      debugPrint('Erro: $e');
      debugPrint('Stack trace: $s');
    }
  }

  void _treeLoadMoreEvent(
      TreeLoadMoreEvent event, Emitter<TreeState> emit) async {
    emit(TreeLoading());
    try {
      const int incrementSize = 30;
      int startIndex = incrementSize * event.page;
      int endIndex = startIndex + incrementSize;
      endIndex = endIndex > tree.length ? tree.length : endIndex;
      branches = tree.sublist(0, endIndex);
      // final updateBranches =
      //     await updateTree(branches: branches, tree: tree, page: event.page);

      emit(TreeLoaded(branches: branches));
    } catch (e, s) {
      debugPrint('Erro: $e');
      debugPrint('Stack trace: $s');
    }
  }
}
