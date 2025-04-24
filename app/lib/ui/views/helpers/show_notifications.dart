import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

import '../../../core/services/l10n/l10n_service.dart';

void showMessageNotifications(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: GestureDetector(
        onTap: () {
          AppSettings.openNotificationSettings();
        },
        child: Text(
          L10nService.localizations.requestPermissions,
          style: const TextStyle(
              color: Color.fromRGBO(61, 87, 50, 1), fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      backgroundColor: const Color.fromRGBO(227, 235, 228, 1),
      duration: const Duration(milliseconds: 4000),
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0, vertical: 10 // Inner padding for SnackBar content.
          ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
