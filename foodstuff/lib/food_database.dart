class FoodDatabase {

  final List<String> foodList = ['Steak', 'Potato', 'Apple', 'Banana'];

  List<String> getFood() {
    return foodList;
  }

  void addFood(String newFood) {
    foodList.add(newFood);
  }
}
