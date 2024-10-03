import 'package:asset_flow/domain/entities/branch.dart';
import 'package:asset_flow/utils/item_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BranchWidget extends StatefulWidget {
  const BranchWidget({
    super.key,
    required this.text,
    this.branches,
    this.type = ItemType.component,
  });

  final String text;
  final ItemType type;
  final List<Branch>? branches;

  @override
  State<BranchWidget> createState() => _BranchWidgetState();
}

class _BranchWidgetState extends State<BranchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(assetType(widget.type)),
              Text(
                widget.text,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyLarge,
              ),
              Icon(
                Icons.circle,
                size: 8.0,
                color: theme.colorScheme.error,
              )
            ],
          ),
          if (widget.branches != null)
            ...widget.branches!.map((element) => BranchWidget(
                  text: element.name,
                  type: element.type,
                  branches: element.branches,
                ))
        ],
      ),
    );
  }

  ThemeData get theme => Theme.of(context);
}

String assetType(ItemType type) {
  return switch (type) {
    ItemType.location => 'assets/location.svg',
    ItemType.asset => 'assets/asset.svg',
    ItemType.component => 'assets/component.svg',
  };
}
