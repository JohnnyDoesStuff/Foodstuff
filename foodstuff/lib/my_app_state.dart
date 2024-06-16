import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodstuff/food_database.dart';

class MyAppState extends ChangeNotifier {
  // todo: make database private since it is a late variable
  late FoodDatabase database;
  var current = 'No food selected';

  MyAppState() {
    var futureDatabase = FoodDatabase.create();
    futureDatabase.then((value) => database = value);
  }

  void getNextFood() {
    var allFood = database.getFood();
    if (allFood.isEmpty) {
      current = 'No food is stored';
    } else {
      current = _getRandomElement(allFood);
    }
    notifyListeners();
  }

  T _getRandomElement<T>(List<T> list) {
    final random = Random();
    var i = random.nextInt(list.length);
    return list[i];
  }
}
