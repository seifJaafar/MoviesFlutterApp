import 'package:flutter/material.dart';

class MovieSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  const MovieSearchBar({
    super.key,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Search movies...",
        prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
        suffixIcon: onClear != null
            ? IconButton(
          icon: const Icon(Icons.close),
          onPressed: onClear,
        )
            : null,
      ),
    );
  }
}
