import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/services/l10n/l10n_service.dart';
import '../../../../provider/get_name_provider.dart';
import '../../../components/circular_primary_indicator.dart';
import '../../../helpers/layout_helpers.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GetNameProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return circularPrimaryColorIndicator;
        }

        if (provider.name != null) {
          return Center(
            child: Container(
              margin: EdgeInsets.only(top: heightPercentage(.05, context)),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              width: widthPercentage(.9, context),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(238, 239, 238, 1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(4, 5),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Text(
                L10nService.localizations.goodMorningMessage(provider.name!),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Color.fromRGBO(58, 60, 62, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          );
        }

        // Si no hay nombre y no está cargando, algo salió mal
        return const Center(child: Text(""));
      },
    );
  }
}
