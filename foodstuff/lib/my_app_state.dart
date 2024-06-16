import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodstuff/food_database.dart';

class MyAppState extends ChangeNotifier {
  // todo: make database private since it is a late variable
  FoodDatabase database;
  var current = 'No food selected';

  MyAppState._(this.database);

  void getNextFood() {
    var allFood = database.getFood();
    if (allFood.isEmpty) {
      current = 'No food is stored';
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
