import 'dart:math';

class Game {
  static dynamic _maxRandom;
  static final List<int> _round = [];
  int? _answer;
  int countNum = 0;

  Game({int maxRandom = 100}) {
    var r = Random();
    _setMaxRandom = maxRandom;
    _answer = r.nextInt(maxRandom) + 1;
  }
  int doGuess(int num) {
    doCount();
    if (num > _answer!) {
      return 1;
    } else if (num < _answer!) {
      return -1;
    } else {
      return 0;
    }
  }
  getmaxRandom() {
    return _maxRandom;
  }
  doCount() {
    countNum++;
  }
  int getdoCount() {
    doround(countNum);
    return countNum;
  }
  set _setMaxRandom(int info) {
    _maxRandom = info;
  }
  doround(int info){
    _round.add(info);
  }
  List<int> get getdoround{
    return _round;
  }
}