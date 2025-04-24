import 'package:shared_preferences/shared_preferences.dart';

class ReporteDiarioLocalDataSource {
  late SharedPreferences sharedPreferences;

  Future<int?> getReporteDiario() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('fecha_reporte') != null) {
      final dateTime = DateTime.parse(prefs.getString('fecha_reporte')!);
      // Si ha pasado mas de un dia se retorna nulo y significa que el cuidador puede ingresar un nuevo estado diario
      if (DateTime.now().difference(dateTime).inDays >= 1) {
        return null;
      }
    }
    return prefs.getInt("estado_reporte");
  }

  Future<void> addLocalReporteDiario(int estadoReporte) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("estado_reporte", estadoReporte);
    await prefs.setString("fecha_reporte", DateTime.now().toIso8601String());
  }
}
