import 'package:flutter/material.dart';
import 'package:foodstuff/food_card.dart';
import 'package:foodstuff/food_database.dart';

class FoodCardEdit extends StatelessWidget {

  const FoodCardEdit({
    super.key,
    required this.food,
    required this.database,
  });

  final String food;
  final FoodDatabase database;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FoodCard(currentFood: food),
          ElevatedButton(
            onPressed: () {
              database.removeFood(food);
            },
            child: Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}
