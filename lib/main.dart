import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ex2_cars_ui/provider/cars_provider.dart';
import 'ex2_cars_ui/view/cars_list_view.dart';
import 'ex3_jokes/provider/joke_provider.dart';
import 'ex3_jokes/view/joke_view.dart';
import 'ex4_tmb/provider/tmb_provider.dart';
import 'ex4_tmb/view/tmb_view.dart';

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
        ChangeNotifierProvider(create: (_) => JokeProvider()),
        ChangeNotifierProvider(create: (_) => TmbProvider()),
      ],
      child: MaterialApp(
        title: 'APIs i Serveis',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainNavigator(),
      ),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    CarsListView(),
    JokeView(),
    TmbView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Cars',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions),
            label: 'Jokes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            label: 'TMB',
          ),
        ],
      ),
    );
  }
}