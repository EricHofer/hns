import 'package:hns/models/hist.dart';

class GameState {
  final List<int> lsSrce;
  final List<int> lsDraw;
  final List<int> lsHand;
  final List<Hist> lsHist; // or List<Tuple<int, int>>

  GameState({required this.lsSrce, required this.lsDraw, required this.lsHand, required this.lsHist});
}
