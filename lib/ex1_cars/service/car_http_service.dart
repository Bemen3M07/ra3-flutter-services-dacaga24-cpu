import 'package:http/http.dart' as http;
import '../model/car_model.dart';

class CarHttpService {
  final String _serverUrl = "https://car-data.p.rapidapi.com";
  final String _headerKey = "c72a3c0b95msh4fb717124d0a209p1f79b0jsn46384e77cf89";
  final String _headerHost = "car-data.p.rapidapi.com";

  Future<List<CarsModel>> getCars() async {

    var uri = Uri.parse("$_serverUrl/cars?limit=10&page=0");

    var response = await http.get(uri, headers: {
      "x-rapidapi-key": _headerKey,
      "x-rapidapi-host": _headerHost,
    });

    if (response.statusCode == 200) {
      return carsModelFromJson(response.body);
    } else {
      throw Exception("Error al obtenir la llista de cotxes: ${response.statusCode}");
    }
  }
}