class FoodDatabase {

  final List<String> foodList = ['Steak', 'Potato', 'Apple', 'Banana'];

  List<String> getFood() {
    return foodList;
  }

  void addFood(String newFood) {

    // todo: make it case insensitive
    if (foodList.contains(newFood)) {
      return;
    }
    foodList.add(newFood);
  }
}
