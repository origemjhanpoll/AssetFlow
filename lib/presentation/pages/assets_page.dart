import 'package:asset_flow/injection.dart';
import 'package:asset_flow/presentation/bloc/tree_bloc.dart';
import 'package:asset_flow/presentation/widgets/branch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetsPage extends StatefulWidget {
  final String companyId;
  final String companyName;
  const AssetsPage(
      {super.key, required this.companyId, required this.companyName});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  late TreeBloc bloc;
  bool energySensorSelected = false;
  bool criticSelected = false;

  @override
  void initState() {
    bloc = di<TreeBloc>();
    bloc.add(TreeLoadedEvent(companyId: widget.companyId));
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
          title: Text('${widget.companyName} - Ativos'),
          foregroundColor: theme.colorScheme.onPrimary,
          backgroundColor: theme.primaryColor,
          actions: [
            SearchAnchor(
              suggestionsBuilder: (context, controller) {
                return [const Text('data')];
              },
              builder: (BuildContext context, SearchController controller) {
                return const SizedBox(
                  width: 60,
                  child: Center(
                    child: Icon(
                      Icons.search,
                      size: 28.0,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: const Text('Sensor de Energia'),
                        onSelected: (value) => setState(() {
                          energySensorSelected = value;
                        }),
                        selected: energySensorSelected,
                      ),
                    ),
                    FilterChip(
                      label: const Text('Crítico'),
                      onSelected: (value) => setState(() {
                        criticSelected = value;
                      }),
                      selected: criticSelected,
                    ),
                  ],
                ),
              ),
              BlocBuilder<TreeBloc, TreeState>(
                bloc: bloc,
                buildWhen: (previous, current) =>
                    current is Loading || current is TreeLoaded,
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TreeLoaded) {
                    final branches = state.branches;
                    return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: branches.length,
                          itemBuilder: (context, index) {
                            final branch = branches[index];
                            return BranchWidget(
                              branch: branch,
                              branches: branch.branches,
                            );
                          }),
                    );
                  }
                  return const LimitedBox();
                },
              ),
            ],
          ),
        ));
  }
}
