import 'package:flutter/material.dart';
import 'package:foodstuff/food_card.dart';

class FoodCardEdit extends StatefulWidget {

  const FoodCardEdit({
    super.key,
    required this.food,
    required this.removeFood,
  });

  final String food;
  final void Function(String) removeFood;

  @override
  State<StatefulWidget> createState() => _FoodCardEditState();

}

class _FoodCardEditState extends State<FoodCardEdit> {

  late String food;
  late void Function(String) removeFood;
  bool isRemoved = false;

  @override
  Widget build(BuildContext context) {
    food = widget.food;
    removeFood = widget.removeFood;

    return isRemoved ? Container()
      : SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FoodCard(currentFood: food),
          ElevatedButton(
            onPressed: () {
              removeFood(food);
              setState(() {
                isRemoved = true;
              });
            },
            child: Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}
