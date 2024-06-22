import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

class Localization {
  static AppLocalizations _defaultLocalization = AppLocalizationsEn();
  static AppLocalizations _currentLocalization = _defaultLocalization;

  static AppLocalizations getLocalization(BuildContext context) {
    var localization = AppLocalizations.of(context);
    localization ??= _defaultLocalization;
    _currentLocalization = localization;
    return localization;
  }

  static AppLocalizations getCurrentLocalization() {
    return _currentLocalization;
  }
}
