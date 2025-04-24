import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10nService {
  static late AppLocalizations _localizations;

  static void init(BuildContext context) {
    _localizations = AppLocalizations.of(context)!;
  }

  static AppLocalizations get localizations => _localizations;
}
