import 'package:asset_flow/injection.dart';
import 'package:asset_flow/presentation/bloc/asset_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  late AssetBloc bloc;
  late FocusNode focusNode;
  var hiddenAppBar = false;

  @override
  void initState() {
    bloc = di<AssetBloc>();
    focusNode = FocusNode()
      ..addListener(() {
        if (focusNode.hasFocus) {
          setState(() {
            hiddenAppBar = true;
          });
        } else {
          setState(() {
            hiddenAppBar = false;
          });
        }
      });
    bloc.add(GetAssetsEvent());
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

    return GestureDetector(
      onTap: focusNode.unfocus,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: hiddenAppBar ? 50 : 160,
              child: AppBar(
                title: const Text('Ativos'),
                forceMaterialTransparency: hiddenAppBar ? true : false,
                foregroundColor: theme.colorScheme.onPrimary,
                backgroundColor: hiddenAppBar ? null : theme.primaryColor,
              ),
            ),
          ),
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16, 8.0),
                  child: SearchBar(
                    focusNode: focusNode,
                    leading: const Icon(Icons.search),
                    hintText: 'Buscar Ativo ou Local',
                    textInputAction: TextInputAction.search,
                    elevation: const WidgetStatePropertyAll(0.0),
                    shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)))),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Chip(label: Text('Sensor de Energia')),
                      ),
                      Chip(label: Text('Crítico')),
                    ],
                  ),
                ),
                BlocBuilder<AssetBloc, AssetState>(
                  bloc: bloc,
                  buildWhen: (previous, current) =>
                      current is Loading || current is AssetLoaded,
                  builder: (context, state) {
                    if (state is Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AssetLoaded) {
                      final assets = state.assets;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: assets.length,
                          itemBuilder: (context, index) {
                            final asset = assets[index];

                            return ListTile(
                              title: Text(asset.name,
                                  style: theme.textTheme.titleMedium),
                            );
                          },
                        ),
                      );
                    }
                    return const LimitedBox();
                  },
                ),
              ],
            ),
          )),
    );
  }
}
