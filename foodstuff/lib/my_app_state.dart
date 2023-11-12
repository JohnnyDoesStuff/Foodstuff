import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodstuff/food_database.dart';

class MyAppState extends ChangeNotifier {
  var database = FoodDatabase();
  var current = 'No food selected';

  void getNextFood() {
    var allFood = database.getFood();
    if (allFood.isEmpty) {
      current = 'No food is stored';
    } else {
      current = getRandomElement(allFood);
    }
    notifyListeners();
  }
}

T getRandomElement<T>(List<T> list) {
  final random = Random();
  var i = random.nextInt(list.length);
  return list[i];
}
