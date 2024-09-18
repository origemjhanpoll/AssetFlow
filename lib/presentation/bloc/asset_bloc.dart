import 'package:asset_flow/domain/usecases/get_companies.dart';
import 'package:asset_flow/injection.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final GetCompanies getCompanies = di<GetCompanies>();

  AssetBloc() : super(AssetInitial()) {
    on<AssetEvent>((event, emit) {});
  }
}
