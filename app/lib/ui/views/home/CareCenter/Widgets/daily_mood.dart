import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../../../../../core/services/l10n/l10n_service.dart';
import '../../../../provider/reporte_diario_provider.dart';
import '../../../helpers/layout_helpers.dart';

const textColor = Color.fromRGBO(58, 60, 62, 1);
const unselectedTextColor = Color.fromRGBO(126, 118, 118, 1);

class DailyMood extends StatelessWidget {
  const DailyMood({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReporteDiarioProvider>(context);

    return Column(
      children: [
        SizedBox(
          width: widthPercentage(.8, context),
          child: Text(
            L10nService.localizations.dailyMoodTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(61, 87, 50, 1),
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 20),
        _EmojiRow(provider: provider),
      ],
    );
  }
}

class _EmojiRow extends StatelessWidget {
  final ReporteDiarioProvider provider;

  const _EmojiRow({required this.provider});

  static const List<String> _emojis = [
    'assets/img/face_great.svg.vec',
    'assets/img/face_good.svg.vec',
    'assets/img/face_okay.svg.vec',
    'assets/img/face_bad.svg.vec',
    'assets/img/face_awful.svg.vec',
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = L10nService.localizations;
    final textos = {
      0: l10n.feelingGreat,
      1: l10n.feelingGood,
      2: l10n.feelingOkay,
      3: l10n.feelingBad,
      4: l10n.feelingAwful,
    };

    return SizedBox(
      width: widthPercentage(.9, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _emojis.asMap().entries.map((entry) {
          final index = entry.key;
          final emojiPath = entry.value;
          final isSelected = provider.estadoReporte == (5 - index);

          return GestureDetector(
            onTap: () => provider.registerTest(5 - index),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? const Color.fromRGBO(246, 241, 173, 1) : null,
                  ),
                  child: SvgPicture(
                    AssetBytesLoader(emojiPath),
                    width: isSelected ? 50 : 40,
                    colorFilter: !isSelected && provider.estadoReporte != null
                        ? const ColorFilter.mode(unselectedTextColor, BlendMode.srcIn)
                        : null,
                  ),
                ),
                Text(
                  textos[index]!,
                  style: TextStyle(
                    fontSize: isSelected ? 18 : 14,
                    color: textColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
