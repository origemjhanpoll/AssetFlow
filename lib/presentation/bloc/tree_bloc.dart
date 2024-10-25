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
      branches = await getTree(companyId: event.companyId);
      if (branches.isNotEmpty) {
        add(const TreeLoadMoreEvent(page: 1));
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
      int skip = branches.length < 30 ? branches.length : 30 * event.page;
      final branchesCurrent = branches.sublist(0, skip);
      emit(TreeLoaded(branches: branchesCurrent));
    } catch (e, s) {
      debugPrint('Erro: $e');
      debugPrint('Stack trace: $s');
    }
  }

  void _filteredEvent(FilteredEvent event, Emitter<TreeState> emit) async {
    // try {
    //   if (event.query.length >= 2) {
    //     emit(TreeLoading());
    //     branchs = await filterBranchs(
    //       query: event.query,
    //       companyId: event.companyId,
    //     );

    //     if (branchs.isEmpty) {
    //       print('2');

    //       emit(TreeEmpty());
    //     } else {
    //       print('3');

    //       emit(TreeLoaded(branches: branchs));
    //     }
    //   } else {
    //     print('4');

    //     emit(TreeEmpty());
    //   }
    // } catch (e, s) {
    //   debugPrint('Erro: $e');
    //   debugPrint('Stack trace: $s');
    // }
  }
}
