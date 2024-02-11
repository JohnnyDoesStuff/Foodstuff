import 'package:flutter/material.dart';
import 'package:foodstuff/food_card_edit.dart';
import 'package:foodstuff/food_database.dart';

class FoodListPage extends StatelessWidget {
  final FoodDatabase database;
  FoodListPage(this.database);

  @override
  Widget build(BuildContext context) {
    var allFood = database.getFood();
    allFood.sort();

    List<FoodCardEdit> foodCards = List.empty();

    removeFood(String foodToRemove) {
      database.removeFood(foodToRemove);
    }

    var result = allFood.map((food) => FoodCardEdit(
          food: food,
          removeFood: removeFood,
        ));
    foodCards = result.toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: foodCards,
          ),
        ),
      ),
    );
  }
}
