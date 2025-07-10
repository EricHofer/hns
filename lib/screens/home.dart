import 'package:flutter/material.dart';
import 'package:hns/models/hist.dart';
import 'package:hns/models/kard.dart';
import 'package:hns/screens/widget_kard.dart';
import 'package:hns/screens/utils.dart';
import 'package:hns/shared/tools_widgets.dart';
import 'package:hns/models/savedata.dart';
import 'package:hns/models/game.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<int> lsSrce = [];
  List<int> lsDraw = [];
  List<int> lsHand = [];
  //  List<Kard> lsKardOnSrce = [];
  //  List<Kard> lsKardInHand = [];
  List<Hist> lsHist = [];

  void _reset(BuildContext context) {
    if (lsSrce.isEmpty) {
      // need sentinel, if resetExists
      //      showOkCancelDialog(context, "Reset", "This will restart the game, are you sure?").then((DialogResult res) {
      show3AnswerDialog(
        context,
        "Reset/Restore",
        """This will restart the game:
'Reset' - restarts with 100 cards
'Restore' - restores the previous closed game
'Cancel' - returns to the game""",
        "Reset",
        "Restore",
        "Cancel", //Dialog OK, No and Cancel
      ).then((DialogResult res) {
        if (res == DialogResult.ok) {
          _resetHelper();
        } else if (res == DialogResult.no) {
          debugPrint("in Restore");
          _restoreHelper();
        }
      });
    } else {
      _resetHelper();
    }
  }

  void _resetHelper() {
    debugPrint("Resetting");
    setState(() {
      lsSrce.clear();
      lsDraw.clear();
      lsHand.clear();
      lsHist.clear();
      lsSrce = List.generate(lsKard.length, (index) => index); // generate a list of 1 to 100 which will then be shuffled
      lsSrce.shuffle();
    });
  }

  Future<void> _restoreHelper() async {
    // Not implemented
    debugPrint("Pressed Restore");
    try {
      GameState gs = await loadData();
      setState(() {
        lsSrce = gs.lsSrce;
        lsDraw = gs.lsDraw;
        lsHand = gs.lsHand;
        lsHist = gs.lsHist;
      });
    } catch (e) {
      debugPrint("Failed");
    }
  }

  void undoHist(BuildContext context) {
    debugPrint("Printing the history\n");
    for (final h in lsHist) {
      debugPrint(" ${h.idKard} '${getNmKard(h.idKard)}' ${h.tyHistAct}");
    }

    // use the last one and figure out where it came from
    final Hist vH = lsHist.last;
    setState(() {
      switch (vH.tyHistAct) {
        case TyHistAct.deletedFromDraw:
          lsSrce.add(vH.idKard);
          break;
        case TyHistAct.deletedFromHand:
          lsHand.add(vH.idKard);
          break;
        case TyHistAct.drawn:
          final int indexOfWanted = lsSrce.indexWhere((k) => k == vH.idKard);
          lsDraw.insert(0, vH.idKard);
          lsSrce.removeAt(indexOfWanted);
          break;
        case TyHistAct.moved:
          final int indexOfWanted = lsHand.indexWhere((k) => k == vH.idKard);
          lsSrce.add(lsHand[indexOfWanted]);
          lsHand.removeAt(indexOfWanted);
      }
      lsHist.removeLast();
    });
  }

  void _draw(BuildContext context) {
    if (lsDraw.length > 2) {
      msgBox(context, "No space in 'On Deck'.");
    } else if (lsSrce.isEmpty) {
      msgBox(context, "No more cards in Source.");
    } else {
      setState(() {
        lsDraw.add(lsSrce[0]);
        lsHist.add(Hist(lsSrce[0], TyHistAct.drawn));
        lsSrce.removeAt(0);
      });
      //20250704 EH
      saveData(lsSrce, lsDraw, lsHand, lsHist);
    }
  }

  void removeDraw(int index) {
    //print("removeKardOnSrce $index");
    setState(() {
      lsHist.add(Hist(lsDraw[index], TyHistAct.deletedFromDraw));
      lsDraw.removeAt(index);
    });
    saveData(lsSrce, lsDraw, lsHand, lsHist);
  }

  void removeHand(int index) {
    debugPrint("removeHand $index");
    setState(() {
      lsHist.add(Hist(lsHand[index], TyHistAct.deletedFromHand));
      lsHand.removeAt(index);
    });
    saveData(lsSrce, lsDraw, lsHand, lsHist);
  }

  void moveToHand(int index) {
    setState(() {
      debugPrint("removeKardTohand $index");
      lsHand.add(lsDraw[index]);
      lsHist.add(Hist(lsDraw[index], TyHistAct.moved));
      lsDraw.removeAt(index);
    });
    saveData(lsSrce, lsDraw, lsHand, lsHist);
  }

  // Main Display //////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hide N Seek (hns)'),
        centerTitle: true,
        backgroundColor: Colors.blue, //, centerTItle: true
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                myTopButton(
                  label: "Reset",
                  onPressed: () {
                    _reset(context);
                  },
                ),
                SizedBox(width: 3),
                myTopButton(
                  label: "Draw ${lsSrce.length}",
                  onPressed: () {
                    _draw(context);
                  },
                ),
                SizedBox(width: 3),
                myTopButton(
                  label: "Shuf",
                  onPressed: () {
                    lsDraw.shuffle();
                  },
                ),
                SizedBox(width: 3),

                myTopButton(
                  label: "Undo",
                  onPressed: () {
                    undoHist(context);
                  },
                ),
              ],
            ),
            mySectionText("Drawn"),
            Expanded(
              child: ListView.builder(
                itemCount: lsDraw.length,
                itemBuilder: (_, index) {
                  return WidgetKard(
                    idKard: lsDraw[index],
                    //                    kard: lsKardOnSrce[index],
                    tySituation: TySituation.drawn,
                    fnMove: () {
                      //                      moveKardToHand(index);
                      moveToHand(index);
                    },
                    fnPlay: () {},
                    fnRemove: () {
                      //                      removeKardOnSrce(index);
                      removeDraw(index);
                    },
                  );
                },
              ),
            ),
            mySectionText("In Hand"),
            Expanded(
              child: ListView.builder(
                //                itemCount: lsKardInHand.length,
                itemCount: lsHand.length,
                itemBuilder: (_, index) {
                  return WidgetKard(
                    idKard: lsHand[index],
                    //                    kard: lsKardInHand[index],
                    tySituation: TySituation.inhand,
                    fnMove: () {
                      //                      removeKardInHand(index);
                      removeHand(index);
                    },
                    fnPlay: () {},
                    fnRemove: () {
                      removeHand(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
