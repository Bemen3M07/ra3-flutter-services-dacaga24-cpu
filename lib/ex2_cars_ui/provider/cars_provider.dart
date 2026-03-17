import 'package:flutter/material.dart';
import '../../ex1_cars/model/car_model.dart';
import '../../ex1_cars/service/car_http_service.dart';

class CarsProvider extends ChangeNotifier {
  final CarHttpService _service = CarHttpService();

  List<CarsModel> _cars = [];
  bool _isLoading = false;
  String? _error;

  List<CarsModel> get cars => _cars;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCars() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _cars = await _service.getCars();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}