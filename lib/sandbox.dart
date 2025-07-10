import 'package:flutter/material.dart';

class ColCont extends StatelessWidget {
  const ColCont({super.key});

  void increaseLOGO() {
    print("logo"); //#15 3m35 : not good prax in real app
  }

  // #12: does Rows
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ColCont"), backgroundColor: Colors.grey),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, //#11 @6m50 .end, .start
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(width: 100, color: Colors.red, child: Text('111')), //#11
          Container(width: 200, color: Colors.blue, child: Text('two')),
          Row(
            children: [
              const Text('h/o/e'),
              Image.asset('assets/img/hoe.jpg', width: 50), //#13
              const SizedBox(width: 50),
            ],
          ),
          Container(
            //#11 10m40 : padding aspect which makes the cell bigger
            color: Colors.brown[300],
            padding: const EdgeInsets.all(10),
            child: Text(
              '444FFF',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22), //#11 12m09
            ),
          ),
          Container(color: Colors.brown[300], padding: const EdgeInsets.all(20), child: Text('555')),

          Row(
            children: [
              const Text("DSB-6yX"),
              Image.asset(
                "assets/img/DSBLogo.jpg",
                width: 75,
                color: Colors.white,
                colorBlendMode: BlendMode.multiply, //#14 6m18
              ),
              Expanded(child: SizedBox()),
              FilledButton(
                //#15 5m38 -
                style: FilledButton.styleFrom(
                  //#15 use the name of the widget to get styles
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.lime,
                ),
                onPressed: increaseLOGO,
                child: const Text("+"),
              ), //#15 2m28
            ],
          ),
          Row(
            children: [
              const Text("tree"),
              Image.asset(
                "assets/img/behindtree.jpg",
                width: 75,
                color: Colors.white,
                colorBlendMode: BlendMode.multiply, //#14 6m18
              ),
              Expanded(child: SizedBox()),
              TextButton(onPressed: () {}, child: const Text("+")), //#15 2m48
            ],
          ),

          Expanded(
            //#14 3m20
            child: Image.asset(
              'assets/img/DSBLogo.jpg',
              alignment: Alignment.bottomRight, //#11 4m30
              //fit: BoxFit.fitWidth, // fits the entire box
            ),
          ),
        ],
      ),
    );
  }
}
