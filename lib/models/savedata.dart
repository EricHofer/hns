import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:hns/models/hist.dart';
import 'package:hns/shared/sharedprefshelper.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:hns/models/game.dart';
//import 'package:hns/shared/utils.dart';

// Save all lists as JSON strings
void saveData(List<int> lsSrce, List<int> lsDraw, List<int> lsHand, List<Hist> lsHist) {
  SharedPrefsHelper.prefs.setString('lsSrce', jsonEncode(lsSrce));
  SharedPrefsHelper.prefs.setString('lsDraw', jsonEncode(lsDraw));
  SharedPrefsHelper.prefs.setString('lsHand', jsonEncode(lsHand));
  SharedPrefsHelper.prefs.setString('lsHist', jsonEncode(lsHist.map((h) => h.toJson()).toList()));
}

/* Future<void> saveData(List<int> lsSrce, List<int> lsDraw, List<int> lsHand, List<Hist> lsHist) async {
  final prefs = await SharedPreferences.getInstance();

  SharedPrefsHelper.prefs.setString('lsSrce', jsonEncode(lsSrce));
  SharedPrefsHelper.prefs.setString('lsDraw', jsonEncode(lsDraw));
  SharedPrefsHelper.prefs.setString('lsHand', jsonEncode(lsHand));
  SharedPrefsHelper.prefs.setString('lsHist', jsonEncode(lsHist.map((h) => h.toJson()).toList()));
  //await prefs.setString('lsSrce', jsonEncode(lsSrce));
  //  await prefs.setString('lsDraw', jsonEncode(lsDraw));
  //  await prefs.setString('lsHand', jsonEncode(lsHand));
  // await prefs.setString('lsHist', jsonEncode(lsHist.map((h) => h.toJson()).toList()));
}
 */

/* // Load and decode JSON strings back to lists
Future<GameState> loadData() async {
  final prefs = await SharedPreferences.getInstance();
  List<int> lsSrce = [], lsDraw = [], lsHand = [];
  List<Hist> lsHist = [];

  String? jsonDeck = prefs.getString('lsSrce');
  String? jsonDraw = prefs.getString('lsDraw');
  String? jsonHand = prefs.getString('lsHand');
  String? jsonHist = prefs.getString('lsHist');

  if (jsonDeck != null) lsSrce = List<int>.from(jsonDecode(jsonDeck));
  if (jsonDraw != null) lsDraw = List<int>.from(jsonDecode(jsonDraw));
  if (jsonHand != null) lsHand = List<int>.from(jsonDecode(jsonHand));
  if (jsonHist != null) {
    try {
      lsHist = (jsonDecode(jsonHist) as List).map<Hist>((e) => Hist.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  debugPrint("Loaded, Draw=$lsDraw");

  return GameState(lsSrce: lsSrce, lsDraw: lsDraw, lsHand: lsHand, lsHist: lsHist);
}
 */

// Load and decode JSON strings back to lists
GameState loadData() {
  List<int> lsSrce = [], lsDraw = [], lsHand = [];
  List<Hist> lsHist = [];

  String? jsonDeck = SharedPrefsHelper.prefs.getString('lsSrce');
  String? jsonDraw = SharedPrefsHelper.prefs.getString('lsDraw');
  String? jsonHand = SharedPrefsHelper.prefs.getString('lsHand');
  String? jsonHist = SharedPrefsHelper.prefs.getString('lsHist');

  if (jsonDeck != null) lsSrce = List<int>.from(jsonDecode(jsonDeck));
  if (jsonDraw != null) lsDraw = List<int>.from(jsonDecode(jsonDraw));
  if (jsonHand != null) lsHand = List<int>.from(jsonDecode(jsonHand));
  if (jsonHist != null) {
    try {
      lsHist = (jsonDecode(jsonHist) as List).map<Hist>((e) => Hist.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      rethrow;
      //      msgBox(context,  "Error loading data: $e.toString()");
    }
  }
  //  debugPrint("Loaded, Draw=$lsDraw");

  return GameState(lsSrce: lsSrce, lsDraw: lsDraw, lsHand: lsHand, lsHist: lsHist);
}
