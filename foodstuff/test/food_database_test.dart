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
          return "${directoryPath}test_data";
      }
    }

void main() {

  setUp(() async {
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
    });
  });
}
