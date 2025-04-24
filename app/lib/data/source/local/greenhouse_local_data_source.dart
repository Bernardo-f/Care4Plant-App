import 'package:shared_preferences/shared_preferences.dart';

class GreenhouseLocalDataSource {
  Future<bool> getShowMessageGreenhouse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? showMessageGreenhouse = prefs.getBool("showMessageGreenhouse");
    if (showMessageGreenhouse == null) {
      // Si es que no se encuentra es por que no se ha mostrado el mensaje
      return true;
    } else {
      return showMessageGreenhouse;
    }
  }

  Future<void> setShowMessageGreenhouse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("showMessageGreenhouse", false);
  }
}
