import 'package:asset_flow/injection.dart';
import 'package:asset_flow/presentation/bloc/tree_bloc.dart';
import 'package:asset_flow/presentation/widgets/back_button_widget.dart';
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
  bool showSeachBar = false;

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
          titleSpacing: 4.0,
          forceMaterialTransparency: true,
          title: showSeachBar
              ? Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: TextField(
                    autofocus: true,
                    onChanged: (value) {
                      bloc.add(FilteredEvent(
                        companyId: widget.companyId,
                        query: value,
                      ));
                    },
                    decoration: InputDecoration(
                      constraints: const BoxConstraints.expand(height: 48.0),
                      hintText: 'Buscar Ativo ou Local',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                )
              : Text('${widget.companyName} - Ativos'),
          automaticallyImplyLeading: !showSeachBar,
          leading: !showSeachBar
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: BackButtonWidget(),
                )
              : null,
          actions: [
            IconButton(
              color: theme.primaryColor,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    theme.colorScheme.secondaryContainer),
              ),
              onPressed: () {
                bloc.add(TreeLoadedEvent(companyId: widget.companyId));
                setState(() {
                  showSeachBar = !showSeachBar;
                });
              },
              icon: Icon(showSeachBar ? Icons.close : Icons.search),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      showCheckmark: false,
                      avatar: Icon(
                        energySensorSelected ? Icons.bolt : Icons.bolt_outlined,
                        size: 20.0,
                        color: energySensorSelected
                            ? Colors.green
                            : theme.hintColor,
                      ),
                      label: Text(
                        'Sensor de Energia',
                        style: energySensorSelected
                            ? TextStyle(color: theme.primaryColor)
                            : null,
                      ),
                      onSelected: (value) => setState(() {
                        energySensorSelected = value;
                      }),
                      selected: energySensorSelected,
                    ),
                  ),
                  FilterChip(
                    showCheckmark: false,
                    avatar: Icon(
                      criticSelected ? Icons.error : Icons.error_outline,
                      color: criticSelected ? Colors.red : theme.hintColor,
                    ),
                    label: Text(
                      'Crítico',
                      style: criticSelected
                          ? TextStyle(color: theme.primaryColor)
                          : null,
                    ),
                    onSelected: (value) => setState(() {
                      criticSelected = value;
                    }),
                    selected: criticSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              BlocBuilder<TreeBloc, TreeState>(
                bloc: bloc,
                buildWhen: (previous, current) =>
                    current is TreeLoading ||
                    current is TreeLoaded ||
                    current is TreeEmpty,
                builder: (context, state) {
                  if (state is TreeLoading) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is TreeEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text('Nenhum Ativo ou Local encontrado!'),
                      ),
                    );
                  } else if (state is TreeLoaded) {
                    final branches = state.branches;
                    return Expanded(
                      child: ListView.builder(
                          primary: true,
                          shrinkWrap: true,
                          itemCount: branches.length,
                          itemBuilder: (context, index) {
                            final branch = branches[index];
                            return BranchWidget(
                              key: Key(branch.id.toString()),
                              branch: branch,
                              isExpanded: branch.isExpanded,
                              level: branch.level,
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
