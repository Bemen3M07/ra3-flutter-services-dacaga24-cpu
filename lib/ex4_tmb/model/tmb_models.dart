import 'dart:convert';

// Model per a una línia de bus
class BusLinia {
  final int idLinia;
  final int codiLinia;
  final String nomLinia;
  final String descLinia;
  final String colorLinia;

  BusLinia({
    required this.idLinia,
    required this.codiLinia,
    required this.nomLinia,
    required this.descLinia,
    required this.colorLinia,
  });

  factory BusLinia.fromJson(Map<String, dynamic> json) {
    final props = json['properties'] as Map<String, dynamic>;
    return BusLinia(
      idLinia: props['ID_LINIA'] ?? 0,
      codiLinia: props['CODI_LINIA'] ?? 0,
      nomLinia: props['NOM_LINIA'] ?? '',
      descLinia: props['DESC_LINIA'] ?? '',
      colorLinia: props['COLOR_LINIA'] ?? 'DA291C',
    );
  }
}

List<BusLinia> busLiniesFromJson(String str) {
  final data = jsonDecode(str);
  final features = data['features'] as List;
  return features.map((f) => BusLinia.fromJson(f)).toList();
}

// Model per a una parada de bus
class BusParada {
  final int idParada;
  final int codiParada;
  final String nomParada;
  final String adreca;
  final String nomDistricte;

  BusParada({
    required this.idParada,
    required this.codiParada,
    required this.nomParada,
    required this.adreca,
    required this.nomDistricte,
  });

  factory BusParada.fromJson(Map<String, dynamic> json) {
    final props = json['properties'] as Map<String, dynamic>;
    return BusParada(
      idParada: props['ID_PARADA'] ?? 0,
      codiParada: props['CODI_PARADA'] ?? 0,
      nomParada: props['NOM_PARADA'] ?? '',
      adreca: props['ADRECA'] ?? '',
      nomDistricte: props['NOM_DISTRICTE'] ?? '',
    );
  }
}

List<BusParada> busParadesFromJson(String str) {
  final data = jsonDecode(str);
  final features = data['features'] as List;
  return features.map((f) => BusParada.fromJson(f)).toList();
}

// Model per a un autobús que passa per una parada (iBus)
class IBusArrival {
  final String line;
  final String destination;
  final int tInMin;
  final String textCa;

  IBusArrival({
    required this.line,
    required this.destination,
    required this.tInMin,
    required this.textCa,
  });

  factory IBusArrival.fromJson(Map<String, dynamic> json) {
    return IBusArrival(
      line: json['line'] ?? '',
      destination: json['destination'] ?? '',
      tInMin: json['t-in-min'] ?? 0,
      textCa: json['text-ca'] ?? '',
    );
  }
}

List<IBusArrival> iBusArrivalsFromJson(String str) {
  final data = jsonDecode(str);
  final ibus = data['data']['ibus'] as List;
  return ibus.map((a) => IBusArrival.fromJson(a)).toList();
}