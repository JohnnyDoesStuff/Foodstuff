import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

class Localization {
  static AppLocalizations _defaultLocalization = AppLocalizationsEn();

  static AppLocalizations getLocalization(BuildContext context) {
    var localization = AppLocalizations.of(context);
    localization ??= _defaultLocalization;
    return localization;
  }
}
