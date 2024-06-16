import 'package:flutter/material.dart';

class InitializingPage extends StatelessWidget {
  InitializingPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Please wait...",
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
