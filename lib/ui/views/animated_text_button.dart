import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedTextButton extends StatelessWidget {
  AnimatedTextButton({
    Key? key,
    required this.text,
    required this.onClick,
    this.isEnabled = true,
    this.margin,
  }) : super(key: key);

  final String text;
  final VoidCallback onClick;
  final bool isEnabled;
  final _isPressed = false.obs;
  final EdgeInsets? margin;

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
            borderRadius: BorderRadius.circular(22),
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
          padding: const EdgeInsets.symmetric(vertical: 16),
          margin: margin,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.redHatDisplay(
              color: _isPressed.value
                  ? theme.colorScheme.onBackground.withOpacity(0.7)
                  : theme.colorScheme.onBackground,
              fontSize: 33,
              fontWeight: FontWeight.bold,
              height: 40 / 32,
            ),
          ),
        ),
      ),
    );
  }
}
