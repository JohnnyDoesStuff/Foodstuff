import 'package:flutter/material.dart';
import 'package:foodstuff/food_card.dart';
import 'package:foodstuff/food_database.dart';

class FoodListPage extends StatelessWidget {

  final FoodDatabase database;
  FoodListPage(this.database);

  @override
  Widget build(BuildContext context) {
    var allFood = database.getFood();
    allFood.sort();

    final List<FoodCard> foodCards;
    var result = allFood.map(
      (food) => FoodCard(currentFood: food)
    );
    foodCards = result.toList();

    return Center(
      child: SingleChildScrollView (
        child: Column(
          children: foodCards,
        ),
      ),
    );
  }
}
