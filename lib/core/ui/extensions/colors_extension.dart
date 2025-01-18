import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primary => Colors.amber;
  Color get primaryDark => Colors.amber[800]!;
  Color get background => Colors.grey[100]!;
}

extension ColorsAppExcetions on BuildContext {
  ColorsApp get colors => ColorsApp.instance;
}
