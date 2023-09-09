import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tambola_caller/res/res.dart';

class AudioWaveform extends StatefulWidget {
  const AudioWaveform({super.key, required this.isPlaying});

  final bool isPlaying;

  @override
  State<AudioWaveform> createState() => _AudioWaveformState();
}

class _AudioWaveformState extends State<AudioWaveform>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  final count = 11;
  final _durationInMillis = 300;
  final minHeight = 10.0;
  final maxHeights = <double>[30, 45, 36, 30, 39, 27, 36, 27, 45, 36, 30];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationInMillis),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AudioWaveform oldWidget) {
    super.didUpdateWidget(oldWidget);
    _toggleAnimation();
  }

  void _toggleAnimation() {
    if (widget.isPlaying) {
      _animationController.repeat(reverse: true);
    } else {
      _animationController.stop();
      _animationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, child) {
        final t = _animationController.value;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            count,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              margin: i == count - 1
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(right: 5),
              height: (t <= 0.25 || t == 1)
                  ? minHeight
                  : random.nextBool()
                      ? lerpDouble(minHeight, maxHeights[i], t)
                      : lerpDouble(maxHeights[i], minHeight, t),
              width: 5,
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode
                        ? Colors.white
                        : Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        );
      },
    );
  }
}
