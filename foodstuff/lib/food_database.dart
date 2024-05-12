import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FoodDatabase {
  late List<String> foodList;
  late String storagePath;

  FoodDatabase._(this.storagePath) {
    foodList = List.empty(growable: true);
    var databaseFile = File(storagePath);
    if (!databaseFile.existsSync()) {
      databaseFile.create();
      foodList = _getDefaultFood();
      _storeFood();
    }
    _loadFood();
  }

  List<String> getFood() {
    return List.from(foodList);
  }

  void addFood(String newFood) {
    _tryAddFoodToMemory(newFood);
    _storeFood();
  }

  void removeFood(String foodToRemove) {
    if (foodList.contains(foodToRemove)) {
      foodList.remove(foodToRemove);
      _storeFood();
    }
  }

  void exportFood(String exportPath) {

    if (exportPath.isEmpty) {
      return;
    }

    if (!exportPath.endsWith('.txt')) {
      exportPath = '$exportPath.txt';
    }

    var databaseFile = File(exportPath);
    String content = foodList.join("\n");
    databaseFile.writeAsStringSync(content);
  }

  void importFood(String importPath) {
    var databaseFile = File(importPath);
    String content = databaseFile.readAsStringSync();
    var allFoodToAdd = content.split("\n");
    for (var newFood in allFoodToAdd) {
      _tryAddFoodToMemory(newFood);
    }
    _storeFood();
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
    var databaseText = databaseFile.readAsLinesSync();

    for (var element in databaseText) {
      _tryAddFoodToMemory(element);
    }
  }

  void _tryAddFoodToMemory(String newFood) {
    if (newFood.isEmpty) {
      return;
    }

    newFood = newFood.trim();

    if (newFood.startsWith('#')) {
      return;
    }
    if (foodList.any((food) => food.toLowerCase() == newFood.toLowerCase())) {
      return;
    }
    foodList.add(newFood);
  }

  void _storeFood() {
    exportFood(storagePath);
  }

  List<String> _getDefaultFood() {
    return [
      'Steak',
      'Potato',
      'Apple',
      'Banana'
    ];
  }

}
