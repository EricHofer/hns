/*
Purpose: This class provides a workaround to async determine if there
         are any preferences already saved. This is affects the "reset" 
         dialogue which will only offer to "restore" a previous session
         if it finds some lsSrce data. 

Caveats: Called by "main" and only after WidgetsFlutterBInding.ensureInitialised()

History: 20250710 EH Created
*/
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
