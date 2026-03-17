import 'package:flutter_test/flutter_test.dart';
import 'package:ra3_flutter_services_dacaga24_cpu/ex1_cars/service/car_http_service.dart';

void main() {
  group('CarsApi', () {
    test('get cars', () async {
      final carHttpService = CarHttpService();
      final cars = await carHttpService.getCars();

      expect(cars.length, 10);

      expect(cars[0].id, 9582);
      expect(cars[9].id, 9591);

      expect(cars[0].make, isNotEmpty);
      expect(cars[0].model, isNotEmpty);
      expect(cars[0].type, isNotEmpty);
    });
  });
}