import 'package:app_mt_reserva/core/config/app_routes.dart';
import 'package:app_mt_reserva/core/ui/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Matemático',
      theme: AppTheme.getThemeData(context),
      initialRoute: '/',
      routes: AppRoutes.getRoutes(),
    );
  }
}
