import 'package:asset_flow/domain/entities/branch.dart';
import 'package:asset_flow/utils/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BranchWidget extends StatefulWidget {
  const BranchWidget({
    super.key,
    required this.branch,
    required this.level,
    required this.isExpanded,
  });

  final Branch branch;
  final int level;
  final bool isExpanded;

  @override
  State<BranchWidget> createState() => _BranchWidgetState();
}

class _BranchWidgetState extends State<BranchWidget> {
  late bool isExpanded;
  late bool hasBranches;

  @override
  void initState() {
    isExpanded = widget.isExpanded;
    hasBranches = widget.branch.branches.isNotEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Padding(
            padding:
                EdgeInsets.only(left: 22.0 * widget.level + 8.0, right: 10.0),
            child: SizedBox(
              height: 48.0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(assetType(widget.branch.branchType)),
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                widget.branch.name,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                          if (widget.branch.getSensorType == SensorType.energy)
                            const Icon(
                              Icons.bolt,
                              size: 20.0,
                              color: Colors.green,
                            ),
                          if (widget.branch.getStatusType == StatusType.alert)
                            const Icon(
                              Icons.error,
                              size: 18.0,
                              color: Colors.red,
                            ),
                        ],
                      ),
                    ),
                    if (hasBranches)
                      DecoratedBox(
                          decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(22.0)),
                          child: Icon(
                            isExpanded
                                ? Icons.expand_more
                                : Icons.chevron_right,
                            color: theme.colorScheme.primary,
                          )),
                  ]),
            ),
          ),
        ),
        if (isExpanded && hasBranches)
          ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: widget.branch.branches.length,
              itemBuilder: (context, index) {
                final branch = widget.branch.branches[index];
                return BranchWidget(
                  key: Key(branch.id.toString()),
                  branch: branch,
                  isExpanded: branch.isExpanded,
                  level: widget.level + 1,
                );
              }),
      ],
    );
  }

  ThemeData get theme => Theme.of(context);
}

String assetType(BranchType type) {
  return switch (type) {
    BranchType.location => 'assets/location.svg',
    BranchType.asset => 'assets/asset.svg',
    BranchType.component => 'assets/component.svg',
    _ => 'assets/report.svg',
  };
}
