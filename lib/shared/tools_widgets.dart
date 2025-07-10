import 'package:flutter/material.dart';

Widget myTopButton({required String label, required VoidCallback onPressed}) {
  return FilledButton(
    onPressed: onPressed,
    style: FilledButton.styleFrom(
      //#15 use the name of the widget to get styles
      backgroundColor: Colors.blue[800],
      foregroundColor: Colors.white,
    ),
    child: Text(label),
  );
}

Widget mySectionText(String label) {
  return Text(label, style: TextStyle(color: Colors.amberAccent));
}
