import 'package:flutter/material.dart';
import 'package:hns/models/hist.dart';
import 'package:hns/models/kard.dart';
import 'package:hns/screens/widget_kard.dart';
import 'package:hns/shared/sharedprefshelper.dart';
import 'package:hns/shared/utils.dart';
import 'package:hns/shared/tools_widgets.dart';
import 'package:hns/models/savedata.dart';
import 'package:hns/models/game.dart';

Function debugPrint = (String? msg, {int? wrapWidth}) {};

final double kCardSeparation = 2;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<int> lsSrce = [];
  List<int> lsDraw = [];
  List<int> lsHand = [];
  List<Hist> lsHist = [];

  void _reset(BuildContext context) {
    String txError = "";

    if (lsSrce.isEmpty && SharedPrefsHelper.prefs.containsKey("lsSrce")) {
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
          try {
            _restoreHelper();
          } catch (e) {
            txError = "Error ${e.toString()}";
          }
        }
      });
    } else if (lsHand.isEmpty && lsHist.isEmpty && lsSrce.isEmpty) {
      // starting from scratchr
      _resetHelper();
    } else {
      showOkCancelDialog(context, "Reset", "This will throw away everything and start anew, are you sure?").then((DialogResult res) {
        if (res == DialogResult.ok) {
          _resetHelper();
        }
      });
    }

    if (txError != "") {
      msgBox(context, "Error $txError");
    }
  }

  void _resetHelper() {
    setState(() {
      lsSrce.clear();
      lsDraw.clear();
      lsHand.clear();
      lsHist.clear();
      lsSrce = List.generate(lsKard.length, (index) => index); // generate a list of 1 to 100 which will then be shuffled
      lsSrce.shuffle();
      saveData(lsSrce, lsDraw, lsHand, lsHist); // 20250718 EH omitted
    });
  }

  Future<void> _restoreHelper() async {
    // Not implemented
    try {
      GameState gs = loadData(); // returns the last group of settings
      setState(() {
        lsSrce = gs.lsSrce;
        lsDraw = gs.lsDraw;
        lsHand = gs.lsHand;
        lsHist = gs.lsHist;
      });
    } catch (e) {
      rethrow;
      //      debugPrint("Failed");
    }
  }

  void undoHist(BuildContext context) {
    /******
    debugPrint("Printing the history\n");
    for (final h in lsHist) {
      debugPrint(" ${h.idKard} '${getNmKard(h.idKard)}' ${h.tyHistAct}");
    }
******/

    // use the last one and figure out where it came from
    final Hist vH = lsHist.last;
    setState(() {
      switch (vH.tyHistAct) {
        case TyHistAct.deletedFromDraw:
          lsDraw.add(vH.idKard);
          break;
        case TyHistAct.deletedFromHand:
          lsHand.add(vH.idKard);
          break;
        case TyHistAct.drawn:
          lsSrce.insert(0, vH.idKard);

          // as reversing lsSrce->lsDraw, need to find where vH.idKard is in Draw list
          final int indexOfWanted = lsDraw.indexWhere((k) => k == vH.idKard);
          lsDraw.removeAt(indexOfWanted);
          break;
        case TyHistAct.moved:
          lsDraw.add(vH.idKard);

          // as reversing lsDraw->lsHand, need to find where vH.idKard is in Hand list
          final int indexOfWanted = lsHand.indexWhere((k) => k == vH.idKard);
          lsHand.removeAt(indexOfWanted);
      }
      lsHist.removeLast();
      saveData(lsSrce, lsDraw, lsHand, lsHist); // 20250718 EH omitted
    });
  }

  void _draw(BuildContext context) {
    if (lsDraw.length > 2) {
      msgBox(context, "You can only draw up to 3 cards, either play or discard.");
    } else if (lsSrce.isEmpty) {
      msgBox(context, "There are no more cards to draw.");
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
    //   debugPrint("removeHand $index");
    setState(() {
      lsHist.add(Hist(lsHand[index], TyHistAct.deletedFromHand));
      lsHand.removeAt(index);
    });
    saveData(lsSrce, lsDraw, lsHand, lsHist);
  }

  void moveToHand(int index) {
    setState(() {
      //    debugPrint("removeKardTohand $index");
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
                    lsSrce.shuffle();
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
                    tySituation: TySituation.drawn,
                    fnMove: () {
                      moveToHand(index);
                    },
                    fnPlay: () {},
                    fnRemove: () {
                      removeDraw(index);
                    },
                  );
                },
              ),
            ),
            mySectionText("In Hand"),
            Expanded(
              child: ListView.builder(
                itemCount: lsHand.length,
                itemBuilder: (_, index) {
                  return WidgetKard(
                    idKard: lsHand[index],
                    tySituation: TySituation.inhand,
                    fnMove: () {
                      removeHand(index);
                    },
                    fnRemove: () {
                      removeHand(index);
                    },
                    fnPlay: () {
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
