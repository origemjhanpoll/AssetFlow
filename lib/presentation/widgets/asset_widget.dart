import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AssetType { asset, component, location }

class AssetWidget extends StatefulWidget {
  const AssetWidget(
      {super.key, required this.text, this.type = AssetType.component});

  final String text;
  final AssetType type;

  @override
  State<AssetWidget> createState() => _AssetWidgetState();
}

class _AssetWidgetState extends State<AssetWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SvgPicture.asset(assetType(widget.type)),
          ),
          Text(
            widget.text,
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  ThemeData get theme => Theme.of(context);
}

String assetType(AssetType type) {
  return switch (type) {
    AssetType.location => 'assets/location.svg',
    AssetType.asset => 'assets/asset.svg',
    _ => 'assets/component.svg',
  };
}
