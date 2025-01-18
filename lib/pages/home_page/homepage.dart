import 'package:app_mt_reserva/core/config/app_routes.dart';
import 'package:app_mt_reserva/core/ui/extensions/colors_extension.dart';
import 'package:app_mt_reserva/core/ui/extensions/size_extension.dart';
import 'package:app_mt_reserva/core/ui/extensions/text_style_extension.dart';
import 'package:app_mt_reserva/core/widgets/calculation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: context.colors.primary,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            width: context.screenWidth,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.colors.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Boas Vindas ao Algebrando!!',
                  style: context.textStyles.textTitle.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  'Selecione um cálculo para começar:',
                  style: context.textStyles.textSemiBold.copyWith(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: context.screenWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: const [
                    CalculationCard(
                      title: 'Progressão Aritmética (PA)',
                      asset: 'assets/img/i_pa.png',
                      route: AppRoutes.pa,
                    ),
                    CalculationCard(
                      title: 'Progressão Geométrica (PG)',
                      asset: 'assets/img/i_pg.png',
                      route: AppRoutes.pg,
                    ),
                    CalculationCard(
                      title: 'Porcentagem',
                      asset: 'assets/img/i_porcentagem.png',
                      route: AppRoutes.porcentagem,
                    ),
                    CalculationCard(
                      title: 'Proporção',
                      asset: 'assets/img/i_proporcao.png',
                      route: AppRoutes.proporcao,
                    ),
                    CalculationCard(
                      title: 'Pitagoras',
                      asset: 'assets/img/i_pitagoras.png',
                      route: AppRoutes.pitagoras,
                    ),
                    CalculationCard(
                      title: 'Perímetro do Quadrado',
                      asset: 'assets/img/i_perimetro_quadrado.png',
                      route: AppRoutes.perimetro,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
