import 'dart:math';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:foodstuff/food_database.dart';
import 'package:foodstuff/localization.dart';

class MyAppState extends ChangeNotifier {
  // todo: make database private since it is a late variable
  FoodDatabase database;
  late AppLocalizations localization;
  late String current;

  MyAppState._(this.database) {
    // todo: if localization is configurable at some point
    // it has to be checked if this gets updated automatically or not
    localization = Localization.getCurrentLocalization();
    if (database.getFood().isEmpty) {
      current = localization.appStateNoFoodStored;
    } else {
      current = localization.appStateNoFoodSelected;
    }
  }

  void getNextFood() {
    var allFood = database.getFood();
    if (allFood.isEmpty) {
      current = localization.appStateNoFoodStored;
    } else {
      current = _getRandomElement(allFood);
    }
    notifyListeners();
  }

  static Future<MyAppState> create() async {
    var futureDatabase = await FoodDatabase.create();
    return MyAppState._(futureDatabase);
  }

  T _getRandomElement<T>(List<T> list) {
    final random = Random();
    var i = random.nextInt(list.length);
    return list[i];
  }
}
