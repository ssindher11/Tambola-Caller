import 'package:flutter/material.dart';
import 'package:tambola_caller/data/model/board.dart';
import 'package:tambola_caller/ui/views/tile_view.dart';

class BoardView extends StatelessWidget {
  const BoardView(this.board, {Key? key}) : super(key: key);

  final Board board;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      child: AspectRatio(
        aspectRatio: 1,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
          ),
          itemBuilder: (_, index) => TileView(
            number: index + 1,
            isSelected: board.isNumberCalled(index + 1),
          ),
          itemCount: 90,
        ),
      ),
    );
  }
}
