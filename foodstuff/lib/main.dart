import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "dart:math";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          title: 'FoodStuff',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          ),
          home: MyHomePage(),
        ));
  }
}

T getRandomElement<T>(List<T> list) {
  final random = Random();
  var i = random.nextInt(list.length);
  return list[i];
}

List<String> getFood() {
  return [
    'Steak',
    'Potato',
    'Apple'
  ]
}

class MyAppState extends ChangeNotifier {
  var current = getRandomElement(getFood());

  void getNextFood() {
    current = getRandomElement(getFood());
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var currentFood = appState.current;

    return Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Random food:'),
                FoodCard(currentFood: currentFood),
                ElevatedButton(
                  onPressed: () {
                    appState.getNextFood();
                  },
                  child: Text('Next'),
                )
              ],
            ),
        ));
  }
}

class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key,
    required this.currentFood,
  });

  final String currentFood;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      shadowColor: theme.colorScheme.secondary,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(currentFood, style: style),
      ),
    );
  }
}
