class FoodDatabase {

  final List<String> foodList = ['Steak', 'Potato', 'Apple', 'Banana'];

  List<String> getFood() {
    return foodList;
  }

  void addFood(String newFood) {

    if(newFood.isEmpty) {
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
}
