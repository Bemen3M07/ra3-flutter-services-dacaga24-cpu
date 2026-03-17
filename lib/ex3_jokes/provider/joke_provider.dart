import 'package:flutter/material.dart';
import '../model/joke_model.dart';
import '../service/joke_service.dart';

class JokeProvider extends ChangeNotifier {
  final JokeService _service = JokeService();

  JokeModel? _currentJoke;
  bool _isLoading = false;
  String? _error;

  JokeModel? get currentJoke => _currentJoke;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchRandomJoke() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentJoke = await _service.getRandomJoke();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}