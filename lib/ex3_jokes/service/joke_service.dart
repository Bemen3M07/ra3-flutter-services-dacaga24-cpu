import 'package:http/http.dart' as http;
import '../model/joke_model.dart';

class JokeService {
  final String _url = "https://api.sampleapis.com/jokes/goodJokes";

  Future<List<JokeModel>> getJokes() async {
    var uri = Uri.parse(_url);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return jokesFromJson(response.body);
    } else {
      throw Exception("Error al obtenir els acudits: ${response.statusCode}");
    }
  }

  Future<JokeModel> getRandomJoke() async {
    final jokes = await getJokes();
    jokes.shuffle();
    return jokes.first;
  }
}