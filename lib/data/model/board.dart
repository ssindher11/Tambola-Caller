import 'dart:math';

class Board {
  final List<int> _calledTiles = [];

  bool get isGameCompleted => _calledTiles.length == 90;

  bool isNumberCalled(int number) => _calledTiles.contains(number);

  void _markNumberCalled(int number) => _calledTiles.add(number);

  void restartGame() => _calledTiles.clear();

  // TODO: Delete this?
  int? getNextNumber() {
    if (isGameCompleted) return null;
    Random random = Random();
    int newNumber;
    do {
      newNumber = random.nextInt(90) + 1;
    } while (_calledTiles.contains(newNumber));
    _markNumberCalled(newNumber);
    return newNumber;
  }

  void callNextNumber() {
    if (isGameCompleted) return;
    Random random = Random();
    int newNumber;
    do {
      newNumber = random.nextInt(90) + 1;
    } while (_calledTiles.contains(newNumber));
    _markNumberCalled(newNumber);
  }

  int? get currentNumber {
    if (_calledTiles.isEmpty) return null;
    return _calledTiles.last;
  }

  int? get previousNumber {
    if (_calledTiles.length < 2) return null;
    return _calledTiles[_calledTiles.length - 2];
  }
}
