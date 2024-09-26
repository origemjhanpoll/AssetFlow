import 'package:asset_flow/injection.dart';
import 'package:asset_flow/presentation/bloc/asset_bloc.dart';
import 'package:asset_flow/presentation/pages/assets_page.dart';
import 'package:asset_flow/presentation/widgets/logo_widget.dart';
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
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const AssetFlowLogo(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help_outline_outlined),
            iconSize: 28.0,
            color: theme.hintColor,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Empresas disponíveis',
                style: theme.textTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Selecione uma empresa'),
            ),
            BlocBuilder<AssetBloc, AssetState>(
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
                  return Expanded(
                    child: ListView.builder(
                      itemCount: companies.length,
                      itemBuilder: (context, index) {
                        final company = companies[index];

                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const AssetsPage()));
                          },
                          title: Text(company.name,
                              style: theme.textTheme.titleMedium),
                          subtitle: Text('${company.assetCount} ativos'),
                          trailing: Container(
                              height: 40.0,
                              width: 40.0,
                              decoration:
                                  BoxDecoration(color: theme.primaryColor),
                              child: Icon(
                                Icons.arrow_right_alt_outlined,
                                color: theme.primaryColorLight,
                              )),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                        );
                      },
                    ),
                  );
                }
                return const LimitedBox();
              },
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Created by ',
                  style: theme.textTheme.labelSmall,
                  children: const [
                    TextSpan(
                        text: '@origemjhanpoll',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
