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

  @override
  void initState() {
    bloc = di<AssetBloc>();
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

    return Scaffold(
        appBar: AppBar(
          title: const Text('Ativos'),
          foregroundColor: theme.colorScheme.onPrimary,
          backgroundColor: theme.primaryColor,
        ),
        body: Column(
          children: [
            const SearchBar(),
            const Row(
              children: [
                Chip(label: Text('Sensor de Energia')),
                Chip(label: Text('Crítico')),
              ],
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
        ));
  }
}
