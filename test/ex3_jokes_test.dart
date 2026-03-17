import 'package:flutter_test/flutter_test.dart';
import 'package:ra3_flutter_services_dacaga24_cpu/ex3_jokes/service/joke_service.dart';

void main() {
  group('JokesApi', () {
    test('get jokes llista no buida', () async {
      final jokeService = JokeService();
      final jokes = await jokeService.getJokes();

      expect(jokes.length, greaterThan(0));

      expect(jokes[0].setup, isNotEmpty);
      expect(jokes[0].punchline, isNotEmpty);
      expect(jokes[0].type, isNotEmpty);
    });

    test('get random joke retorna un acudit', () async {
      final jokeService = JokeService();
      final joke = await jokeService.getRandomJoke();

      expect(joke.setup, isNotEmpty);
      expect(joke.punchline, isNotEmpty);
    });
  });
}