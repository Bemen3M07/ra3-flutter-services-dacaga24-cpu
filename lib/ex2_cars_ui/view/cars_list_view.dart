import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cars_provider.dart';

class CarsListView extends StatefulWidget {
  const CarsListView({super.key});

  @override
  State<CarsListView> createState() => _CarsListViewState();
}

class _CarsListViewState extends State<CarsListView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() =>
        context.read<CarsProvider>().fetchCars());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Llista de Cotxes'),
      ),
      body: Consumer<CarsProvider>(
        builder: (context, provider, child) {

          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Text(
                'Error: ${provider.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.cars.length,
            itemBuilder: (context, index) {
              final car = provider.cars[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(car.year.toString().substring(2)),
                  ),
                  title: Text(
                    '${car.make} ${car.model}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Tipus: ${car.type}'),
                  trailing: Text(
                    '#${car.id}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}