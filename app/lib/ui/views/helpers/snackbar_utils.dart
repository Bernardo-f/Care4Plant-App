import 'package:flutter/material.dart';

import '../../../core/services/l10n/l10n_service.dart';

class SnackbarUtils {
  static void showNoAccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          L10nService.localizations.noAccesoInvernadero,
          style: const TextStyle(
            color: Color.fromRGBO(61, 87, 50, 1),
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        backgroundColor: const Color.fromRGBO(227, 235, 228, 1),
        duration: const Duration(milliseconds: 4000),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
