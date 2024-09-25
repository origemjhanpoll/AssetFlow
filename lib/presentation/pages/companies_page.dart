import 'package:asset_flow/injection.dart';
import 'package:asset_flow/presentation/bloc/asset_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({super.key});

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  late AssetBloc bloc;

  @override
  void initState() {
    bloc = di<AssetBloc>();
    bloc.add(GetCompaniesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AssetBloc, AssetState>(
        bloc: bloc,
        buildWhen: (previous, current) =>
            current is Loading || current is AssetCompanies,
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AssetCompanies) {
            final companies = state.companies;
            return ListView.builder(
              itemCount: companies.length,
              itemBuilder: (context, index) {
                final company = companies[index];
                return ListTile(
                    title: Text(company.name), subtitle: Text(company.id));
              },
            );
          }
          return const LimitedBox();
        },
      ),
    );
  }
}
