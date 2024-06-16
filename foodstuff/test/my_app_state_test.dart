import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foodstuff/my_app_state.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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
    PathProviderPlatform.instance = MockPathProviderPlatform();
    var originalFile = File("${directoryPath}test_data/foodStuffEmpty.txt");
    originalFile.copy(newFilePath);
  });

  test('getNextFood smoke test', () async {
    // arrange
    var myAppState = await MyAppState.create();

    // act
    myAppState.getNextFood();
    // assert
    expect(myAppState.current, 'No food is stored');
  });

  tearDownAll(() {
    var databaseFile = File(newFilePath);
    databaseFile.deleteSync();
  });
}
