import 'package:flutter/material.dart';
import 'package:foodstuff/food_database.dart';

class FoodAddPage extends StatelessWidget {
  final FoodDatabase database;
  final TextEditingController textController = TextEditingController();
  FoodAddPage(this.database);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Enter a food name',
            ),
            controller: textController,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () {
                    database.addFood(textController.text);
                  },
                  child: Text('Add food'))
            ],
          )
        ],
      ),
    );
  }
}
