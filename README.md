# P5d: APIs i serveis — Flutter
**Mòdul:** M08 - Programació multimèdia i dispositius mòbils
**Alumne:** Daniel
**Repositori:** ra3-flutter-services-dacaga24-cpu

---

## Exercici 1 — Accés a un servei REST (Car Data API)

### Descripció
Connexió a l'API [Car Data](https://rapidapi.com/principalapis/api/car-data)
de RapidAPI per obtenir un llistat de cotxes en format JSON.

### Tecnologies utilitzades
- Flutter 3.x
- Dart `http` package
- `dart:convert` per serialització JSON

### Estructura de fitxers
```
lib/
  ex1_cars/
    model/car_model.dart       → Classe CarsModel + serialització JSON
    service/car_http_service.dart → Servei HTTP (getCars)
test/
  ex1_cars_test.dart           → Test unitari del servei
```

### Classe CarsModel
Representa un cotxe amb els camps: `id`, `year`, `make`, `model`, `type`.
Inclou:
- `fromMapToCarObject()` → crea un objecte des d'un Map JSON
- `fromObjectToMap()` → converteix l'objecte a Map JSON

### Servei CarHttpService
Classe que gestiona la connexió HTTP amb l'API:
- URL base: `https://car-data.p.rapidapi.com`
- Mètode: `getCars()` → retorna `Future<List<CarsModel>>`
- Gestió d'errors per codi d'estat HTTP

### Test unitari
Verifica que:
- Es reben 10 cotxes
- Els `id` del primer i últim cotxe són correctes
- Els camps `make`, `model` i `type` no estan buits

### Endpoint provat
```
GET https://car-data.p.rapidapi.com/cars?limit=10&page=0
```

---

## Exercici 2 — Integrar vista i model (Cars UI)

### Descripció
Aplicació Flutter que mostra la llista de cotxes de l'API utilitzant
el patró **MVC** amb **Provider** per gestionar l'estat.

### Tecnologies utilitzades
- `provider` package per gestió d'estat
- `Consumer` widget per escoltar canvis del Provider
- `ListView.builder` per mostrar la llista

### Estructura de fitxers
```
lib/
  ex2_cars_ui/
    provider/cars_provider.dart  → Gestió d'estat amb ChangeNotifier
    view/cars_list_view.dart     → Vista amb ListView
```

### Funcionament
1. En iniciar la vista, el `CarsProvider` crida automàticament `fetchCars()`
2. Mentre carrega, es mostra un `CircularProgressIndicator`
3. Un cop carregats, es mostra la llista amb `make`, `model`, `type` i `year`
4. En cas d'error, es mostra un missatge en vermell

### Patró utilitzat
- **Model** → `CarsModel` (ex1_cars/model)
- **Vista** → `CarsListView`
- **Controlador** → `CarsProvider`


## Exercici 3 — (pendent)
## Exercici 4 — (pendent)