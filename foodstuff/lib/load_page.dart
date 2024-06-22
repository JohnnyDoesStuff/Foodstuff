import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:foodstuff/food_database.dart';
import 'package:foodstuff/localization.dart';

class LoadPage extends StatelessWidget {
  final FoodDatabase database;

  LoadPage(this.database);

  @override
  Widget build(BuildContext context) {
    final fileDialogParams = OpenFileDialogParams(
      dialogType: OpenFileDialogType.document,
      sourceType: SourceType.photoLibrary,
    );
    var localization = Localization.getLocalization(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(localization.importFoodFile),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final filePath = await FlutterFileDialog.pickFile(
                        params: fileDialogParams);
                    database.importFood(filePath!);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.upload),
                      Text(localization.importFoodDataButton),
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
