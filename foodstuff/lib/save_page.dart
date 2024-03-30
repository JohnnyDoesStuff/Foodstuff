import 'package:flutter/material.dart';
import 'package:foodstuff/food_database.dart';

class SavePage extends StatelessWidget {
  final FoodDatabase foodDatabase;

  const SavePage(this.foodDatabase);

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    const String downloadDirectory = "storage/emulated/0/Download/";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Save data to a file in your phone\'s download directory'),
            TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter a file name',
              ),
              controller: textController,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    var exportPath = downloadDirectory + textController.text;
                    foodDatabase.exportFood(exportPath);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.download),
                      Text('Export food data'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
