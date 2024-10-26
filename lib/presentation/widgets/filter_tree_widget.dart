// import 'package:asset_flow/presentation/bloc/tree_bloc.dart';
// import 'package:asset_flow/presentation/widgets/back_button_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class FilterTreeWidget extends StatelessWidget {
//   const FilterTreeWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return SearchAnchor(
//         viewLeading: const BackButtonWidget(),
//         viewBackgroundColor: theme.scaffoldBackgroundColor,
//         dividerColor: theme.colorScheme.secondaryContainer,
//         builder: (context, controller) {
//           return Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: DecoratedBox(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(26.0),
//                     color: theme.colorScheme.secondaryContainer),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Icon(
//                     Icons.search,
//                     color: theme.primaryColor,
//                   ),
//                 )),
//           );
//         },
//         viewBuilder: (suggestions) {
//           return BlocBuilder<TreeBloc, TreeState>(
//             buildWhen: (previous, current) =>
//                 current is TreeLoading ||
//                 current is TreeLoaded ||
//                 current is TreeEmpty,
//             builder: (context, state) {
//               if (state is TreeLoading) {
//                 return const Expanded(
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               } else if (state is TreeEmpty) {
//                 return const Expanded(
//                   child: Center(
//                     child: Text('Nenhum Ativo ou Local encontrado!'),
//                   ),
//                 );
//               } else if (state is TreeLoaded) {
//                 final branches = state.branches;
//                 return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: branches.length,
//                     itemBuilder: (context, index) {
//                       final branch = branches[index];
//                       return ListTile(title: Text(branch.name));
//                     });
//               }
//               return const LimitedBox();
//             },
//           );
//         },
//         viewHintText: 'Buscar Ativo ou Local',
//         suggestionsBuilder: (context, controller) {
//           return [];
//         });
//   }
// }
