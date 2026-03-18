import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cars_provider.dart';
import '../../ex1_cars/model/car_model.dart';

class CarsListView extends StatefulWidget {
  const CarsListView({super.key});

  @override
  State<CarsListView> createState() => _CarsListViewState();
}

class _CarsListViewState extends State<CarsListView> {
  @override
  void initState() {
    super.initState();
    // ignore: use_build_context_synchronously
    Future.microtask(() => context.read<CarsProvider>().fetchCars());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        title: const Text(
          'Cars API',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<CarsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 12),
                  Text(
                    'Error: ${provider.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'All Cars (${provider.cars.length})',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: provider.cars.length,
                  itemBuilder: (context, index) {
                    final car = provider.cars[index];
                    return _CarCard(car: car);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CarCard extends StatelessWidget {
  final CarsModel car;
  const _CarCard({required this.car});

  Color _typeColor(String type) {
    switch (type.toLowerCase()) {
      case 'suv': return Colors.green;
      case 'sedan': return Colors.blue;
      case 'convertible': return Colors.orange;
      case 'truck': return Colors.brown;
      default: return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icona del cotxe
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: const Color(0xFF1A237E).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.directions_car,
                size: 36,
                color: Color(0xFF1A237E),
              ),
            ),
            const SizedBox(width: 16),
            // Informació del cotxe
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${car.make} ${car.model}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${car.year}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Badge del tipus
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: _typeColor(car.type).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _typeColor(car.type)),
              ),
              child: Text(
                car.type,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _typeColor(car.type),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}