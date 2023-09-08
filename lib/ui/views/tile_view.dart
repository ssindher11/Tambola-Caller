import 'package:flutter/material.dart';

class TileView extends StatelessWidget {
  const TileView({
    Key? key,
    required this.number,
    required this.isSelected,
  }) : super(key: key);

  final int number;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blueAccent : theme.colorScheme.background,
        border: Border.all(color: theme.dividerColor),
      ),
      child: Text(
        number.toString(),
        style: theme.textTheme.bodyLarge?.copyWith(
          color: isSelected ? Colors.white : theme.colorScheme.onBackground,
        ),
      ),
    );
  }
}
