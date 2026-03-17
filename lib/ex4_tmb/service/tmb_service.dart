import 'package:http/http.dart' as http;
import '../model/tmb_models.dart';

class TmbService {
  final String _baseUrl = 'https://api.tmb.cat/v1';
  final String _appId = 'aea76804';
  final String _appKey = 'ce4b206f88b5514bb566461d9bc3a405';

  String get _params => 'app_id=$_appId&app_key=$_appKey';

  Future<List<BusLinia>> getLinies() async {
    final uri = Uri.parse('$_baseUrl/transit/linies/bus?$_params');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return busLiniesFromJson(response.body);
    } else {
      throw Exception('Error obtenint línies: ${response.statusCode}');
    }
  }

  Future<List<BusParada>> getParades() async {
    final uri = Uri.parse('$_baseUrl/transit/parades?$_params');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return busParadesFromJson(response.body);
    } else {
      throw Exception('Error obtenint parades: ${response.statusCode}');
    }
  }

  Future<List<IBusArrival>> getArrivals(int codiParada) async {
    final uri = Uri.parse('$_baseUrl/ibus/stops/$codiParada?$_params');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return iBusArrivalsFromJson(response.body);
    } else {
      throw Exception('Error obtenint horaris: ${response.statusCode}');
    }
  }
}