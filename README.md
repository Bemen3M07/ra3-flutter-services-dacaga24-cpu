# P5d: APIs i serveis — Flutter
**Mòdul:** M08 - Programació multimèdia i dispositius mòbils
**Alumne:** Daniel Caravaca Garcia
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

### Millores de disseny
- Cards amb `elevation` i cantonades arrodonides
- Badge de color per cada tipus de cotxe (SUV, Sedan, Convertible...)
- Icona de cotxe per cada element de la llista
- Colors corporatius amb blau fosc `#1A237E`

## Exercici 3 — Acudits (Jokes API)

### Descripció
Aplicació que mostra acudits aleatoris de l'API
[Good Jokes](https://api.sampleapis.com/jokes/goodJokes).
Cada vegada que es prem el botó es crida l'API i es mostra un nou acudit.

### Tecnologies utilitzades
- `http` package per les crides REST
- `provider` package per gestió d'estat
- `BottomNavigationBar` per navegar entre exercises

### Estructura de fitxers
```
lib/
  ex3_jokes/
    model/joke_model.dart        → Classe JokeModel
    service/joke_service.dart    → getJokes() i getRandomJoke()
    provider/joke_provider.dart  → JokeProvider amb fetchRandomJoke()
    view/joke_view.dart          → Vista amb botó i targeta d'acudit
test/
  ex3_jokes_test.dart            → Tests del servei
```

### Patró utilitzat
- **Model** → `JokeModel`
- **Vista** → `JokeView`
- **Controlador** → `JokeProvider`

### Endpoint
```
GET https://api.sampleapis.com/jokes/goodJokes
```

## Exercici 4 — TMB Barcelona

### Descripció
Aplicació que connecta amb l'API de [TMB](https://developer.tmb.cat/)
per consultar línies de bus, parades i horaris en temps real.

### Tecnologies utilitzades
- API de TMB (developer.tmb.cat)
- `http` package per les crides REST
- `provider` package per gestió d'estat
- `TabBar` i `TabBarView` per navegar entre seccions

## Exercici 4 — TMB Barcelona

### Descripció
Aplicació que connecta amb l'API de [TMB](https://developer.tmb.cat/)
per consultar línies de bus, parades i horaris en temps real.

### Tecnologies utilitzades
- API de TMB (developer.tmb.cat)
- `http` package per les crides REST
- `provider` package per gestió d'estat
- `TabBar` i `TabBarView` per navegar entre seccions

### Estructura de fitxers
```
lib/
  ex4_tmb/
    model/tmb_models.dart     → BusLinia, BusParada, IBusArrival
    service/tmb_service.dart  → getLinies(), getParades(), getArrivals()
    provider/tmb_provider.dart → TmbProvider amb 3 estats
    view/tmb_view.dart         → Vista amb 3 tabs
```

### Endpoints utilitzats
```
GET https://api.tmb.cat/v1/transit/linies/bus        → Totes les línies
GET https://api.tmb.cat/v1/transit/parades           → Totes les parades
GET https://api.tmb.cat/v1/ibus/stops/{id}           → Horaris per parada
```

### Funcionament
1. **Tab Línies**: Llista totes les línies de bus amb nom, descripció i color
2. **Tab Parades**: Llista totes les parades amb adreça i districte
3. **Tab Horaris**: Introdueix un codi de parada (ex: 1265) i veus
   els autobusos que han de passar amb el temps d'espera en temps real

### Patró utilitzat
- **Model** → `BusLinia`, `BusParada`, `IBusArrival`
- **Vista** → `TmbView`
- **Controlador** → `TmbProvider`