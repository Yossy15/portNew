import 'package:flutter/material.dart';

class IconBeb extends StatelessWidget {
  final VoidCallback onPressed;
  final String textlabel;
  const IconBeb({super.key, required this.onPressed, required this.textlabel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton.icon(
      onPressed: onPressed,
      label: Text(textlabel,
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
      icon: Icon(
        Icons.folder,
        size: 50,
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
    // IconButton(
    //   onPressed: onPressed,
    //   icon: Icon(Icons.folder),
    //   iconSize: 100,
    //   color: theme.colorScheme.primary,
    //   style: IconButton.styleFrom(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //   ),
    //   hoverColor: theme.colorScheme.primary.withValues(alpha: 0.1),
    //   focusColor: theme.colorScheme.primary.withValues(alpha: 0.1),
    //   highlightColor: theme.colorScheme.primary.withValues(alpha: 0.1),
    //   splashColor: theme.colorScheme.primary.withValues(alpha: 0.1),
    // );
  }
}
