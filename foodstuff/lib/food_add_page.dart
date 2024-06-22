import 'package:flutter/material.dart';
import 'package:foodstuff/food_database.dart';
import 'package:foodstuff/localization.dart';

class FoodAddPage extends StatelessWidget {
  final FoodDatabase database;
  final TextEditingController textController = TextEditingController();
  FoodAddPage(this.database);

  @override
  Widget build(BuildContext context) {
    var localization = Localization.getLocalization(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: localization.addFoodName,
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
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        Text(localization.addFoodButton),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
