import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tambola_caller/data/model/board.dart';
import 'package:tambola_caller/data/number_phrases.dart';
import 'package:tambola_caller/ui/views/animated_background.dart';
import 'package:tambola_caller/ui/views/board_view.dart';
import 'package:tambola_caller/ui/views/number_caller_view.dart';
import 'package:tambola_caller/utils/tts_manager.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Board _board = Board();
  final _ttsManager = TtsManager();

  @override
  void dispose() {
    _ttsManager.stop();
    super.dispose();
  }

  Widget _buildBackIcon() {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const RotatedBox(
        quarterTurns: 2,
        child: Icon(
          Icons.arrow_right_alt,
          size: 48,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  kIsWeb || !Platform.isAndroid
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: _buildBackIcon(),
                        )
                      : const SizedBox.shrink(),
                  Expanded(
                    child: BoardView(_board),
                  ),
                  Expanded(
                    child: NumberCallerView(
                      currentNumber: _board.currentNumber,
                      previousNumber: _board.previousNumber,
                      isGameCompleted: _board.isGameCompleted,
                      onNextClick: () async {
                        _board.callNextNumber();
                        await _ttsManager.stop();
                        _ttsManager.speak(
                            '${numPhrases[_board.currentNumber]!}.  Number ${_board.currentNumber}');
                        setState(() {});
                      },
                      onRestartClick: () {
                        _board.restartGame();
                        _ttsManager.stop();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
