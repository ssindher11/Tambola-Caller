import 'package:flutter/material.dart';
import 'package:tambola_caller/data/model/board.dart';
import 'package:tambola_caller/ui/views/animated_background.dart';
import 'package:tambola_caller/ui/views/board_view.dart';
import 'package:tambola_caller/ui/views/number_caller_view.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Board _board = Board();

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
                  Expanded(
                    child: BoardView(_board),
                  ),
                  Expanded(
                    child: NumberCallerView(
                      currentNumber: _board.currentNumber,
                      previousNumber: _board.previousNumber,
                      isGameCompleted: _board.isGameCompleted,
                      onNextClick: () {
                        _board.callNextNumber();
                        setState(() {});
                      },
                      onRestartClick: () {
                        _board.restartGame();
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
