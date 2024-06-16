// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:foodstuff/main.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
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
    PathProviderPlatform.instance = MockPathProviderPlatform();
      var originalFile = File("${directoryPath}test_data/foodStuff.txt");
      originalFile.copy(newFilePath);
  });

  testWidgets('Loading screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text('Please wait...'), findsOneWidget);
  });

  testWidgets('Generate food smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // wait 3 seconds to give the app time to finish loading
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('No food selected'), findsOneWidget);

    // Tap the next button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that new text appears
    expect(find.text('No food selected'), findsNothing);
  });

  tearDownAll(() {
    var databaseFile = File(newFilePath);
    databaseFile.deleteSync();
  });
}
