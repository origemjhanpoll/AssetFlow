import 'package:flutter/material.dart';

class AssetFlowLogo extends FlutterLogo {
  const AssetFlowLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ASSETFLOW',
          style: theme.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.w900, color: theme.primaryColor),
        ),
        Row(
          children: [
            Text(
              'Challenge TRACTIAN',
              style:
                  theme.textTheme.labelSmall!.copyWith(color: theme.hintColor),
            ),
          ],
        ),
      ],
    );
  }
}
