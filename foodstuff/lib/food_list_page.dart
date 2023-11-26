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

    final List<FoodCardEdit> foodCards;
    var result = allFood.map((food) => FoodCardEdit(
          food: food,
          database: database,
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
