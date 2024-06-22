import 'package:flutter/material.dart';
import 'package:foodstuff/localization.dart';

class InitializingPage extends StatelessWidget {
  InitializingPage();

  @override
  Widget build(BuildContext context) {
    var localization = Localization.getLocalization(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          localization.waiting,
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
