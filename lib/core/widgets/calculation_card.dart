import 'package:app_mt_reserva/core/ui/extensions/text_style_extension.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculationCard extends StatelessWidget {
  final String title;
  final String asset;
  final String route;

  const CalculationCard({
    super.key,
    required this.title,
    required this.asset,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        children: [
          Image.asset(asset, height: 140, fit: BoxFit.fill),
          const SizedBox(height: 8),
          Flexible(
            child: AutoSizeText(
              title,
              maxLines: 1,
              minFontSize: 11,
              overflow: TextOverflow.ellipsis,
              style: context.textStyles.textRegular.copyWith(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
