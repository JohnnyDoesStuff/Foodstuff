import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FoodDatabase {
  late List<String> foodList;
  late String storagePath;

  FoodDatabase._(this.storagePath) {
    var databaseFile = File(storagePath);
    if (!databaseFile.existsSync()) {
      databaseFile.create();
      foodList = ['Steak', 'Potato', 'Apple', 'Banana'];
      _storeFood();
    }
    _loadFood();
  }

  List<String> getFood() {
    return foodList;
  }

  void addFood(String newFood) {
    if (newFood.isEmpty) {
      return;
    }
    // todo: make it case insensitive
    if (foodList.contains(newFood)) {
      return;
    }
    foodList.add(newFood);
    _storeFood();
  }

  void removeFood(String foodToRemove) {
    if (foodList.contains(foodToRemove)) {
      foodList.remove(foodToRemove);
      _storeFood();
    }
  }

  static Future<FoodDatabase> create() async {
    var directory = await getApplicationDocumentsDirectory();
    String directoryPath = directory.path;
    String storagePath = '$directoryPath/foodStuff.txt';

    return FoodDatabase._(storagePath);
  }

  // private functions

  void _loadFood() {
    var databaseFile = File(storagePath);
    var data = databaseFile.readAsLines();
    data.then((value) => foodList = value);
  }

  void _storeFood() {
    var databaseFile = File(storagePath);
    String content = foodList.join("\n");
    databaseFile.writeAsStringSync(content);
  }

}
