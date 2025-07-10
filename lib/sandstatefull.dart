import 'package:flutter/material.dart';

class SandStateful extends StatefulWidget {
  const SandStateful({super.key});

  @override
  State<SandStateful> createState() => _SandStatefulState();
}

class _SandStatefulState extends State<SandStateful> {
  int ctTree = 1;
  int ctDoor = 1;

  void increaseTree() {
    print(ctTree);
    setState(() {
      // #16 10m
      ctTree = (ctTree > 5) ? 1 : ctTree + 1;
    });
  }

  void fnOnPressed() {
    print("pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sand Stateful"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, //#11 @6m50 .end, .start
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Text('Tree'),
              Text('$ctTree'),
              // SizedBox(50),
              for (int i = 0; i < ctTree; i++)
                Image.asset(
                  "assets/img/behindtree.jpg",
                  width: 30,
                  color: Colors.white,
                  colorBlendMode: BlendMode.multiply, //#14 6m18
                ),
              if (ctTree == 4)
                const Text('FOUR'), //#18 5m09 - can generate alternatives
              const Expanded(child: SizedBox()),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.brown),
                onPressed: increaseTree,
                child: Text('+'),
              ),
            ],
          ),
          MyStyleText("Rover", Colors.blueAccent),
          MyStyleText("Nower", Colors.purple),
          MyButton(
            txButton: "A Button",
            clrBackground: Colors.greenAccent,
            fnOnPressed: fnOnPressed,
          ),
        ],
      ),
    );
  }
}

class MyStyleText extends StatelessWidget {
  //#18 replacing settings
  const MyStyleText(this.text, this.backgroundColor, {super.key});

  final String text;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: backgroundColor,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ), //#11 12m09
    );
  }
}

class MyButton extends StatelessWidget {
  final String txButton;
  final Color? clrBackground;
  final void Function() fnOnPressed;

  const MyButton({
    super.key,
    required this.txButton,
    required this.clrBackground,
    required this.fnOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: fnOnPressed,
      style: TextButton.styleFrom(
        backgroundColor: clrBackground,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ), //#18 10m06
      ),
      child: Text(txButton),
    );
  }
}
