import 'package:flutter/material.dart';
import 'package:foodstuff/food_add_page.dart';
import 'package:foodstuff/food_list_page.dart';
import 'package:foodstuff/generator_page.dart';
import 'package:foodstuff/load_page.dart';
import 'package:foodstuff/my_app_state.dart';
import 'package:foodstuff/save_page.dart';
import 'package:provider/provider.dart';

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

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
      case 1:
        page = FoodListPage(appState.database);
      case 2:
        page = FoodAddPage(appState.database);
      case 3:
        page = SavePage(appState.database);
      case 4:
        page = LoadPage(appState.database);
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.food_bank_sharp),
                      label: Text('All food'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.add_shopping_cart),
                      label: Text('Add food'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.save_alt),
                      label: Text('Export food data'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.file_upload),
                      label: Text('Import food data'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
