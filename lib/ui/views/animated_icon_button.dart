import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class AnimatedIconButton extends StatelessWidget {
  AnimatedIconButton({
    Key? key,
    required this.icon,
    required this.onClick,
    this.isEnabled = true,
    this.margin,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius,
  }) : super(key: key);

  final Icon icon;
  final VoidCallback onClick;
  final bool isEnabled;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BorderRadiusGeometry? borderRadius;

  final _isPressed = false.obs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () => GestureDetector(
        onTap: onClick,
        onTapDown: (_) => _isPressed.value = true,
        onTapUp: (_) => _isPressed.value = false,
        onTapCancel: () => _isPressed.value = false,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            border: Border.all(
              color: theme.colorScheme.background,
            ),
            borderRadius: borderRadius ?? BorderRadius.circular(22),
            boxShadow: _isPressed.value
                ? [
                    BoxShadow(
                      color: theme.colorScheme.onBackground,
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: theme.colorScheme.onBackground,
                      offset: const Offset(3, 3),
                      blurRadius: 2,
                    ),
                  ],
          ),
          padding: padding,
          margin: margin,
          child: icon,
        ),
      ),
    );
  }
}
