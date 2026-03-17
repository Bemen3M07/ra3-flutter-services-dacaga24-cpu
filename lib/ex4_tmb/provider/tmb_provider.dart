import 'package:flutter/material.dart';
import '../model/tmb_models.dart';
import '../service/tmb_service.dart';

class TmbProvider extends ChangeNotifier {
  final TmbService _service = TmbService();

  List<BusLinia> _linies = [];
  bool _isLoadingLinies = false;

  List<BusParada> _parades = [];
  bool _isLoadingParades = false;

  List<IBusArrival> _arrivals = [];
  bool _isLoadingArrivals = false;
  int? _codiParadaActual;

  String? _error;

  List<BusLinia> get linies => _linies;
  List<BusParada> get parades => _parades;
  List<IBusArrival> get arrivals => _arrivals;
  bool get isLoadingLinies => _isLoadingLinies;
  bool get isLoadingParades => _isLoadingParades;
  bool get isLoadingArrivals => _isLoadingArrivals;
  int? get codiParadaActual => _codiParadaActual;
  String? get error => _error;

  Future<void> fetchLinies() async {
    _isLoadingLinies = true;
    _error = null;
    notifyListeners();
    try {
      _linies = await _service.getLinies();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingLinies = false;
      notifyListeners();
    }
  }

  Future<void> fetchParades() async {
    _isLoadingParades = true;
    _error = null;
    notifyListeners();
    try {
      _parades = await _service.getParades();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingParades = false;
      notifyListeners();
    }
  }

  Future<void> fetchArrivals(int codiParada) async {
    _isLoadingArrivals = true;
    _codiParadaActual = codiParada;
    _error = null;
    _arrivals = [];
    notifyListeners();
    try {
      _arrivals = await _service.getArrivals(codiParada);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingArrivals = false;
      notifyListeners();
    }
  }
}