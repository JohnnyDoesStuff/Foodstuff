import 'package:path_provider/path_provider.dart';

class FoodDatabase {
  late List<String> foodList;

  FoodDatabase._(String storagePath) {
    print(storagePath);
    foodList = ['Steak', 'Potato', 'Apple', 'Banana'];
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
  }

  void removeFood(String foodToRemove) {
    if (foodList.contains(foodToRemove)) {
      foodList.remove(foodToRemove);
    }
  }

  static Future<FoodDatabase> create() async {
    var directory = await getApplicationDocumentsDirectory();
    String directoryPath = directory.path;
    String storagePath = '$directoryPath/foodStuff.txt';

    return FoodDatabase._(storagePath);
  }
}
