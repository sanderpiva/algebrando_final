import 'package:app_mt_reserva/pages/home_page/homepage.dart';
import 'package:app_mt_reserva/pages/pa_calculation_screen.dart';
import 'package:app_mt_reserva/pages/percentage_calculation_screen.dart';
import 'package:app_mt_reserva/pages/pg_calculation_screen.dart';
import 'package:app_mt_reserva/pages/proportion_calculation_screen.dart';
import 'package:app_mt_reserva/pages/pythagoras_calculation_screen.dart';
import 'package:app_mt_reserva/pages/square_perimeter_calculation_screen.dart';
import 'package:app_mt_reserva/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String pa = '/pa';
  static const String pg = '/pg';
  static const String porcentagem = '/porcentagem';
  static const String proporcao = '/proporcao';
  static const String pitagoras = '/pitagoras';
  static const String perimetro = '/perimetro';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      home: (context) => const HomePage(),
      pa: (context) => const PACalculationScreen(),
      pg: (context) => const PGCalculationScreen(),
      porcentagem: (context) => const PercentageCalculationScreen(),
      proporcao: (context) => const ProportionCalculationScreen(),
      pitagoras: (context) => const PythagorasCalculationScreen(),
      perimetro: (context) => const SquarePerimeterCalculationScreen(),

    };
  }
}
