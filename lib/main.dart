import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ex2_cars_ui/provider/cars_provider.dart';
import 'ex2_cars_ui/view/cars_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarsProvider()),
      ],
      child: MaterialApp(
        title: 'Cars API',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CarsListView(),
      ),
    );
  }
}