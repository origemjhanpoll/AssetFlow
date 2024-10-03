import 'package:asset_flow/domain/entities/branch.dart';
import 'package:asset_flow/utils/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BranchWidget extends StatelessWidget {
  const BranchWidget({super.key, required this.branch, required this.branches});

  final Branch branch;
  final List<Branch> branches;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (!context.mounted) {
      print('mounted 1');
      return const Center(child: CircularProgressIndicator());
    } else {
      print('mounted 2');

      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(assetType(branch.branchType)),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      branch.name,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ),
                if (branch.getSensorType == SensorType.energy)
                  const Icon(
                    Icons.bolt,
                    size: 20.0,
                    color: Colors.green,
                  ),
                if (branch.getStatusType == StatusType.alert)
                  const Icon(
                    Icons.circle,
                    size: 12.0,
                    color: Colors.red,
                  )
              ],
            ),
            if (branch.branches.isNotEmpty)
              ...branch.branches.map((element) {
                return BranchWidget(
                  branch: element,
                  branches: element.branches,
                );
              })
          ],
        ),
      );
    }
  }
}

String assetType(BranchType type) {
  return switch (type) {
    BranchType.location => 'assets/location.svg',
    BranchType.asset => 'assets/asset.svg',
    BranchType.component => 'assets/component.svg',
    _ => 'assets/report.svg',
  };
}
