import 'package:app_mt_reserva/core/config/app_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Duração da animação
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Para suavizar a animação
    ));

    // Aguardar a animação terminar antes de navegar
    _controller.forward().whenComplete(() {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8D9C4),
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Image.asset(
            'assets/img/logox.jpg',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
