# FoodStuff

## Introduction
A tool to choose what to eat if you don't know again what to eat/cook today.

## Getting started
1. Install Flutter by following the [official documentation](https://flutter.dev/docs/get-started/install)

## Testing

### Setup code coverage tools on Windows via chocolatey

Install chocolatey: https://chocolatey.org/install

Refer to https://stackoverflow.com/questions/50789578/how-can-the-code-coverage-data-from-flutter-tests-be-displayed

```
choco install strawberryperl
choco install lcov
```

### Execute tests

To just run tests:

```sh
cd ./foodstuff
flutter test
```

To only run a particular test:
```sh
cd ./foodstuff
flutter test ./test/some_test.dart
```

To run tests and retrieve code coverage:

```PowerShell
cd ./foodstuff
flutter test .\test\food_database_test.dart --coverage

# convert the data to html (command for Windows)
perl C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml coverage/lcov.info -o coverage/html
```

## Troubleshooting

In case of a dirty environment run:
```
flutter clean
flutter pub cache repair
flutter pub run build_runner clean
```

## Additional information
Currently a customized Flutter runtime is required to use Realm.io. Therefor it is not being used in a productive environment yet.

Note: There have been some plans to maybe use Realm.io as an object oriented database. Right now only a plain text file is used for persistence
