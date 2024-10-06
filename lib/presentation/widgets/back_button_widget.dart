import 'package:flutter/material.dart';

class BackButtonWidget extends BackButton {
  const BackButtonWidget({
    super.key,
    super.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BackButton(
      color: theme.primaryColor,
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundBuilder: (context, states, child) {
          return const Icon(Icons.keyboard_backspace_sharp);
        },
        backgroundColor:
            WidgetStateProperty.all(theme.colorScheme.secondaryContainer),
      ),
    );
  }
}
