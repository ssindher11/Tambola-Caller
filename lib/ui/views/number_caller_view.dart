import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tambola_caller/data/number_phrases.dart';
import 'package:tambola_caller/res/res.dart';

import 'animated_icon_button.dart';

class NumberCallerView extends StatefulWidget {
  const NumberCallerView({
    Key? key,
    required this.previousNumber,
    required this.currentNumber,
    required this.isGameCompleted,
    required this.onNextClick,
    required this.onRestartClick,
  }) : super(key: key);

  final int? previousNumber;
  final int? currentNumber;
  final bool isGameCompleted;
  final VoidCallback onNextClick;
  final VoidCallback onRestartClick;

  @override
  State<NumberCallerView> createState() => _NumberCallerViewState();
}

class _NumberCallerViewState extends State<NumberCallerView> {
  final _pagerController = PageController();
  final _animDuration = const Duration(milliseconds: 300);

  @override
  void dispose() {
    _pagerController.dispose();
    super.dispose();
  }

  Widget _buildPhrasePager(ThemeData theme) {
    return PageView.builder(
      controller: _pagerController,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) => _buildPhrase(theme),
    );
  }

  Widget _buildPhrase(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          numPhrases[widget.currentNumber] ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: theme.textTheme.displaySmall?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: widget.currentNumber != null
                ? AnimatedContainer(
                    duration: _animDuration,
                    curve: Curves.easeInOut,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.center,
                      clipBehavior: Clip.antiAlias,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                        child: _buildPhrasePager(theme),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: widget.previousNumber != null
                            ? AnimatedSwitcher(
                                duration: _animDuration,
                                transitionBuilder: (child, animation) {
                                  return ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                child: Text(
                                  key: ValueKey(widget.previousNumber),
                                  widget.previousNumber.toString(),
                                  style: theme.textTheme.displaySmall?.copyWith(
                                    color: theme.colorScheme.onBackground,
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: widget.currentNumber != null
                            ? AnimatedSwitcher(
                                duration: _animDuration,
                                transitionBuilder: (child, animation) {
                                  return ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                child: Text(
                                  key: ValueKey(widget.currentNumber),
                                  widget.currentNumber.toString(),
                                  style: theme.textTheme.displayLarge?.copyWith(
                                    color: theme.colorScheme.onBackground,
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: FloatingActionButton(
                        onPressed: !widget.isGameCompleted
                            ? () {
                                if (widget.isGameCompleted) return;
                                widget.onNextClick();
                                _pagerController.nextPage(
                                  duration: _animDuration,
                                  curve: Curves.easeInOut,
                                );
                              }
                            : null,
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        heroTag: null,
                        tooltip: 'Next Number',
                        child: const Icon(Icons.double_arrow),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedIconButton(
                  icon: const Icon(Icons.replay),
                  onClick: () => widget.onRestartClick(),
                  margin: const EdgeInsets.all(24),
                  isEnabled: widget.currentNumber != null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
