import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:foodstuff/food_database.dart';
import 'package:mockito/mockito.dart';

class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
      @override
        Future<String> getApplicationDocumentsPath() async {
          final Uri basedir = (goldenFileComparator as LocalFileComparator).basedir;
          var directoryPath = basedir.toFilePath();
          return "$directoryPath../../workspace/test_data";
      }
    }

final Uri basedir = (goldenFileComparator as LocalFileComparator).basedir;
var directoryPath = basedir.toFilePath();
var workspacePath = "$directoryPath../../workspace/test_data";
var newFilePath = "$workspacePath/foodStuff.txt";

void main() {

  setUpAll(() async {
    var workspace = Directory(workspacePath);
    workspace.create(recursive: true);
  });

  group("Can work with a basic database", () {
    setUpAll(() async {
        var originalFile = File("${directoryPath}test_data/foodStuff.txt");
        originalFile.copy(newFilePath);
        PathProviderPlatform.instance = MockPathProviderPlatform();
      });

    test('Can create a food database', () {
      var futureDatabase = FoodDatabase.create();
      expect(futureDatabase, isA<Future<FoodDatabase>>());
    });

    test('Food database contains the expected content', () {
      var futureDatabase = FoodDatabase.create();

      futureDatabase.then((database) {
        expect(database.getFood().length, 3);
        var food = database.getFood();
        expect(food, ['foo0', 'foo1', 'foo2']);
      });
    });

    test('Food list cannot be modified from outside', () {
      var futureDatabase = FoodDatabase.create();
      futureDatabase.then((database) {
        var food = database.getFood();
        expect(food, ['foo0', 'foo1', 'foo2']);
        food.add('foo3');
        var newFood = database.getFood();
        expect(newFood, ['foo0', 'foo1', 'foo2']);
      });
    });

    test('Can add food to the database', () {
      var futureDatabase = FoodDatabase.create();
      futureDatabase.then((database) {
        database.addFood('foo3');
        var newFood = database.getFood();
        expect(newFood, ['foo0', 'foo1', 'foo2', 'foo3']);
      });
    });

    test('The added food has been stored persistently', () {
      var futureDatabase = FoodDatabase.create();
      futureDatabase.then((database) {
        database.addFood('foo3');
        var newFood = database.getFood();
        expect(newFood, ['foo0', 'foo1', 'foo2', 'foo3']);
      });
    });

    tearDownAll(() {
      var databaseFile = File(newFilePath);
      databaseFile.deleteSync();
    });
  });

  group('Can read food from a file that has comments', () {
    setUpAll(() async {
        var originalFile = File("${directoryPath}test_data/foodStuffComments.txt");
        originalFile.copy(newFilePath);
        PathProviderPlatform.instance = MockPathProviderPlatform();
      });

    test('Can read food from a file that has comments', () {
      var futureDatabase = FoodDatabase.create();
      futureDatabase.then((database) {
        var food = database.getFood();
        expect(food.length, 4);
        expect(food, ['foo0', 'foo1', 'foo2', 'foo3']);
      });
    });

    test('Can import food from a file with comments', () {
      var futureDatabase = FoodDatabase.create();
      futureDatabase.then((database) {
        database.importFood("${directoryPath}test_data/foodImportComments.txt");
        var food = database.getFood();
        expect(food.length, 6);
        expect(food, ['foo0', 'foo1', 'foo2', 'foo3', 'foo4', 'foo5']);
      });
    });

    tearDownAll(() {
      var databaseFile = File(newFilePath);
      databaseFile.deleteSync();
    });
  });

}
