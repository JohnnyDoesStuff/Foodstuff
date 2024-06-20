import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:foodstuff/food_add_page.dart';
import 'package:foodstuff/food_list_page.dart';
import 'package:foodstuff/generator_page.dart';
import 'package:foodstuff/initializing_page.dart';
import 'package:foodstuff/load_page.dart';
import 'package:foodstuff/localization.dart';
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
    return FutureBuilder(
      future: _createApp(),
      builder: _loadingScreen,
    );
  }

  Widget _loadingScreen(BuildContext context, AsyncSnapshot<Widget> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return InitializingPage();
      default:
        if (snapshot.hasError) {
          throw "Error: ${snapshot.error}";
        } else {
          return snapshot.data!;
        }
    }
  }

  Future<Widget> _createApp() async {
    var appState = await MyAppState.create();
    return ChangeNotifierProvider(
      create: (context) => appState,
      child: MaterialApp(
        title: 'FoodStuff',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
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

    var localization = Localization.getLocalization(context);

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
                      label: Text(localization.home),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.food_bank_sharp),
                      label: Text(localization.allFoodPage),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.add_shopping_cart),
                      label: Text(localization.addFood),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.save_alt),
                      label: Text(localization.exportFoodData),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.file_upload),
                      label: Text(localization.importFoodData),
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
