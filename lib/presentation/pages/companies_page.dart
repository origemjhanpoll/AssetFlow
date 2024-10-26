import 'package:asset_flow/injection.dart';
import 'package:asset_flow/presentation/bloc/tree_bloc.dart';
import 'package:asset_flow/presentation/pages/assets_page.dart';
import 'package:asset_flow/presentation/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({super.key});

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  late TreeBloc bloc;

  @override
  void initState() {
    bloc = di<TreeBloc>();
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              title: Text(
                'Empresas disponíveis',
                style: theme.textTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Selecione uma empresa'),
            ),
            BlocBuilder<TreeBloc, TreeState>(
              bloc: bloc,
              buildWhen: (previous, current) =>
                  current is TreeLoading || current is CompaniesLoaded,
              builder: (context, state) {
                if (state is TreeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CompaniesLoaded) {
                  final companies = state.companies;
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      shrinkWrap: false,
                      itemCount: companies.length,
                      itemBuilder: (context, index) {
                        final company = companies[index];

                        return ListTile(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Navigator.of(context).push(MaterialPageRoute<void>(
                                builder: (BuildContext context) => AssetsPage(
                                      companyId: company.id,
                                      companyName: company.name,
                                    )));
                          },
                          leading: Icon(
                            Icons.business,
                            color: theme.colorScheme.primary,
                          ),
                          title: Text(company.name,
                              style: theme.textTheme.titleMedium),
                          trailing: Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Icon(
                                Icons.arrow_right_alt_outlined,
                                color: theme.primaryColor,
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
