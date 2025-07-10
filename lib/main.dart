import 'package:flutter/material.dart';
import 'package:hns/screens/home.dart';
import 'package:hns/shared/config.dart';
import 'package:hns/shared/sharedprefshelper.dart';

void main() async {
  /* Check if there is a previous session; must do the WidgetsFlutterBinding.ensureInitialized() step
     first because of the await in SharedPrefsHelper*/
  WidgetsFlutterBinding.ensureInitialized(); // This line is essential before SharedPrefsHelper
  await SharedPrefsHelper.init(); //Prefs provides access to on device save of the last game moves
  runApp(MaterialApp(home: Home(), theme: thmPrimary));
}
